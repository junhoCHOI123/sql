----------------------내가한겨
CREATE TABLE emp(
empno NUMBER(4) 
CONSTRAINT emp_empno_nn NOT NULL,
ename VARCHAR2(30),
hp VARCHAR2(11),
sal NUMBER,
deptno NUMBER(2)
--constraint emp_empno_nn primary key(empno)
);

CREATE TABLE dept(
deptno NUMBER(2)
CONSTRAINT dept_deptno_nn NOT NULL,
dname VARCHAR2(30),
loc VARCHAR2(10)
--constraint dept_deptno_pk primary key(deptno)
);

DROP TABLE t_dept PURGE;
DROP TABLE t_emp PURGE;

-----------------------쌤이한겨
CREATE TABLE t_dept(
deptno NUMBER(2)    
CONSTRAINT t_dept_deptno_pk PRIMARY KEY,
dname VARCHAR2(30) 
CONSTRAINT t_dept_dname_nn NOT NULL,
loc VARCHAR2(10)
);

CREATE TABLE t_emp(
empno NUMBER(4)     
CONSTRAINT t_emp_empno_pk PRIMARY KEY,
ename VARCHAR2(30)
CONSTRAINT t_emp_ename_nn NOT NULL,
hp VARCHAR2(11)     
CONSTRAINT t_emp_hp_uk UNIQUE,
sal NUMBER          
CONSTRAINT t_emp_sal_ck CHECK(sal >= 1120000),
deptno NUMBER(2)    
CONSTRAINT t_emp_deptno_fk REFERENCES t_dept(deptno)
);

SELECT * FROM user_constraints
WHERE table_name = 'T_EMP' OR
    table_name = 'T_DEPT';
------------------------------table level로 제약조건 주기.
CREATE TABLE t_dept(
deptno NUMBER(2),
dname VARCHAR2(30),
loc VARCHAR2(10),
CONSTRAINT t_dept_deptno_pk PRIMARY KEY(deptno),
CONSTRAINT t_dept_dname_nn CHECK (dname IS NOT NULL)
);

CREATE TABLE t_emp(
empno NUMBER(4),
ename VARCHAR2(30),
hp VARCHAR2(11),
sal NUMBER,
deptno NUMBER(2),
    CONSTRAINT t_emp_empno_pk PRIMARY KEY(empno),
    CONSTRAINT t_emp_ename_nn CHECK(ename IS NOT NULL),
    CONSTRAINT t_emp_hp_uk UNIQUE(hp),
    CONSTRAINT t_emp_sal_ck CHECK(sal >= 1120000),
    CONSTRAINT t_emp_deptno_fk FOREIGN KEY(deptno) REFERENCES t_dept(deptno)
);

CONN n1/n1 CREATE TABLE board (
NO         NUMBER
---------------------------------------------------------------------------
CREATE TABLE board(
NO         NUMBER(5),
title      VARCHAR2(34),
re         NUMBER(3) DEFAULT 0,
regdate    DATE DEFAULT sysdate);
-----------------------------------------------------------------------
SELECT A.*
FROM    (SELECT ROWNUM AS rnum, NO, title
        ,to_char(regdate, 'YYYY-MM-DD hh24:mi:ss') AS regdate, re
        FROM board
        ORDER BY NO DESC) A
WHERE rnum BETWEEN 1 AND 5;

--1.데이터 원하는 순서로 만들기 => A 
--2. 번호붙이기 => B  then, where 수행 (where가 먼저 수행되면x)
--3. 원하는 번호 가져오기

---=>
SELECT  b.*
FROM    (SELECT ROWNUM AS rnum, A.*
        FROM    (SELECT NO, title
                ,to_char(regdate, 'YYYY-MM-DD hh24:mi:ss') AS regdate, re
                FROM board
                ORDER BY NO DESC) A)b
WHERE   rnum BETWEEN 1 AND 5

define put_page;

undefine thispage
SELECT  b.*
FROM    (SELECT ROWNUM AS rnum, A.*
        FROM    (SELECT NO, title
                ,to_char(regdate, 'YYYY-MM-DD hh24:mi:ss') AS regdate, re
                FROM board
                ORDER BY NO DESC) A)b
WHERE   rnum BETWEEN ((&&put_page-1)*5+1) AND (&put_page*5);

-------------------------------------------------------------------------------

define pageSize=10
define thisPage=19
SELECT  b.*
FROM    (SELECT ROWNUM AS rnum, A.*
        FROM    (SELECT NO, title
                ,to_char(regdate, 'YYYY-MM-DD hh24:mi:ss') AS regdate, re
                FROM board
                ORDER BY NO DESC) A)b
WHERE   rnum BETWEEN ((&thispage-1)*&pageSize+1) AND (&thispage*&pageSize);

-------------------------------------------------------------------------------
-----empvu80이라는 뷰가 생성됨. 그 밑의 쿼리들의 내용을 저장함. (그냥 링크개념)
CREATE VIEW empvu80
AS SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = 80;

DESC empvu80

select * from empvu80;

CREATE VIEW salvu50
AS  SELECT employee_id ID_NUMBER, last_name NAME,
           salary*12 ANN_SALARY
    FROM   employees
    WHERE  department_id = 50;
    
select * from salvu50;

drop view salvu50;
drop view empvu80;

CREATE OR REPLACE VIEW empvu80  (id_number, name, sal, department_id)
AS SELECT employee_id, first_name || ' '
          || last_name, salary, department_id
FROM      employees
WHERE     department_id = 80;

select * from empvu80;

update empvu80 set
       sal = sal+10000;

CREATE OR REPLACE VIEW dept_sum_vu (name, minsal, maxsal, avgsal)
AS SELECT d.department_name, MIN(e.salary),MAX(e.salary),trunc(AVG(e.salary),0)
FROM      employees e JOIN departments d
ON        (e.department_id = d.department_id)
GROUP BY  d.department_name;

select * from dept_sum_vu;

select * from user_sequences;

select * from user_indexes;

CREATE INDEX emp_last_name_idx
ON employees(last_name);

CREATE SYNONYM d_sum
FOR dept_sum_vu;

select * from dept_sum_vu;
select * from d_sum;

drop synonym d_sum;