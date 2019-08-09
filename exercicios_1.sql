-- incrementar um dado
CREATE FUNCTION incrementar(int) RETURNS int AS $$
BEGIN
	RETURN $1 + 1;
END;
$$ LANGUAGE plpgsql;

SELECT incrementar(5);


-- retornar texto do parametro
CREATE FUNCTION retornar(text) RETURNS text AS $$
BEGIN
	RETURN $1;
END;
$$ LANGUAGE plpgsql;


-- tabela
CREATE TABLE users (
	id int,
	nome varchar(50)
);

INSERT INTO users VALUES (1, 'abacate');
INSERT INTO users VALUES (2, 'morango');
INSERT INTO users VALUES (3, 'melancia');
INSERT INTO users VALUES (4, 'laranja');
INSERT INTO users VALUES (5, 'caqui');

CREATE or REPLACE FUNCTION maior_media() RETURNS record AS $$
DECLARE
	r record;
BEGIN
	SELECT * INTO r FROM users WHERE id > (
		SELECT avg(id) FROM users
	);
	RETURN r.id || r.nome;
END;
$$ LANGUAGE plpgsql;


CREATE or REPLACE FUNCTION maior_media2() RETURNS TABLE(nome2 varchar(50)) AS $$
BEGIN
	RETURN QUERY SELECT nome FROM users WHERE id > (
		SELECT avg(id) FROM users
	);
END;
$$ LANGUAGE plpgsql;

select nome2 from maior_media2();
