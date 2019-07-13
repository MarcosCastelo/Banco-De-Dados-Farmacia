﻿CREATE OR REPLACE FUNCTION BUSCAPRODUTO(NOME_PRODUTO VARCHAR(50)) RETURNS INTEGER AS $$
	DECLARE
		PROD_ID INTEGER;
	BEGIN
		SELECT PRODUTO_ID INTO PROD_ID FROM PRODUTO WHERE NOME LIKE NOME_PRODUTO;
		RETURN PROD_ID;
	END
	$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION BUSCALOCAL(L_ID INTEGER) RETURNS VARCHAR(50) AS $$
	DECLARE
		LOCAL_NOME VARCHAR(50);
	BEGIN
		SELECT LOCAL.BAIRRO INTO LOCAL_NOME FROM LOCAL WHERE LOCAL_ID = L_ID;
		RETURN LOCAL_NOME;
	END
	$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION VERIFICALOCAL(LOCAL_NOME VARCHAR(50)) RETURNS INTEGER AS $$
	DECLARE
		SEARCH_RESULT INTEGER;
	BEGIN
		SELECT LOJA_ID INTO SEARCH_RESULT FROM LOJA WHERE ENDERECO LIKE LOCAL_NOME;

		IF SEARCH_RESULT IS NULL THEN
			RETURN 1;
		ELSE
			RETURN SEARCH_RESULT;
		END IF;
	END

	$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION CADASTRACLIENTE(CPF VARCHAR(11), NOME VARCHAR(50), EMAIL VARCHAR(30), TELEFONE VARCHAR(11), DT_NASC DATE, ATIVO BOOLEAN) RETURNS VOID AS $$
	DECLARE
		ID INTEGER;
	BEGIN
		SELECT COUNT(*) INTO ID FROM CLIENTE;
		INSERT INTO CLIENTE VALUES(ID + 1, CPF, NOME, EMAIL, TELEFONE, DT_NASC, ATIVO);
	END;
	$$ LANGUAGE 'plpgsql';

	CREATE OR REPLACE FUNCTION busca_loja(nome_loja VARCHAR(50)) RETURNS INT as $$
	    DECLARE
	        id_loja INT;
	    BEGIN
	        SELECT loja_id FROM LOJA WHERE nome LIKE nome_loja INTO id_loja;
	        RETURN id_loja;
	    END
	$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION realizar_pedido(nome_prod VARCHAR(50), quant INT, nome_loja varchar(50)) RETURNS void as $$
    DECLARE
        id_prod INT;
        cod_forn INT;
        valor_prod DECIMAL;
        valor_compra DECIMAL;
        id_loja INT;
        id_compra INT;
        ID_ESTOQUE INT;
        preco_mercado DECIMAL;
    BEGIN

	IF nome_prod IS NULL THEN
		RAISE EXCEPTION 'insira um nome valido';
	END IF;
	IF QUANT IS NULL OR QUANT <= 0 THEN
		RAISE EXCEPTION 'QUANTIDADE PRECISA SER UM VALOR POSITIVO VÁLIDO';
	END IF;
	IF NOME_loja IS NULL THEN
		RAISE EXCEPTION 'INSIRA UMA LOJA VÁLIDO';
	END IF;
    
        SELECT BUSCAPRODUTO(nome_prod) INTO id_prod;
        SELECT fornecedor from PRECO WHERE produto=id_prod ORDER BY valor LIMIT 1 INTO cod_forn;
        SELECT valor FROM PRECO WHERE produto=id_prod AND FORNECEDOR=COD_FORN INTO valor_prod;
        SELECT busca_loja(nome_loja) INTO id_loja;
        valor_compra := valor_prod*quant;
        if EXISTS( SELECT * FROM COMPRA) THEN
		Select max(COMPRA_ID) + 1 into ID_COMPRA from COMPRA;
		INSERT INTO COMPRA VALUES(ID_COMPRA, cod_forn, valor_compra, CURRENT_DATE);
	ELSE
		ID_COMPRA := 1;
		INSERT INTO COMPRA VALUES(ID_COMPRA, cod_forn, valor_compra, CURRENT_DATE);
	END IF;

        -- Adicionando ao estoque um produto comprado pela 1ª vez
	IF NOT EXISTS(SELECT * FROM ESTOQUE WHERE loja_id=id_loja AND produto=id_prod) THEN
	    preco_mercado := sum(valor_prod, valor_prod*0.2);
	    INSERT INTO ESTOQUE VALUES(default, id_loja, id_prod, preco_mercado, 0);
	
	SELECT ESTOQUE_ID INTO ID_ESTOQUE FROM ESTOQUE WHERE PRODUTO_ID = ID_PROD AND LOJA_ID = ID_LOJA;
	
        INSERT INTO ITEM_COMPRA VALUES(DEFAULT, ID_COMPRA, ID_ESTOQUE, QUANT, VALOR_PROD);
        UPDATE ESTOQUE SET QUANTIDADE = QUANTIDADE + QUANT;
        
    END
