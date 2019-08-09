create table if not exists emp (
	empname text,
	salary integer,
	last_date timestamp,
	last_user text
);


create or replace function emp_time() returns trigger as $$
	begin
		NEW.last_date := current_timestamp;
		NEW.last_user := current_user;
		NEW.salary := NEW.salary + (NEW.salary * 0.10);
		return NEW;
	end;
$$ language plpgsql;


create trigger  emp_time before insert or update on emp
	for each row execute procedure emp_time();

insert into emp(empname, salary) values ('joao', 1000);
