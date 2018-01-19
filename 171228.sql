---------------------------scott접속
SELECT  decode(rnum,1,deptno,2,deptno) AS 부서
        ,decode(rnum,1,JOB)            AS 직무
        ,SUM(sumsal)                   AS 급여합
FROM    (SELECT  nvl(deptno,999) AS deptno  --괄호 안은 인라인.
                ,JOB
                ,SUM(sal)        AS sumsal
        FROM    emp
        GROUP BY deptno, JOB
        ORDER BY 1,2)
        ,(SELECT ROWNUM AS rnum 
          FROM   emp 
          WHERE ROWNUM<=3)
GROUP BY decode(rnum,1,deptno,2,deptno)
        ,decode(rnum,1,JOB)
ORDER BY 1,2;

---------------------------------------------scott끝
--------------------------------------------n1접속
SELECT      decode(rnum,1,department_id,2,department_id)   AS 부서
            ,decode(rnum,1,job_id)                AS 직무
            ,SUM(sumsal)
FROM        (SELECT      nvl(department_id,0) AS department_id
                        ,job_id                 
                        ,SUM(salary)       AS sumsal     
            FROM        employees
            GROUP BY    department_id, job_id
            ORDER BY    1,2)
            CROSS JOIN(SELECT    ROWNUM AS rnum
                        FROM     employees
                        WHERE    ROWNUM<=3)
GROUP BY decode(rnum,1,department_id,2,department_id)
        ,decode(rnum,1,job_id)
ORDER BY 1,2;
-----------------------------------------------------------------
SELECT nvl(decode(rnum,1,to_char(department_id),2,to_char(department_id)),'전체') AS 부서
       ,nvl(decode(rnum,1,job_id),'합계')  AS 업무
       ,SUM(sumsal) AS 합계
FROM    (SELECT      nvl(department_id,999)    AS department_id
                    ,job_id
                    ,SUM(salary)               AS sumsal
         FROM        employees
         GROUP BY    department_id, job_id
         ORDER BY    department_id, job_id),
        (SELECT ROWNUM          AS rnum
         FROM employees
         WHERE ROWNUM<=3)
GROUP BY decode(rnum,1,to_char(department_id),2,to_char(department_id))
        ,decode(rnum,1,job_id)
ORDER BY 1,2;
-------------------------------------------------------------------
 --subquery이용
 
CREATE TABLE rno (
NO NUMBER PRIMARY KEY
);
INSERT INTO rno VALUES(5);
SELECT * FROM rno;

SELECT last_name, department_id
FROM employees
WHERE department_id = (SELECT department_id FROM employees
                       WHERE last_name = 'King');
---------------------------------------------------------------          
SELECT salary
FROM employees
WHERE last_name = 'Abel';

SELECT last_name, salary
FROM employees
WHERE salary > 11000;

--=> 두개를 합쳐
SELECT last_name, salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Abel');
---------------------------------------------------------------------
SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 141);

SELECT last_name    AS "Hunold의 멘티"
FROM employees
WHERE manager_id = (SELECT employee_id
                    FROM employees
                    WHERE last_name = 'Hunold');

SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE last_name = 'Taylor')
AND salary >    (SELECT salary
                FROM employees
                WHERE last_name = 'Taylor');
                
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);
                
SELECT department_id, MIN(salary)               
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary)
                      FROM employees
                      WHERE department_id=50);
                      
SELECT last_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE last_name = 'Haas');
                
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY
                (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG')
AND job_id <>'IT_PROG';

--=
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE (salary < 9000
    OR salary < 6000
    OR salary < 4200)
    AND job_id <> 'IT_PROG';
    
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ALL
                (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG')
AND job_id <>'IT_PROG';

SELECT *
FROM departments
WHERE NOT EXISTS
                (SELECT *
                FROM employees
                WHERE employees.department_id = departments.department_id);
                
SELECT  emp.last_name
FROM    employees emp
WHERE   emp.employee_id NOT IN  (SELECT mgr.manager_id
                                FROM employees mgr
                                WHERE manager_id IS NOT NULL);

SELECT  last_name
        ,job_id
FROM    employees
WHERE   job_id IN ('','');


--------------연습문제 3장
--1)
SELECT sysdate AS "Date"
FROM dual;

--2)
SELECT employee_id
       ,last_name
       ,salary
       ,salary*1.155 AS "New Salary"
FROM employees;

--3)
SELECT employee_id
       ,last_name
       ,salary
       ,salary*1.155 AS "New Salary"
       ,salary*1.155-salary AS "Increase"
FROM employees;

--4)
SELECT last_name AS "Name"
       ,LENGTH(last_name) AS "Length"
FROM employees
WHERE last_name LIKE 'J%'
    OR last_name LIKE 'A%'
    OR last_name LIKE 'M%';
    
--5)
SELECT last_name AS "Name"
      ,LENGTH(last_name) AS "Length"
FROM employees
WHERE last_name LIKE '&last_put%';

--6)
SELECT last_name AS "Name"
       ,LENGTH(last_name) AS "Length"