$$ LANGUAGE plpgsql;
		
CREATE OR REPLACE FUNCTION realiza_venda (id_venda INTEGER, cpf VARCHAR(11), nome_prod VARCHAR(50), quant INT, NOME_receita VARCHAR(50), local_nome VARCHAR(50)) RETURNS VOID AS $$
	DECLARE
		id_loja INT;
		VALOR_ENTREGA DECIMAL;
		ID_LOCAL INT;
		ID_V INT;
		ID_ESTOQUE INT;
		ID_PRODUTO INT;
		VALOR_PRODUTO DECIMAL;
		cat_prod VARCHAR(50);
		RECEITA_NOME VARCHAR(50);
		ID_RECEITA INTEGER;
		
	BEGIN
		IF ID_VENDA IS NULL THEN
			RAISE EXCEPTION 'ID DE VENDA PRECISA SER INSERIDO';
		END IF;
		IF CPF IS NULL THEN
			RAISE EXCEPTION 'INSIRA UM CPF VÁLIDO';
		END IF;
		IF NOME_PROD IS NULL THEN
			RAISE EXCEPTION 'PRODUTO NAO PODE SER NULO';
		END IF;
		IF QUANT IS NULL OR QUANT <= 0 THEN
			RAISE EXCEPTION 'QUANTIDADE PRECISA SER UM VALOR POSITIVO VÁLIDO';
		END IF;
		IF NOME_LOCAL IS NULL THEN
			RAISE EXCEPTION 'INSIRA UM LOCAL VÁLIDO';
		END IF;

		
	
		SELECT PRODUTO_ID INTO ID_PRODUTO FROM PRODUTO WHERE NOME LIKE NOME_PROD;
		IF PRODUTO_ID IS NULL THEN
			RAISE EXCEPTION 'O MEDICAMENTO NÃO CONSTA NO BANCO DE DADOS!';
		END IF;
		SELECT CATEGORIA INTO CAT_PROD FROM PRODUTO WHERE PRODUTO_ID = ID_PRODUTO;
		
		IF CAT_PROD = 'PRETA' AND RECEITA IS NULL OR CAT_PROD = 'VERMELHA' AND RECEITA IS NULL THEN
			RAISE EXCEPTION 'ESTE MEDICAMENTO REQUER RECEITA!';
		END IF;
		
		SELECT LOJA_ID INTO ID_LOJA FROM LOJA WHERE ENDERECO LIKE LOCAL_NOME;
		SELECT VALOR INTO VALOR_ENTREGA FROM LOCAL WHERE BAIRRO LIKE LOCAL_NOME;

		IF ID_LOJA IS NULL AND VALOR_ENTREGA IS NULL THEN
			RAISE EXCEPTION 'NÃO É POSSÍVEL REALIZAR ENTREGAS PARA ESTE LOCAL';
		ELSIF VALOR_ENTREGA IS NOT NULL THEN
			ID_LOJA := 1;
		END IF;

		SELECT LOCAL_ID INTO ID_LOCAL FROM LOCAL WHERE BAIRRO LIKE LOCAL_NOME;
		SELECT ESTOQUE_ID INTO ID_ESTOQUE FROM ESTOQUE WHERE PRODUTO = ID_PRODUTO AND LOJA_ID = ID_LOJA;
		SELECT VALOR INTO VALOR_PRODUTO FROM ESTOQUE WHERE ESTOQUE_ID = ID_ESTOQUE;
		
		IF EXISTS(SELECT VENDA_ID FROM VENDA WHERE VENDA_ID = ID_VENDA) THEN
			UPDATE VENDA SET HORA_DATE = NOW(), VALOR_TOTAL = VALOR_PRODUTO * QUANT + VALOR_TOTAL WHERE VENDA_ID = ID_VENDA;
			INSERT INTO ITEM_VENDA VALUES(DEFAULT, ID_VENDA, ID_ESTOQUE, QUANT, VALOR_PRODUTO);
			UPDATE ESTOQUE SET QUANTIDADE = QUANTIDADE - QUANT WHERE ESTOQUE_ID = ID_ESTOQUE;
		ELSE
			SELECT MAX(*) + 1 INTO ID_V FROM VENDA;
			IF ID_V IS NULL THEN
				ID_V := 1;
			END IF;
			
			INSERT INTO VENDA VALUES(ID_VENDA, CPF, ID_LOCAL, NOW(), VALOR_PRODUTO * QUANT);
			INSERT INTO ITEM_VENDA VALUES (DEFAULT, ID_VENDA, ID_ESTOQUE, QUANT, VALOR_PRODUTO);
			UPDATE ESTOQUE SET QUANTIDADE = QUANTIDADE - QUANT WHERE ESTOQUE_ID = ID_ESTOQUE;
		END IF;
	END
	$$ LANGUAGE 'plpgsql';


