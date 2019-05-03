
-- 기본 SQL 문제 --

-- 문제1.
-- 결과: Remko Zyda
select concat(first_name, ' ', last_name) as '전체이름' from employees where emp_no = '10944';

-- 문제2.
-- 결과: sql 실행하세요
select
	concat(first_name, ' ', last_name) as '이름',
    gender as '성별',
    hire_date as '입사일'
from 
	employees
order by
	hire_date asc
;

-- 문제3.
-- 결과: 남직원 수 - 179973명 / 여직원 수 - 120051명
select
	(select count(emp_no) from employees where gender = 'M') as '남직원 수',
    (select count(emp_no) from employees where gender = 'F') as '여직원 수'
;

-- 문제4.
-- 결과: 240124명
select count(emp_no) as '현재 근무직원 수' from salaries where to_date > now();

-- 문제5.
-- 결과: 9개
select count(distinct dept_no) as '부서 갯수' from dept_emp;

-- 문제6.
-- 결과: 9명
select count(*) as '부서 매니저 수' from dept_manager where to_date > now();

-- 문제7.
-- 결과: sql 실행하세요
select * from departments order by length(dept_name) desc;

-- 문제8.
-- 결과: 2159명
select count(emp_no) as cnt from salaries where salary >= 120000 and to_date > now();

-- 문제9.
-- 결과: sql 실행하세요
select title from titles group by title order by length(title) desc;

-- 문제10.
-- 결과: 30983 명
select
	count(employees.emp_no) as '엔지니어 수'
from
	employees, 
	(select emp_no from titles where title = 'Engineer' and to_date > now()) as engineer
where
	employees.emp_no = engineer.emp_no
;

-- 문제11.
-- 결과: sql 실행하세요
select * from titles where emp_no='13250' order by from_date;
