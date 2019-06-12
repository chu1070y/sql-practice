-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
SELECT 
    COUNT(emp_no)
FROM
    salaries
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01')
        AND to_date = '9999-01-01'
;

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    b.dept_name '부서',
    b.maximum '연봉'
FROM
    employees a,
    (SELECT 
        a.emp_no, MAX(b.salary) AS maximum, d.dept_name
    FROM
        employees a, salaries b, dept_emp c, departments d
    WHERE
        a.emp_no = b.emp_no
            AND a.emp_no = c.emp_no
            AND c.dept_no = d.dept_no
            AND b.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01'
    GROUP BY c.dept_no) b
WHERE
    a.emp_no = b.emp_no
ORDER BY b.maximum DESC
;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    b.salary '연봉'
FROM
    employees a,
    salaries b,
    dept_emp c,
    (SELECT 
        c.dept_no, AVG(b.salary) AS avg_salary
    FROM
        employees a, salaries b, dept_emp c
    WHERE
        a.emp_no = b.emp_no
            AND a.emp_no = c.emp_no
            AND b.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01'
    GROUP BY c.dept_no) d
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND c.dept_no = d.dept_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND b.salary > d.avg_salary
;


-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    c.manager_name '매니저 이름',
    c.dept_name '부서이름'
FROM
    employees a,
    dept_manager b,
    (SELECT 
        a.dept_no,
            c.dept_name,
            CONCAT(b.first_name, ' ', b.last_name) AS manager_name
    FROM
        dept_manager a, employees b, departments c
    WHERE
        a.emp_no = b.emp_no
            AND a.dept_no = c.dept_no
            AND to_date = '9999-01-01') c
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
;

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    c.title '직책',
    b.salary '연봉'
FROM
    employees a,
    salaries b,
    titles c,
    dept_emp d
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND a.emp_no = d.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
        AND d.dept_no = (SELECT 
            dept_no
        FROM
            (SELECT 
                c.dept_no, AVG(b.salary) AS avg_salary
            FROM
                employees a, salaries b, dept_emp c
            WHERE
                a.emp_no = b.emp_no
                    AND a.emp_no = c.emp_no
                    AND b.to_date = '9999-01-01'
                    AND c.to_date = '9999-01-01'
            GROUP BY c.dept_no
            ORDER BY avg_salary DESC) a
        LIMIT 1)
ORDER BY b.salary
;


-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no = (SELECT 
            dept_no
        FROM
            (SELECT 
                c.dept_no, AVG(b.salary) AS avg_salary
            FROM
                employees a, salaries b, dept_emp c
            WHERE
                a.emp_no = b.emp_no
                    AND a.emp_no = c.emp_no
                    AND b.to_date < c.to_date
                    AND b.to_date > c.from_date
            GROUP BY c.dept_no
            ORDER BY avg_salary DESC
            LIMIT 1) a)
;


-- 문제7.
-- 평균 연봉이 가장 높은 직책?
SELECT 
    title
FROM
    (SELECT 
        c.title, AVG(b.salary) AS avg_salary
    FROM
        employees a, salaries b, titles c
    WHERE
        a.emp_no = b.emp_no
            AND a.emp_no = c.emp_no
            AND b.to_date < c.to_date
            AND b.to_date > c.from_date
    GROUP BY c.title
    ORDER BY avg_salary DESC
    LIMIT 1) a
;


-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
SELECT 
    d.dept_name '부서이름',
    CONCAT(a.first_name, ' ', a.last_name) '사원이름',
    b.salary '연봉',
    manager_name '매니저 이름',
    manager_salary '매니저 연봉'
FROM
    employees a,
    salaries b,
    dept_emp c,
    departments d,
    (SELECT 
        c.dept_no,
            CONCAT(a.first_name, ' ', a.last_name) AS manager_name,
            b.salary AS manager_salary
    FROM
        employees a, salaries b, dept_manager c
    WHERE
        a.emp_no = b.emp_no
            AND a.emp_no = c.emp_no
            AND b.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01') e
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND c.dept_no = d.dept_no
        AND c.dept_no = e.dept_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND b.salary > e.manager_salary
;


