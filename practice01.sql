-- 기본 SQL 문제입니다.

-- 문제1.
-- 사번이 10944인 사원의 이름은(전체 이름)
SELECT 
    CONCAT(first_name, ' ', last_name) AS '전체이름'
FROM
    employees
WHERE
    emp_no = '10944';


-- 문제2. 
-- 전체직원의 다음 정보를 조회하세요. 가장 선임부터 출력이 되도록 하세요. 출력은 이름, 성별,  입사일 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해 보세요.
-- 결과: sql 실행하세요
SELECT 
    CONCAT(first_name, ' ', last_name) AS '이름',
    gender AS '성별',
    hire_date AS '입사일'
FROM
    employees
ORDER BY hire_date ASC
;


-- 문제3.
-- 여직원과 남직원은 각 각 몇 명이나 있나요?
-- 결과: 남직원 수 - 179973명 / 여직원 수 - 120051명
SELECT 
    (SELECT 
            COUNT(emp_no)
        FROM
            employees
        WHERE
            gender = 'M') AS '남직원 수',
    (SELECT 
            COUNT(emp_no)
        FROM
            employees
        WHERE
            gender = 'F') AS '여직원 수'
;


-- 문제4.
-- 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.) 
-- 결과: 240124명
SELECT 
    COUNT(emp_no) AS '현재 근무직원 수'
FROM
    salaries
WHERE
    to_date > NOW();


-- 문제5.
-- 부서는 총 몇 개가 있나요?
-- 결과: 9개
SELECT 
    COUNT(DISTINCT dept_no) AS '부서 갯수'
FROM
    dept_emp;


-- 문제6.
-- 현재 부서 매니저는 몇 명이나 있나요?(역임 매너저는 제외)
-- 결과: 9명
SELECT 
    COUNT(*) AS '부서 매니저 수'
FROM
    dept_manager
WHERE
    to_date > NOW();


-- 문제7.
-- 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.
-- 결과: sql 실행하세요
SELECT 
    *
FROM
    departments
ORDER BY LENGTH(dept_name) DESC;


-- 문제8.
-- 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?
-- 결과: 2159명
SELECT 
    COUNT(emp_no) AS cnt
FROM
    salaries
WHERE
    salary >= 120000 AND to_date > NOW();


-- 문제9.
-- 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.
-- 결과: sql 실행하세요
SELECT 
    title
FROM
    titles
GROUP BY title
ORDER BY LENGTH(title) DESC;


-- 문제10
-- 현재 Enginner 직책의 사원은 총 몇 명입니까?
-- 결과: 30983 명
SELECT 
    COUNT(employees.emp_no) AS '엔지니어 수'
FROM
    employees,
    (SELECT 
        emp_no
    FROM
        titles
    WHERE
        title = 'Engineer' AND to_date > NOW()) AS engineer
WHERE
    employees.emp_no = engineer.emp_no
;


-- 문제11
-- 사번이 13250(Zeydy)인 지원이 직책 변경 상황을 시간순으로 출력해보세요.
-- 결과: sql 실행하세요
SELECT 
    *
FROM
    titles
WHERE
    emp_no = '13250'
ORDER BY from_date;
