-----연습 8-1)

select      distinct d.department_id
from        employees e right join departments d
on          e.department_id = d.department_id
and         e.job_id <> 'ST_CLERK'
order by    1 asc;

select      department_id
from        departments
minus
select      department_id
from        employees
where       job_id = 'ST_CLERK';

create table 2018year ();
create table year2018(
no number
);

delete table year2018();

select * from scott.emp;

----------------------------------------------------------n1끝
----------------------------------------------관리자 연결

conn sys/oracle as sysdba;

grant select on scott.emp to n1;  --scott계정의 emp테이블을 n1에게 select할 권한을 줌.

----------------------------------------관리자 끝
--------------------------------------scott 연결

show user;
grant select on dept to n1;

-----------------------------------------scott끝
------------------------------------------n1시작

select * from scott.emp;
select * from scott.dept;
select * from scott.salgrade;

create table hire_dates (
id          number(8),
hire_date   date default sysdate);

INSERT INTO hire_dates values(45, NULL);

select * from hire_dates;

INSERT INTO hire_dates(id) values(35);   --column id를 명시적으로 지정해줌.

select id, to_char(hire_date, 'YYYYMMDD HH24MISS') as hiredate
from hire_dates;

create table dept(
deptno      number(2),
dname       varchar2(14),
loc         varchar2(13),
create_date date default sysdate);

desc dept;
describe dept;

------------------------------------------------n1끝
-------------------------------------------scott 시작
CREATE TABLE employees(
employee_id NUMBER(6)
CONSTRAINT emp_emp_id_pk PRIMARY KEY,
first_name VARCHAR2(20)
);


select * from user_constraints;

drop table employees purge;

CREATE TABLE employees(
employee_id NUMBER(6),
first_name VARCHAR2(20),
job_id VARCHAR2(10) 
CONSTRAINT emp_job_id_nn NOT NULL,
CONSTRAINT emp_emp_id_pk PRIMARY KEY (EMPLOYEE_ID));

select * from user_constraints;

drop table employees purge;

CREATE TABLE employees(
employee_id NUMBER(6),
first_name VARCHAR2(20),
job_id VARCHAR2(10),
CONSTRAINT emp_emp_id_pk PRIMARY KEY(EMPLOYEE_ID),
CONSTRAINT emp_job_id_nn CHECK(job_id is not null)
);

drop table employees purge;

CREATE TABLE employees(
employee_id NUMBER(6),
last_name VARCHAR2(25) NOT NULL,
email VARCHAR2(25) CONSTRAINT emp_email_uk UNIQUE)   --unique는 null이 여러개 들어갈 수 있다.
;

drop table employees purge;

select * from user_constraints;

insert into employees values (1, 'King', 'SKing');
insert into employees values (2, 'Young Suk', null);
insert into employees values (3, 'Jun Ho', null);

select * from employees;

create table dept80
as select employee_ie,di_last_name=,
salary *12 annsal
hire_date;


delete from employees where employee_id = 113;


drop table dept80 purge;
drop table dept801 purge;
--------
create table employees(