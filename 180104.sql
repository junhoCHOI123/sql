CREATE TABLE bonuses (employee_id NUMBER, bonus NUMBER DEFAULT 100);

INSERT INTO bonuses(employee_id)
    (SELECT E.employee_id 
    FROM employees E);
    
SELECT * FROM bonuses;

-------------------------------------------------------------------------------Merge 연습 1

MERGE INTO bonuses D    --집어넣을 대상의 테이블을 여기 주면 됨.
   USING (SELECT employee_id, salary, department_id FROM employees      --작업할 source를 주는거임 using을 이용해서 into에 집어넣는것.
   WHERE department_id = 80) S
   ON (D.employee_id = S.employee_id)                                   --그에대한 조건
   WHEN MATCHED THEN UPDATE SET D.bonus = D.bonus + S.salary*.01
     DELETE WHERE (S.salary > 8000)
   WHEN NOT MATCHED THEN INSERT (D.employee_id, D.bonus)
     VALUES (S.employee_id, S.salary*0.1);
--     WHERE (S.salary <= 8000);

------------------------------------------------------------------------------- Merge 연습 2 -> scott계정
CREATE TABLE emp01
AS
SELECT * FROM emp;

CREATE TABLE emp02
AS
SELECT * FROM emp
WHERE JOB='MANAGER';

UPDATE emp02 SET
    JOB = 'TEST';
INSERT INTO emp02
VALUES (8000,'FUNK','MUSICIAN',7566,sysdate,2400,10,20);

MERGE INTO emp01
USING emp02
ON  (emp01.empno = emp02.empno)
WHEN MATCHED THEN
    UPDATE SET
    emp01.ename=emp02.ename,
    emp01.JOB = emp02.JOB
WHEN NOT MATCHED THEN
    INSERT VALUES(emp02.empno, emp02.ename, emp02.JOB, emp02.mgr, emp02.hiredate, emp02.sal, emp02.comm, emp02.deptno);
    
CONN SYS/ORACLE AS SYSDBA;
SHOW USER;

CREATE USER demo
IDENTIFIED BY demo;

CONN demo/demo

GRANT CREATE SESSION, CREATE TABLE,
      CREATE SEQUENCE, CREATE VIEW
TO demo;

---------------------------------------------------sys접속
SHOW USER;
CREATE ROLE MANAGER;
GRANT   CREATE TABLE, CREATE VIEW 
TO      MANAGER;

CREATE USER alice IDENTIFIED BY alice;
GRANT MANAGER TO alice;
grant create session to alice;

alter user demo
identified by employ;

alter user demo
identified by demo;

------------------------------------------------------n1접속
grant select
on employees
to demo;
-----------------------------------------------------demo접속
select * from n1.employees;
--------------------------------------------------------n1접속
GRANT select, update (department_name, location_id)
ON n1.departments
TO demo, manager;
commit;
---------------------------------------------------------demo접속
select * from n1.departments;

UPDATE n1.departments SET
    department_name = 'placing'
where location_id = 1700;
rollback;

INSERT INTO n1.departments
VALUES (8000,'FUNK','MUSICIAN',7566,sysdate,2400,10,20);

-------------------------------------------------------------n1접속
--1)n계정의 departments테이블을 alice계정에서 select할수있게 권한 부여
--2)alice계정에서 n1.departments를 ctas로 departments 테이블 생성
--3)alice계정에서 departments를 public권한 부여
--4)demo계정에서 alice.departments를 select할 수 있는지 확인

grant select
on    departments
to    alice;
--alice계정실행
grant connect,resource
to alice;

create table departments
as
select * from n1.departments;

grant select on departments to public;

----demo접속
select * from alice.departments;
select * from alice.departments;

select * from role_sys_privs;
select * from USER_SYS_PRIVS;
select * from USER_TAB_PRIVS_MADE;
select * from USER_TAB_PRIVS_RECD;

