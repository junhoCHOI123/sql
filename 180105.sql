GRANT SELECT, INSERT            --권한 주기
ON departments  
TO demo;

REVOKE SELECT, INSERT           --권한 회수
ON departments
FROM demo;

CREATE TABLE dept80
AS
SELECT last_name, department_id, job_id FROM employees
WHERE department_id = 80;

ALTER TABLE dept80 
DROP COLUMN job_id;

ALTER TABLE dept80
ADD (job_id VARCHAR2(9));

SELECT * FROM dept80;

ALTER TABLE dept80
MODIFY      (last_name VARCHAR2(30));

ALTER TABLE dept80
MODIFY      (last_name VARCHAR2(25));

DESC dept80;

SELECT * FROM dept80;

ALTER TABLE dept80
SET UNUSED (last_name);


ALTER TABLE succeeded;

CREATE TABLE emp2
AS
SELECT * FROM employees;

ALTER TABLE emp2 ADD CONSTRAINT emp_dt_fk
FOREIGN KEY (department_id)
REFERENCES departments(department_id) ON DELETE CASCADE;

CREATE TABLE emp_new_sal (salary NUMBER
CONSTRAINT sal_ck
CHECK (salary > 100)
DEFERRABLE INITIALLY IMMEDIATE,
bonus NUMBER
CONSTRAINT bonus_ck
CHECK (bonus > 0 )
DEFERRABLE INITIALLY DEFERRED );

INSERT INTO emp_new_sal VALUES(90,5);
INSERT INTO emp_new_sal VALUES(1000,-100);
COMMIT;     --여기서 error발생.

ALTER TABLE emp2
DROP CONSTRAINT emp_mgr_fk;

ALTER TABLE dept2
DROP PRIMARY KEY CASCADE;

ALTER TABLE emp2
DISABLE CONSTRAINT emp_dt_fk;
ROLLBACK;

CREATE TABLE test1 (
col1_pk NUMBER PRIMARY KEY,
col2_fk NUMBER,
col1 NUMBER,
col2 NUMBER,
CONSTRAINT fk_constraint FOREIGN KEY (col2_fk) REFERENCES
test1,
CONSTRAINT ck1 CHECK (col1_pk > 0 AND col1 > 0),
CONSTRAINT ck2 CHECK (col2_fk > 0));

ALTER TABLE test1 DROP (col1_pk);
ALTER TABLE test1 DROP (col1);

ALTER TABLE test1
DROP (col1_pk, col2_fk, col1) CASCADE CONSTRAINTS;

DESC test1;

CREATE TABLE marketing (team_id NUMBER(10),
TARGET VARCHAR2(50),
CONSTRAINT mktg_pk PRIMARY KEY(team_id));

DESC marketing;

ALTER TABLE marketing RENAME COLUMN team_id
TO ID;
SELECT * FROM user_constraints;

ALTER TABLE marketing RENAME CONSTRAINT mktg_pk
TO new_mktg_pk;

CREATE TABLE new_emp
(employee_id NUMBER(6)
PRIMARY KEY USING INDEX
(CREATE INDEX emp_id_idx ON
new_emp(employee_id)),
first_name VARCHAR2(20),
last_name VARCHAR2(25));

SELECT index_name, table_name
FROM user_indexes
WHERE table_name = 'NEW_EMP';

SELECT * FROM user_indexes;

CREATE TABLE EMP_UNNAMED_INDEX
(employee_id NUMBER(6) PRIMARY KEY ,
first_name VARCHAR2(20),
last_name VARCHAR2(25));

SELECT * FROM USER_INDEXES;

CREATE TABLE NEW_EMP2
(employee_id NUMBER(6),
first_name VARCHAR2(20),
last_name VARCHAR2(25)
);

CREATE INDEX emp_id_idx2 ON
new_emp2(employee_id);

ALTER TABLE new_emp2 ADD PRIMARY KEY (employee_id) USING INDEX
emp_id_idx2;

DROP TABLE dept80 PURGE;

DROP TABLE DEPT;
DROP TABLE EMP2;

SELECT * FROM RECYCLEBIN;

SELECT original_name, operation, droptime FROM
recyclebin;

FLASHBACK TABLE emp2 TO BEFORE DROP;
FLASHBACK TABLE DEPT TO BEFORE DROP;

CREATE GLOBAL TEMPORARY TABLE today_sales4
ON COMMIT delete ROWS AS
SELECT last_name,salary FROM employees;
select * from today_sales;
commit;

select * from today_sales4;

insert into today_sales4 values('test2',20000);

---------------------------------------------sys접속
grant create any directory to n1;
---------------------------------------------n1접속
CREATE OR REPLACE DIRECTORY emp_dir
AS 'C:/dev';

CREATE TABLE oldemp6 (
fname char(25), 
lname CHAR(25),
team  CHAR(20))
ORGANIZATION EXTERNAL
(TYPE ORACLE_LOADER
DEFAULT DIRECTORY emp_dir
ACCESS PARAMETERS
(FIELDS TERMINATED BY ','
(fname,lname,team))
LOCATION ('testdb.csv'))
;
select * from oldemp6;

select * from oldemp;