FROM employees
WHERE last_name LIKE UPPER('&last_put%');

--7)
SELECT last_name
      , round((sysdate-hire_date)/30,0) AS months_worked
FROM employees;

SELECT last_name
        ,round(months_between(sysdate, hire_date),0) AS months_worked
FROM employees;

--8)
SELECT last_name
       ,lpad(salary,15,'$') AS salary
FROM employees;

--9)
SELECT rpad(rpad(last_name,8),8+TRUNC(salary/1000,0),'*') AS employees_and_their_salaries
FROM employees
ORDER BY salary DESC;


--10)
SELECT last_name, TRUNC((sysdate-hire_date)/52,0) AS tenure
FROM employees
ORDER BY hire_date ASC;

------6장
--1)
SELECT location_id, street_address, city, state_province, country_name
FROM locations L
     ,countries C
WHERE C.country_id = L.country_id;

--2)
SELECT last_name
      ,C.department_id
      ,department_name
FROM departments D
     ,employees C
WHERE C.department_id = D.department_id;

--3)
SELECT E.last_name
      ,E.job_id
      ,E.department_id
      ,department_name
FROM employees E JOIN departments D
ON E.department_id = D.department_id
JOIN locations L
ON D.location_id = L.location_id
WHERE L.city='Toronto';

--4)
SELECT E.last_name AS employee
      ,E.employee_id AS "EMP#"
      ,M.last_name AS MANAGER
      ,M.employee_id AS "Mgr#"
FROM employees E JOIN employees M
ON E.manager_id = M.employee_id;

--5)
SELECT E.last_name AS employee
      ,E.employee_id AS "EMP#"
      ,M.last_name AS MANAGER
      ,M.employee_id AS "Mgr#"
FROM employees E LEFT JOIN employees M
ON E.manager_id = M.employee_id
ORDER BY E.employee_id ASC;

--6)
SELECT E.department_id AS "DEPARTMENT"
      ,E.last_name AS "EMPLOYEE"
      , C.last_name AS "COLLEAGUE"
FROM employees E, employees C
WHERE E.department_id = C.department_id
    AND E.last_name <> C.last_name;
    
--7)
DESC job_grades;
SELECT last_name
      ,job_id
      ,department_name
      ,salary
      ,grade_level
FROM employees E
    ,departments D
    ,job_grades j
WHERE E.department_id = D.department_id
 AND  E.salary BETWEEN j.lowest_sal AND j.highest_sal;
 
 --8)
 SELECT E.last_name
        ,E.hire_date
FROM employees E, employees D
WHERE D.last_name = 'Davies'
 AND D.hire_date<E.hire_date;
 
 --9)
 SELECT E.last_name     AS last_name
        , E.hire_date   AS hire_date
        , M.last_name   AS last_name_1
        , M.hire_date   AS hire_date_1
 FROM employees E, employees M
 WHERE E.manager_id = M.employee_id
 AND   E.hire_date<M.hire_date;
 
 -------------------------------------------------------
 
DROP TABLE set_a PURGE;
CREATE TABLE set_a (
A NUMBER(5)
);
 
INSERT INTO set_a VALUES(1);
INSERT INTO set_a VALUES(2);
INSERT INTO set_a VALUES(3);
INSERT INTO set_a VALUES(4); 
INSERT INTO set_a VALUES(5);
INSERT INTO set_a VALUES(6);

SELECT * FROM set_a;

CREATE TABLE set_b (
A NUMBER(5)
);
 
INSERT INTO set_b VALUES(4);
INSERT INTO set_b VALUES(5);
INSERT INTO set_b VALUES(6);
INSERT INTO set_b VALUES(7); 
INSERT INTO set_b VALUES(8);
INSERT INTO set_b VALUES(9);

SELECT * FROM set_a
UNION
SELECT * FROM set_b;

SELECT * FROM set_a
UNION ALL
SELECT * FROM set_b;

SELECT * FROM set_a
INTERSECT
SELECT * FROM set_b;

SELECT * FROM set_a
MINUS
SELECT * FROM set_b;

SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

SELECT location_id, 
        department_name "Department",
        to_char(NULL) "Warehouse location"
FROM departments
UNION
SELECT location_id, to_char(NULL) "Department",
        state_province
FROM locations; 

SELECT * FROM set_b;

--------------------------------------
--1)
SELECT nvl(department_id,190)
FROM employees
MINUS
SELECT department_id
FROM employees
WHERE job_id = 'ST_CLERK';

--================>잘못 품
select  department_id
from    departments
minus
select  department_id
from departen==
--2)
SELECT country_id, country_name
FROM countries
MINUS
SELECT C.country_id, C.country_name
FROM countries C, locations L
WHERE C.country_id = L.country_id;

--3)
SELECT job_id, department_id
FROM employees
WHERE department_id IS NOT NULL
MINUS
SELECT job_id, department_id
FROM employees
WHERE department_id>50;

--4)
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

--5)
SELECT last_name, department_id, to_char(NULL)
FROM employees
UNION
SELECT to_char(NULL),department_id, department_name
FROM departments;