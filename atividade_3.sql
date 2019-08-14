create table if not exists PageRevision(
	name varchar(50),
	date date,
	author varchar(50),
	text text
);

create table if not exists PageAudit(
	name varchar(50),
	author  varchar(50),
	date date,
	users varchar(50),
	dif_len int
);

create or replace function logger() returns trigger as $$
	declare 
		len int;
	begin
		IF OLD.text = NULL THEN
			len := length(NEW.text);
		ELSE
			len := length(NEW.text) - length(OLD.text);
		END IF;
		insert into PageAudit values
			(NEW.name, NEW.author, current_timestamp,current_user, len);

		return NEW;
	end;
$$ language plpgsql;

create trigger logger_trig before insert or update on PageRevision
	for each row execute procedure logger();