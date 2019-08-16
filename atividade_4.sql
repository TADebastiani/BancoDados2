create table if not exists cliente (
	numero int primary key,
	cpf int,
	nome varchar(50)
);

begin;
	insert into cliente values (1,349875433,'João');
	insert into cliente values (2,234567847,'Maria');
	insert into cliente values (3,334342879,'Francisco');
end;

begin;
	insert into cliente values (4,523894797,'Jose');
	insert into cliente values (5,834569433,'Chico');
	insert into cliente values (6,334342879,'Adalberto','!!');
end;

begin;
	insert into cliente values (6,334342879,'Adalberto');
	insert into cliente values (6,334342879,'Adalberto');
end;

