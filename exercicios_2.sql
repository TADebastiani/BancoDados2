create TABLE IF NOT EXISTS dados (
	id int,
	nome varchar(50),
	descricao varchar(50),
	apelido varchar(50),
	salario float
);
-- INSERT INTO dados
-- VALUES
-- 	(1, 'Professor Girafales', 'Bom professor', 'Prof. Linguiça', 3000),
-- 	(2, 'Professor Um', 'Descricao Um', 'Um', 1235),
-- 	(2, 'Professor Dois', 'Descricao Dois', 'Dois', 1346),
-- 	(3, 'Professor Tres', 'Descricao Tres', 'Tres', 1987),
-- 	(4, 'Professor Quatro', 'Descricao Quatro', 'Quatro', 2566);

create or replace function aumento_10()
RETURNS boolean as $$
    begin
    	update dados set salario = salario + (salario * 0.10);
        
		return found;
	end;
$$ language plpgsql;


create or replace function aumento(idU int, aumento float) 
returns boolean as $$
	begin
		update dados set salario = salario + aumento where id = idU;
		return found;
	end;
$$ language plpgsql;
