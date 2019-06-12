create type mood as enum('sad', 'ok', 'happy');
create table person(
	name varchar(10),
	current_mood mood
);

insert into person values('you', 'happy');
insert into person values('me', 'ok');
-- insert into person values('her', 'crazy');

select * from person;
select * from person where current_mood > 'ok'; 