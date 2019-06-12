-- 문자형
select upper('SeouL');

select lower('SeouL');

select substring('Happy Day', 3, 2);

SELECT concat( first_name, ' ', last_name ) AS ÀÌ¸§,
       hire_date AS ÀÔ»çÀÏ
  FROM employees
 WHERE substring(to_char(hire_date, 'yyyy-mm-dd'), 1, 4) = '1989';

select lpad('123456', 10, '-'), rpad('123456', 10, '-');

SELECT emp_no, LPAD(cast(salary as char), 10, '*')      
  FROM salaries     
 WHERE to_char(from_date, 'yyyy-mm-yy') like '2001-%'       
   AND salary < 70000;
  
select concat('---', LTRIM(' hello '), '---'),
       concat('---', RTRIM(' hello '), '---'),
       concat('---', TRIM(' hello '), '---'),
       concat('---', TRIM(both 'x' from 'xxxxhelloxxxxx'), '---');
  