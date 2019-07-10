﻿CREATE OR REPLACE FUNCTION maioridade() RETURNS trigger AS $maioridade$
    BEGIN
	IF EXTRACT(YEAR FROM age(NEW.data_nascimento)) < 18 THEN
	    RAISE EXCEPTION 'O cliente não pode ser menor de idade';
	END IF;
	IF EXTRACT(YEAR FROM AGE(NEW.DATA_NASCIMENTO)) > 120 THEN
		RAISE EXCEPTION 'INSIRA UMA DATA VALIDA';
	END IF;

	RETURN NEW;
    END;
$maioridade$ LANGUAGE plpgsql;

CREATE TRIGGER maioridade BEFORE INSERT OR UPDATE ON cliente FOR EACH ROW EXECUTE PROCEDURE maioridade();

CREATE OR REPLACE FUNCTION CLIENTENULO() RETURNS TRIGGER AS $$
	DECLARE
		TAMANHO_CPF INTEGER;
		TAMANHO_NOME INTEGER;
		TAMANHO_TELEFONE INTEGER;
		TAMANHO_EMAIL INTEGER;
	BEGIN
		SELECT LENGTH(NEW.CPF) INTO TAMANHO_CPF;
		SELECT LENGTH(NEW.NOME) INTO TAMANHO_NOME;
		SELECT LENGTH(NEW.TELEFONE) INTO TAMANHO_TELEFONE;
		SELECT LENGTH(NEW.EMAIL) INTO TAMANHO_EMAIL;

		IF TAMANHO_CPF != 11 THEN
			RAISE EXCEPTION 'INSIRA UM CPF VÁLIDO!';
		END IF;
		IF NEW.NOME = '' THEN
			RAISE EXCEPTION 'NOME NÃO PODE SER NULO!';
		END IF;
		IF TAMANHO_NOME > 50 THEN
			RAISE EXCEPTION 'NOME MUITO GRANDE!';
		END IF;
		IF NEW.EMAIL = NULL THEN
			RAISE EXCEPTION 'EMAIL NÃO PODE SER NULO!';
		END IF;
		IF TAMANHO_EMAIL > 50 THEN
			RAISE EXCEPTION 'EMAIL MUITO GRANDE!';
		END IF;
		IF TAMANHO_TELEFONE != 11 THEN
			RAISE EXCEPTION 'INSIRA UM TELEFONE VÁLIDO!';
		END IF;
		RETURN NEW;
	END;
	$$ LANGUAGE PLPGSQL;

CREATE TRIGGER CLIENTEDISPARA BEFORE INSERT ON CLIENTE FOR EACH ROW EXECUTE PROCEDURE CLIENTENULO();

SELECT CADASTRACLIENTE('12312312312', 'ADF', '123', '12312312312', '01-01-1880');
SELECT * FROM CLIENTE;

CREATE OR REPLACE FUNCTION marca_nula() RETURNS trigger AS $marca_nula$
    BEGIN
	IF NEW.nome = '' THEN
	    RAISE EXCEPTION 'Nome nulo';
	END IF;

	RETURN NEW;

    END;
$marca_nula$ LANGUAGE plpgsql;

CREATE TRIGGER marca_nula BEFORE INSERT OR UPDATE ON MARCA FOR EACH ROW EXECUTE PROCEDURE marca_nula();

CREATE OR REPLACE FUNCTION produto_nulo() RETURNS trigger AS $produto_nulo$
    BEGIN
	IF NEW.nome = '' THEN
	    RAISE EXCEPTION 'Nome nulo';
	END IF;

	RETURN NEW;
    END;
$produto_nulo$ LANGUAGE plpgsql;

CREATE TRIGGER produto_nulo BEFORE INSERT OR UPDATE ON produto FOR EACH ROW EXECUTE PROCEDURE produto_nulo();

CREATE OR REPLACE FUNCTION categoria_nula() RETURNS trigger AS $categoria_nula$
    BEGIN
	IF NEW.nome = '' THEN
	    RAISE EXCEPTION 'Nome nulo';
	END IF;

	RETURN NEW;
    END;
$categoria_nula$ LANGUAGE plpgsql;

CREATE TRIGGER categoria_nula BEFORE INSERT OR UPDATE ON CATEGORIA FOR EACH ROW EXECUTE PROCEDURE categoria_nula();

CREATE OR REPLACE FUNCTION medico_nulo() RETURNS trigger AS $medico_nulo$
    BEGIN
	IF NEW.nome = '' THEN
	    RAISE EXCEPTION 'Nome nulo';
	END IF;

	IF NEW.crm = '' THEN
	    RAISE EXCEPTION 'CRM nulo';
	END IF;

	IF NEW.telefone = '' THEN
	    RAISE EXCEPTION 'Telefone nulo';
	END IF;

	RETURN NEW;
    END;
$medico_nulo$ LANGUAGE plpgsql;

CREATE TRIGGER medico_nulo BEFORE INSERT OR UPDATE ON MEDICO FOR EACH ROW EXECUTE PROCEDURE medico_nulo();

CREATE OR REPLACE FUNCTION local_nulo() RETURNS trigger AS $local_nulo$
    BEGIN
	IF NEW.bairro = '' THEN
	    RAISE EXCEPTION 'Bairro nulo';
	END IF;

	RETURN NEW;
    END;
$local_nulo$ LANGUAGE plpgsql;

CREATE TRIGGER local_nulo BEFORE INSERT OR UPDATE ON LOCAL FOR EACH ROW EXECUTE PROCEDURE local_nulo();

CREATE OR REPLACE FUNCTION loja_nula() RETURNS trigger AS $loja_nula$
    BEGIN
	IF NEW.nome = '' THEN
	    RAISE EXCEPTION 'Nome nulo';
	END IF;

	IF NEW.endereco = '' THEN
	    RAISE EXCEPTION 'Endereço nulo';
	END IF;

	RETURN NEW;
    END;
$loja_nula$ LANGUAGE plpgsql;

CREATE TRIGGER loja_nula BEFORE INSERT OR UPDATE ON LOJA FOR EACH ROW EXECUTE PROCEDURE loja_nula();
