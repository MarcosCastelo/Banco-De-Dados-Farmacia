CREATE FUNCTION maioridade() RETURNS trigger AS $maioridade$
    BEGIN
	IF EXTRACT(YEAR FROM age(NEW.data_nascimento)) < 18 THEN
	    RAISE EXCEPTION 'O cliente não pode ser menor de idade';
	END IF;

	RETURN NEW;
    END;
$maioridade$ LANGUAGE plpgsql;

CREATE TRIGGER maioridade BEFORE INSERT OR UPDATE ON cliente FOR EACH ROW EXECUTE PROCEDURE maioridade();
