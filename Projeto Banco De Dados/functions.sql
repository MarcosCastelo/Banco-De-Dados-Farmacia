﻿CREATE OR REPLACE FUNCTION BUSCAPRODUTO(NOME_PRODUTO VARCHAR(50)) RETURNS INTEGER AS $$
	DECLARE
		PROD_ID INTEGER;
	BEGIN
		SELECT PRODUTO_ID INTO PROD_ID FROM PRODUTO WHERE NOME LIKE NOME_PRODUTO;
		RETURN PROD_ID;
	END
	$$ LANGUAGE plpgsql;

DROP FUNCTION BUSCALOCAL;

CREATE OR REPLACE FUNCTION BUSCALOCAL(L_ID INTEGER) RETURNS VARCHAR(50) AS $$
	DECLARE
		LOCAL_NOME VARCHAR(50);
	BEGIN
		SELECT LOCAL.BAIRRO INTO LOCAL_NOME FROM LOCAL WHERE LOCAL_ID = L_ID;
		RETURN LOCAL_NOME;
	END
	$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION VERIFICALOCAL(L_ID INTEGER) RETURNS INTEGER AS $$
	DECLARE
		LOCAL_NOME VARCHAR(50);
		SEARCH_RESULT INTEGER;
	BEGIN
		LOCAL_NOME := BUSCALOCAL(L_ID);
		SELECT LOJA_ID INTO SEARCH_RESULT FROM LOJA WHERE ENDERECO LIKE LOCAL_NOME;

		IF SEARCH_RESULT = NULL THEN
			RETURN 1;
		ELSE
			RETURN L_ID;
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

	CREATE OR REPLACE FUNCTION realizar_pedido(nome_prod VARCHAR(50), quant INT, nome_loja) RETURNS void as $$
	    DECLARE
	        id_prod INT;
	        cod_forn INT;
	        valor_prod DECIMAL;
	        valor_compra DECIMAL;
	        id_loja INT;
	    BEGIN
	        SELECT BUSCAPRODUTO(nome_prod) INTO id_prod;

	        SELECT fornecedor from PRECO WHERE produto=id_prod ORDER BY valor LIMIT 1 INTO forn;

	        INSERT INTO COMPRA VALUES(default, cod_forn, CURRENT_DATE);

	        SELECT valor FROM PRECO WHERE produto=id_prod INTO valor_prod;

	        valor_compra := valor_prod*quant;

	        SELECT busca_loja(nome_loja) INTO id_loja;

	        -- To do: manipular ITEM_COMPRA

	    END
	$$ LANGUAGE plpgsql;
