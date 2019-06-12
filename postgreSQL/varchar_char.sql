create table t3(
	c3 char(4)
);

insert into t3 values('ok');
-- insert into t3 values('too long');
select c3, char_length(c3) from t3;


create table t4(
	c4 varchar(5)
);
insert into t4 values('ok');
insert into t4 values('good          ');
-- insert into t4 values('too long');
insert into t4 values('too long'::varchar(5));

select c4, char_length(c4) from t4;

