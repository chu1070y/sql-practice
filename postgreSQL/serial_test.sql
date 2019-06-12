-- serial vs sequence
create table t1(
	c1 serial
);
insert into t1 values(default);
select *from t1;

create sequence t2_seq;
create table t2(
	c2 int not null default nextval('t2_seq') 
);
alter sequence t2_seq owned by t2.c2;

insert into t2 values(default);
select *from t2;
