-- 문자형 함수
select upper('SeouL'), ucase('seoul');
select lower('SeouL'), lcase('SEOUL');
select substring('Happy Day', 3, 2);
  SELECT concat( first_name, ' ', last_name ) AS 이름,
         hire_date AS 입사일
    FROM employees
   WHERE substring(hire_date, 1, 4) = '1989';

select lpad('123456', 10, '-'), rpad('123456', 10, '-');

SELECT emp_no, LPAD(salary, 10, '*')      
  FROM salaries     
 WHERE from_date like '2001-%'       
   AND salary < 70000;

select concat('---', LTRIM(' hello '), '---'),
       concat('---', RTRIM(' hello '), '---'),
       concat('---', TRIM(' hello '), '---'),
       concat('---', TRIM(both 'x' from 'xxxxhelloxxxxx'), '---');