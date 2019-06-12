drop table member1;
create table member1(
	no int,
	email varchar(50) not null default '',
	password varchar(50) not null,
	name varchar(25),
	dept_name varchar(25),
	primary key(no)
);

-- 새 컬럼 추가
alter table member1 add juminbunho char(13) not null;
alter table member1 add join_date timestamp not null;

-- 컬럼 삭제
alter table member1 drop juminbunho;

-- 컬럼 타입 변경
alter table member1 alter column no type bigint using no::bigint

-- not null 셋팅
alter table member1 alter column no set not null;
alter table member1 alter column dept_name set not null;

-- not null 빼자
alter table member1 alter column dept_name drop not null;

-- default 세팅
create sequence member1_seq;
alter table member1 alter column no set default nextval('member1_seq');

-- 컬럼 이름 변경
alter table member1 rename column dept_name to department_name;

-- 테이블 이름 변경
alter table member1 rename to member2; 





