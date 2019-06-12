-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 
-- 출력해보세요. 

-- 1)
select b.dept_no
  from employees a, dept_emp b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and concat(a.first_name, ' ', a.last_name) = 'Fai Bale';

-- 2)
select a.emp_no, a.first_name
  from employees a, dept_emp b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and b.dept_no = 'd004';

-- subquery
select a.emp_no, a.first_name
  from employees a, dept_emp b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and b.dept_no = (select b.dept_no
					 from employees a, dept_emp b
					where a.emp_no = b.emp_no
					  and b.to_date = '9999-01-01'
                      and concat(a.first_name, ' ', a.last_name) = 'Fai Bale');

-- 단일행인 경우
-- <, >, =, !=, <=, >=

-- ex1) 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를 나타내세요.
SELECT 
    a.first_name, b.salary
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND b.salary < (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01')
ORDER BY b.salary DESC;

-- 현재 가장적은 평균급여를 받고 있는 직책에 대해서  평균 급여를 구하세요   
-- ex2-1)                     
SELECT 
    b.title, ROUND(AVG(a.salary)) AS avg_salary
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
HAVING avg_salary = (SELECT 
        MIN(avg_salary)
    FROM
        (SELECT 
            ROUND(AVG(a.salary)) AS avg_salary
        FROM
            salaries a, titles b
        WHERE
            a.emp_no = b.emp_no
                AND a.to_date = '9999-01-01'
                AND b.to_date = '9999-01-01'
        GROUP BY b.title) a);

-- ex2-2) TOP-K
SELECT 
    b.title, AVG(a.salary) AS avg_salary
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY avg_salary asc
   LIMIT 0, 1;

   
-- 다중행
-- in (not in)
-- any
-- =any(in 동일), >any, <any, <>any(!=All 동일), <=any, >=any
-- all
-- =all, >all, <all, <=all, >=a
   

-- 예제:현재 급여가 50000 이상인 직원 이름 출력
-- sol1) 조인해결
select a.first_name,  b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and b.salary > 50000;
   
-- sol2) 서브쿼리 해결
select a.first_name,  b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and (a.emp_no, b.salary) =any (select emp_no, salary
									from salaries
								   where to_date = '9999-01-01'
									 and salary > 50000);
select a.first_name,  b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and (a.emp_no, b.salary) in (select emp_no, salary
									from salaries
								   where to_date = '9999-01-01'
									 and salary > 50000);
select a.first_name, b.salary   
  from employees a,
       (select emp_no, salary
	  	  from salaries
         where to_date = '9999-01-01'
           and salary > 50000) b
 where a.emp_no = b.emp_no;          
        

-- 각 부서별로 최고월급을 받는 직원의 이름과 월급을 출력
select c.dept_no, max(b.salary) as max_salary
  from employees a, salaries b, dept_emp c
 where a.emp_no = b.emp_no
   and b.emp_no = c.emp_no
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01'
group by c.dept_no;

-- sol1) where 절에 subquery를 사용
select a.first_name, c.dept_no, b.salary
  from employees a, salaries b, dept_emp c
 where a.emp_no = b.emp_no
   and b.emp_no = c.emp_no
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01'
   and (c.dept_no, b.salary) =any (select c.dept_no, max(b.salary) as max_salary
  from employees a, salaries b, dept_emp c
 where a.emp_no = b.emp_no
   and b.emp_no = c.emp_no
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01'
group by c.dept_no);

-- sol2) from절에 subquery를 사용하는 방법
select a.first_name, c.dept_no, b.salary
  from employees a, salaries b, dept_emp c,
       (select c.dept_no, max(b.salary) as max_salary
		  from employees a, salaries b, dept_emp c
        where a.emp_no = b.emp_no
          and b.emp_no = c.emp_no
          and b.to_date = '9999-01-01'
          and c.to_date = '9999-01-01'
        group by c.dept_no) d
 where a.emp_no = b.emp_no
   and b.emp_no = c.emp_no
   and c.dept_no = d.dept_no
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01'
   and b.salary = d.max_salary;


