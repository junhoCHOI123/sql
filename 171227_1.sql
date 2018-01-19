----------------------------oracle join
------1)부서이름(departments.department_name), 도시(locations.city)
--equi join
SELECT D.department_name AS 부서명, L.city AS 소속도시
FROM departments D, locations L
WHERE D.location_id = L.location_id;

------2)부서명, 부서대빵
--left join
SELECT D.department_name AS 부서명, nvl(E.last_name,'NONE') AS 부서장
FROM departments D, employees E
WHERE D.manager_id = E.employee_id(+);

------3)사원명, 급여, 사원의 등급
--non equi join
SELECT E.last_name AS 사원명
     , E.salary AS 급여
     , j.grade_level AS 사원등급
FROM job_grades j, employees E
WHERE j.lowest_sal <= E.salary
     AND E.salary <= j.highest_sal
--e.salary between j.lowest_sal and j.highest_sal
ORDER BY salary DESC;

------4)사원이름, 직속상관
--self join
SELECT E.last_name AS 사원명
     , nvl(M.last_name,'NONE') AS 직속상관
FROM employees E, employees M
WHERE E.manager_id = M.employee_id(+);


--------------------------------------------ansi join
--1)부서이름(departments.department_name), 도시(locations.city)
SELECT D.department_name AS 부서명, L.city AS 소속도시
FROM departments D JOIN locations L
ON D.location_id = L.location_id;

------2)부서명, 부서대빵
SELECT D.department_name AS 부서명, nvl(E.last_name,'NONE') AS 부서장
FROM departments D LEFT JOIN employees E
ON D.manager_id = E.employee_id(+);

------3)사원명, 급여, 사원의 등급
SELECT E.last_name AS 사원명
     , E.salary AS 급여
     , j.grade_level AS 사원등급
FROM job_grades j JOIN employees E
ON   j.lowest_sal <= E.salary
     AND E.salary <= j.highest_sal
--e.salary between j.lowest_sal and j.highest_sal
ORDER BY salary DESC;

------4)사원이름, 직속상관
--self join
SELECT E.last_name AS 사원명
     , nvl(M.last_name,'NONE') AS 직속상관
FROM employees E LEFT JOIN employees M
ON   E.manager_id = M.employee_id;

----------natural join
SELECT last_name, department_name
FROM employees NATURAL JOIN departments;

----------join using
SELECT last_name, department_name
FROM employees LEFT JOIN departments
USING (department_id);

------------------------------------------------n1끝
----------------------------------------scott접속
--1)사원이름, 부서명, 급여, 사원등급
SELECT E.ename AS 사원명
      , nvl(D.dname,'부서없음') AS 부서명
      , E.sal AS 급여
      , S.grade AS 사원등급
FROM  emp E, dept D, salgrade S
WHERE E.deptno = D.deptno(+)
AND   (E.sal BETWEEN S.losal AND S.hisal)
ORDER BY S.grade DESC;

------------------------------------------------scott끝
----------------------------------------n1접속
--사원이름, 급여, 부서명, 사원등급
SELECT E.last_name AS 사원
     , E.salary    AS 급여
     , nvl(D.department_name,'NONE') AS 부서명
     , j.grade_level AS 사원등급
FROM employees E
     , departments D
     , job_grades j
WHERE E.department_id = D.department_id(+)
     AND E.salary BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY 급여 DESC;

--사원이름, 급여, 사원등급, 부서명, 소속도시, 나라, 대륙, 멘토
SELECT EM.last_name AS 사원
     , EM.salary    AS 급여
     , jg.grade_level AS 사원등급
     , nvl(dp.department_name,'-NONE-') AS 부서명
     , nvl(L.city,'-NONE-')   AS 소속도시
     , nvl(C.country_name, '-NONE-') AS 나라
     , nvl(R.region_name,'-NONE-') AS 대륙
     , nvl(ma.last_name,'-NONE-') AS 멘토
FROM employees EM
    , employees ma
    , job_grades jg
    , departments dp
    , locations L
    , countries C
    , regions R
WHERE EM.salary BETWEEN jg.lowest_sal AND jg.highest_sal
AND   EM.department_id = dp.department_id(+)
AND   dp.location_id = L.location_id(+)
AND   L.country_id = C.country_id(+)
AND   C.region_id = R.region_id(+)
AND   EM.manager_id = ma.employee_id(+)
ORDER BY 급여 DESC;

-------------------------------------------n1끝
-------------------------------------------scott시작

--three-ways join(ansi join)
SELECT  E.ename, D.dname, E.sal, S.grade
FROM    emp E 
    LEFT JOIN dept D
ON      E.deptno = D.deptno
JOIN    salgrade S
ON      E.sal 
    BETWEEN S.losal AND S.hisal;
    
-------------------------------------------scott끝
----------------------------------------n1시작    
--이름, 급여, 업부, 사원등급, 부서이름, 도시, 나라, 지역, 멘토
SELECT      E.last_name                         AS 이름
            , E.salary                          AS 급여
            , nvl(D.department_name,'-NONE-')   AS 부서
            , j.grade_level                     AS 등급
            , js.job_title                      AS 업무
            , nvl(L.city,'-NONE-')              AS 도시
            , nvl(C.country_name,'-NONE-')      AS 나라
            , nvl(R.region_name,'-NONE-')       AS 지역
            , nvl(M.last_name,'-NONE-')         AS 멘토
