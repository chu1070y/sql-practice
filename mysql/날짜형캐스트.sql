-- 날짜형 함수
select curdate(), current_date;
select curtime(), current_time;
select now(), sysdate(), current_timestamp;

select now(), sleep(2), now();
select sysdate(), sleep(2), sysdate();

select date_format(now(), '%Y-%c-%d %h:%i:%s'); 

SELECT concat(first_name, ' ', last_name) AS name,               
       PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m'),  
                    DATE_FORMAT(hire_date, '%Y%m') )
  FROM employees; 

select first_name,
       hire_date,
       date_add(hire_date, interval 5 MONTH)
  from employees;
  
  select now(), cast(now() as date);
  select cast(1-2 as unsigned);
  select cast(cast(1-2 as unsigned) as signed);