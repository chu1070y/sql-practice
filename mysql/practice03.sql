-- 테이블간 조인(JOIN) SQL 문제입니다.

-- 문제 1
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    b.salary '연봉'
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
ORDER BY b.salary DESC
;

-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    b.title '직책'
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name)
;

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    c.dept_name '부서'
FROM
    employees a,
    dept_emp b,
    departments c
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND b.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name)
;

-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    e.salary '연봉',
    d.title '직책',
    c.dept_name '부서'
FROM
    employees a,
    dept_emp b,
    departments c,
    titles d,
    salaries e
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND a.emp_no = d.emp_no
        AND a.emp_no = e.emp_no
        AND b.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
        AND e.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name)
;

-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.
SELECT 
    a.emp_no '사번',
    CONCAT(a.first_name, ' ', a.last_name) '이름'
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date != '9999-01-01'
        AND b.title = 'Technique Leader'
;

-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) '이름',
    c.dept_name '부서',
    d.title '직책'
FROM
    employees a,
    dept_emp b,
    departments c,
    titles d
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND a.emp_no = d.emp_no
        AND b.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
        AND a.last_name LIKE 'S%'
;

-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
SELECT 
    c.salary '현재급여'
FROM
    employees a,
    titles b,
    salaries c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND c.salary >= 40000
        AND b.title = 'Engineer'
ORDER BY c.salary DESC
;

-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
SELECT 
    b.title '직책', c.salary '급여'
FROM
    employees a,
    titles b,
    salaries c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND c.salary > 50000
ORDER BY c.salary DESC
;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
SELECT 
    c.dept_name '부서', AVG(d.salary) '평균연봉'
FROM
    employees a,
    dept_emp b,
    departments c,
    salaries d
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND a.emp_no = d.emp_no
        AND d.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY c.dept_no
ORDER BY AVG(d.salary) DESC
;

-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
SELECT 
    c.title '직책', AVG(b.salary) '평균연봉'
FROM
    employees a,
    salaries b,
    titles c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY c.title
ORDER BY AVG(b.salary) DESC
;