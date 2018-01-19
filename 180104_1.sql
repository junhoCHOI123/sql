CREATE TABLE bonuses (employee_id NUMBER, bonus NUMBER DEFAULT 100);

INSERT INTO bonuses(employee_id)
    (SELECT E.employee_id 
    FROM employees E);
    
SELECT * FROM bonuses;

-------------------------------------------------------------------------------Merge ���� 1

MERGE INTO bonuses D    --������� ����� ���̺��� ���� �ָ� ��.
   USING (SELECT employee_id, salary, department_id FROM employees      --�۾��� source�� �ִ°��� using�� �̿��ؼ� into�� ����ִ°�.
   WHERE department_id = 80) S
   ON (D.employee_id = S.employee_id)                                   --�׿����� ����
   WHEN MATCHED THEN UPDATE SET D.bonus = D.bonus + S.salary*.01
     DELETE WHERE (S.salary > 8000)
   WHEN NOT MATCHED THEN INSERT (D.employee_id, D.bonus)
     VALUES (S.employee_id, S.salary*0.1);
--     WHERE (S.salary <= 8000);

------------------------------------------------------------------------------- Merge ���� 2 -> scott����
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

---------------------------------------------------sys����
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

------------------------------------------------------n1����
grant select
on employees
to demo;
-----------------------------------------------------demo����
select * from n1.employees;
--------------------------------------------------------n1����
GRANT select, update (department_name, location_id)
ON n1.departments
TO demo, manager;
commit;
---------------------------------------------------------demo����
select * from n1.departments;

UPDATE n1.departments SET
    department_name = 'placing'
where location_id = 1700;
rollback;

INSERT INTO n1.departments
VALUES (8000,'FUNK','MUSICIAN',7566,sysdate,2400,10,20);

-------------------------------------------------------------n1����
--1)n������ departments���̺��� alice�������� select�Ҽ��ְ� ���� �ο�
--2)alice�������� n1.departments�� ctas�� departments ���̺� ����
--3)alice�������� departments�� public���� �ο�
--4)demo�������� alice.departments�� select�� �� �ִ��� Ȯ��

grant select
on    departments
to    alice;
--alice��������
grant connect,resource
to alice;

create table departments
as
select * from n1.departments;

grant select on departments to public;

----demo����
select * from alice.departments;
select * from alice.departments;

select * from role_sys_privs;
select * from USER_SYS_PRIVS;
select * from USER_TAB_PRIVS_MADE;
select * from USER_TAB_PRIVS_RECD;