FROM        employees E 
LEFT JOIN   departments D
ON          E.department_id = D.department_id
JOIN        job_grades j
ON          E.salary BETWEEN j.lowest_sal AND j.highest_sal
JOIN        jobs js
ON          E.job_id = js.job_id
LEFT JOIN   locations L
ON          D.location_id = L.location_id
LEFT JOIN   countries C
ON          L.country_id = C.country_id
LEFT JOIN   regions R
ON          C.region_id = R.region_id
LEFT JOIN   employees M
ON          E.manager_id = M.employee_id;


--1)SALARY가 10000달러 이상이며, JOB_ID에 문자열 'MAN'이 포함된 사원을 출력
SELECT last_name
FROM employees
WHERE salary>=10000
    AND job_id LIKE '%MAN%';

--2)salary가 10000달러 이상이거나, job_id에 'man'이 포함된 사원을 출력
SELECT last_name
FROM employees
WHERE salary>=10000
    OR job_id LIKE '%MAN%';
    
--3)job_id가 it=prog, st_clerk, sa_rep에 속하지 않은 사원 출력
SELECT last_name
FROM employees
WHERE job_id <> 'IT_PROG'
    AND job_id <> 'ST_CLERK'
    AND job_id <> 'SA_REP';
    
--4)commission_pct가 null이 아닌 사원들을 출력
SELECT last_name
FROM employees
WHERE commission_pct IS NOT NULL;

--5)job_id가 st_clerk 또는 sa_rep이면서 급여가 2500, 3500, 7000이 아닌 모든 사원들을 출력
SELECT last_name
FROM employees
WHERE job_id = 'ST_CLERK'
    OR job_id = 'SA_REP'
    AND salary <> 2500 AND salary <> 3500 AND salary <> 7000;


----------------------------------------
--------------------------------------그룹(집계)함수


SELECT SUM(salary) AS 합
      ,AVG(salary) AS 평균
      ,MAX(salary) AS 최대
      ,MIN(salary) AS 최소
      ,SUM(nvl(commission_pct,0)) AS 커미션합
      ,COUNT(nvl(commission_pct,0)) AS 커미션수
      ,AVG(commission_pct)          AS 커미션받는사람의평균
      ,AVG(nvl(commission_pct,0)) AS 전체커미션평균
      ,COUNT(salary) AS 수
FROM employees;

SELECT ROWID, ROWNUM, last_name FROM employees;

SELECT MIN(hire_date), MAX(hire_date)
FROM employees;


--업무가 IT_PROG인 사원들의 최고 연봉과, 최저 연봉, 두 연봉의 차, 연봉의 합, 평균연봉, 직원 수
SELECT MAX(salary) AS 최고연봉
       ,MIN(salary) AS 최저연봉
       ,(MAX(salary)-MIN(salary)) AS 연봉의차
       ,SUM(salary) AS 연봉합
       ,AVG(salary) AS 평균연봉
       ,COUNT(salary) AS 직원수
FROM employees
WHERE job_id = 'IT_PROG';

select count(distinct department_id) from employees;
select count(department_id) from employees;

--------부서별 사원의 급여 합계
select  department_id, sum(salary) 
from    employees
group by department_id
order by 1, 2;   --col의 숫자.

-------부서별업무별 사원의 급여 합계
select  department_id, job_id,sum(salary) 
from    employees
group by department_id, job_id
order by 1, 2;

select      department_id, max(salary)
from        employees
group by    department_id
having      max(salary)>10000;

select   job_id
         ,sum(salary) as payroll
from     employees
where    job_id not like '%REP%'
group by job_id
having   sum(salary) > 13000
order by sum(salary);

select job_id, sum(salary) payroll
from employees
group by job_id
having job_id not like '%REP%'
and sum(salary)>13000
order by sum(salary);

select max(avg(salary))
from employees
group by (department_id);

--6)employees 테이블의 사원들에서 부서별 가장 많은 급여를 받는 사원과, 가장 적은 급여를 받는 사원의 금액의 차이를 출력
select department_id  as 부서번호
       , max(salary)-min(salary) as 최대급여차
from employees
group by department_id;

--7)employees 테이블의 사원들에서 각 부서의 사원수를 출력
select department_id        as 부서번호
       ,count(employee_id)  as "부서내 사원수"
from employees
group by department_id;

--8)employees 테이블의 사원들에서 전체 사원들의 커미션 평균을 출력
select avg(nvl(commission_pct,0)) as 커미션평균
from employees;

--9)employees 테이블의 사원들에서 각 부서의 연봉이 5000이상인 사원 수를 출력
select department_id        as 부서번호
       ,count(employee_id)  as 사원수
from employees
where salary>=5000
group by department_id;

--10)employees 테이블의 사원들에서 부서별 업무별 급여합계 출력
select department_id        as 부서번호
       ,job_id              as 업무
       ,sum(salary)         as 급여합
from employees
group by department_id, job_id
order by department_id;

--11)employees 테이블의 사원들에서 'REP'라는 문자열을 포함하지 않는 업무별
--급여 합계 중 13000을 초과하지 않는 업무그룹을 급여 합계의 오름차순으로 출력
select department_id        as 부서번호
      ,sum(salary)          as 급여합
from employees
where job_id not like '%REP%'
group by department_id
having sum(salary)>13000
order by sum(salary) asc;

---------------------------------------n1끝
------------------------------------=scott시작
select decode(rnum , 1, deptno, 2, deptno)
       ,decode(rnum,1, job), sumsal, rnum
from(select   nvl(deptno,999) as deptno
         ,job
         ,sum(sal) as sumsal
from     emp
group by deptno, job
order by 1,2),(select rownum as rnum from emp where rownum<=3);