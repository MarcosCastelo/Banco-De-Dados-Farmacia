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
