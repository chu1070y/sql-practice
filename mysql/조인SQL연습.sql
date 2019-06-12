-- join

-- employees 테이블과 titles 테이블을 
-- join하여 직원의 이름과 직책을 출력하되 
-- 여성 엔지니어만 출력하세요.

select a.first_name, b.title, a.gender
  from employees a, titles b
 where a.emp_no = b.emp_no
   and a.gender = 'f';
 
-- 예제6: 현재 부서별로 현재 직책이 
-- Engineer인 직원들에 대해서만 
-- 평균급여를 구하세요.
  select c.dept_no, d.dept_name, avg(a.salary)
	from salaries a, titles b, dept_emp c, departments d
   where a.emp_no = b.emp_no
     and b.emp_no = c.emp_no
     and c.dept_no = d.dept_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
     and b.title = 'Engineer'
group by c.dept_no;   
   
-- 예제7: 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요
--       단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에
--       대해서 내림차순(DESC)로 정렬하세요.   

  select title, sum(salary)
    from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by title
  having sum(salary) > 2000000000
order by sum(salary) desc;


--
-- ANSI/ISO SQL 1999 join 문법
--

-- join ~ on
select count(*)
  from employees a 
  join titles b on a.emp_no = b.emp_no
 where a.gender = 'f';  

-- natural join
select count(*)
  from employees a 
  join titles b
 where a.gender = 'f';
 
-- join ~ using 
select count(*)
  from employees a 
  join titles b 
  using (emp_no)
 where a.gender = 'f';  

-- 실습문제 1:현재 회사 상황을 반영한 직원별 근무부서를 
-- 사번, 직원 전체이름, 근무부서 형태로 출력해 보세요.
select a.first_name, b.dept_no, c.dept_name
  from employees a
  left join dept_emp b on a.emp_no = b.emp_no
  join departments c on b.dept_no = c.dept_no
 where b.dept_no = c. dept_no
   and b.to_date = '9999-01-01'
   and b.dept_no is null;
