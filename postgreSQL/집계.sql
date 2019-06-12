-- 집계 SQL 

  select emp_no, avg(salary)
    from salaries
   where to_char(from_date, 'yyyy') = '1985' 
group by emp_no
  having avg(salary) > 1000;
  
 
-- 예제1 : 각 사원별로 평균연봉 출력
   select emp_no, avg(salary)
     from salaries
 group by emp_no
 order by avg(salary) desc;

-- 예제 3:  사원(별) 몇 번의 직책 변경이 있었는지 조회 
   select emp_no, count(title)
     from titles
 group by emp_no; 
 
-- 예제4 : 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
   select emp_no, avg(salary)
     from salaries
 group by emp_no
   having avg(salary) > 50000;
   
-- 예제5: (현재) 직책별로 (평균연봉)과 인원수를 구하되 직책별로 인원이 
--       100명 이상인 직책만 출력하세요.
   select title, count(emp_no)
     from titles
    where to_date = '9999-01-01' 
 group by title
   having count(emp_no) >= 100;  