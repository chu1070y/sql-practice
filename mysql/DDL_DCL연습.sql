-- DDL 

drop table member;

create table member(
	no int not null,
    email varchar(50) not null default '',
    passwd varchar(64) not null,
    name varchar(25),
    dept_name varchar(25),
    primary key(no)
);

desc member;

alter table member add juminbunho char(13) not null after no;
alter table member drop juminbunho;
alter table member add join_date datetime not null;

alter table member change no no int unsigned not null auto_increment;
alter table member change dept_name department_name varchar(25);
alter table member change name name varchar(10);
-- drop table member;


alter table member rename user;

desc user;

-- DCL(insert)

insert
  into user
values(null, '',  password('1234'), '안대혁2', '시스템개발팀', now());

insert
  into user(join_date, name, passwd, department_name) 
values(now(), '안대혁4', password('1234'), '시스템개발팀');

update user
   set join_date = (select now())
 where no = 1;

update user
   set join_date = now(),
       name = 'Ahn D. Hyuck'
where  no = 1;
    
delete from user where no = 1; 

select * from user;