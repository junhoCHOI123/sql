----------------------------oracle join
------1)�μ��̸�(departments.department_name), ����(locations.city)
--equi join
SELECT D.department_name AS �μ���, L.city AS �Ҽӵ���
FROM departments D, locations L
WHERE D.location_id = L.location_id;

------2)�μ���, �μ��뻧
--left join
SELECT D.department_name AS �μ���, nvl(E.last_name,'NONE') AS �μ���
FROM departments D, employees E
WHERE D.manager_id = E.employee_id(+);

------3)�����, �޿�, ����� ���
--non equi join
SELECT E.last_name AS �����
     , E.salary AS �޿�
     , j.grade_level AS ������
FROM job_grades j, employees E
WHERE j.lowest_sal <= E.salary
     AND E.salary <= j.highest_sal
--e.salary between j.lowest_sal and j.highest_sal
ORDER BY salary DESC;

------4)����̸�, ���ӻ��
--self join
SELECT E.last_name AS �����
     , nvl(M.last_name,'NONE') AS ���ӻ��
FROM employees E, employees M
WHERE E.manager_id = M.employee_id(+);


--------------------------------------------ansi join
--1)�μ��̸�(departments.department_name), ����(locations.city)
SELECT D.department_name AS �μ���, L.city AS �Ҽӵ���
FROM departments D JOIN locations L
ON D.location_id = L.location_id;

------2)�μ���, �μ��뻧
SELECT D.department_name AS �μ���, nvl(E.last_name,'NONE') AS �μ���
FROM departments D LEFT JOIN employees E
ON D.manager_id = E.employee_id(+);

------3)�����, �޿�, ����� ���
SELECT E.last_name AS �����
     , E.salary AS �޿�
     , j.grade_level AS ������
FROM job_grades j JOIN employees E
ON   j.lowest_sal <= E.salary
     AND E.salary <= j.highest_sal
--e.salary between j.lowest_sal and j.highest_sal
ORDER BY salary DESC;

------4)����̸�, ���ӻ��
--self join
SELECT E.last_name AS �����
     , nvl(M.last_name,'NONE') AS ���ӻ��
FROM employees E LEFT JOIN employees M
ON   E.manager_id = M.employee_id;

----------natural join
SELECT last_name, department_name
FROM employees NATURAL JOIN departments;

----------join using
SELECT last_name, department_name
FROM employees LEFT JOIN departments
USING (department_id);

------------------------------------------------n1��
----------------------------------------scott����
--1)����̸�, �μ���, �޿�, ������
SELECT E.ename AS �����
      , nvl(D.dname,'�μ�����') AS �μ���
      , E.sal AS �޿�
      , S.grade AS ������
FROM  emp E, dept D, salgrade S
WHERE E.deptno = D.deptno(+)
AND   (E.sal BETWEEN S.losal AND S.hisal)
ORDER BY S.grade DESC;

------------------------------------------------scott��
----------------------------------------n1����
--����̸�, �޿�, �μ���, ������
SELECT E.last_name AS ���
     , E.salary    AS �޿�
     , nvl(D.department_name,'NONE') AS �μ���
     , j.grade_level AS ������
FROM employees E
     , departments D
     , job_grades j
WHERE E.department_id = D.department_id(+)
     AND E.salary BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY �޿� DESC;

--����̸�, �޿�, ������, �μ���, �Ҽӵ���, ����, ���, ����
SELECT EM.last_name AS ���
     , EM.salary    AS �޿�
     , jg.grade_level AS ������
     , nvl(dp.department_name,'-NONE-') AS �μ���
     , nvl(L.city,'-NONE-')   AS �Ҽӵ���
     , nvl(C.country_name, '-NONE-') AS ����
     , nvl(R.region_name,'-NONE-') AS ���
     , nvl(ma.last_name,'-NONE-') AS ����
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
ORDER BY �޿� DESC;

-------------------------------------------n1��
-------------------------------------------scott����

--three-ways join(ansi join)
SELECT  E.ename, D.dname, E.sal, S.grade
FROM    emp E 
    LEFT JOIN dept D
ON      E.deptno = D.deptno
JOIN    salgrade S
ON      E.sal 
    BETWEEN S.losal AND S.hisal;
    
-------------------------------------------scott��
----------------------------------------n1����    
--�̸�, �޿�, ����, ������, �μ��̸�, ����, ����, ����, ����
SELECT      E.last_name                         AS �̸�
            , E.salary                          AS �޿�
            , nvl(D.department_name,'-NONE-')   AS �μ�
            , j.grade_level                     AS ���
            , js.job_title                      AS ����
            , nvl(L.city,'-NONE-')              AS ����
            , nvl(C.country_name,'-NONE-')      AS ����
            , nvl(R.region_name,'-NONE-')       AS ����
            , nvl(M.last_name,'-NONE-')         AS ����
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


--1)SALARY�� 10000�޷� �̻��̸�, JOB_ID�� ���ڿ� 'MAN'�� ���Ե� ����� ���
SELECT last_name
FROM employees
WHERE salary>=10000
    AND job_id LIKE '%MAN%';

--2)salary�� 10000�޷� �̻��̰ų�, job_id�� 'man'�� ���Ե� ����� ���
SELECT last_name
FROM employees
WHERE salary>=10000
    OR job_id LIKE '%MAN%';
    
--3)job_id�� it=prog, st_clerk, sa_rep�� ������ ���� ��� ���
SELECT last_name
FROM employees
WHERE job_id <> 'IT_PROG'
    AND job_id <> 'ST_CLERK'
    AND job_id <> 'SA_REP';
    
--4)commission_pct�� null�� �ƴ� ������� ���
SELECT last_name
FROM employees
WHERE commission_pct IS NOT NULL;

--5)job_id�� st_clerk �Ǵ� sa_rep�̸鼭 �޿��� 2500, 3500, 7000�� �ƴ� ��� ������� ���
SELECT last_name
FROM employees
WHERE job_id = 'ST_CLERK'
    OR job_id = 'SA_REP'
    AND salary <> 2500 AND salary <> 3500 AND salary <> 7000;


----------------------------------------
--------------------------------------�׷�(����)�Լ�


SELECT SUM(salary) AS ��
      ,AVG(salary) AS ���
      ,MAX(salary) AS �ִ�
      ,MIN(salary) AS �ּ�
      ,SUM(nvl(commission_pct,0)) AS Ŀ�̼���
      ,COUNT(nvl(commission_pct,0)) AS Ŀ�̼Ǽ�
      ,AVG(commission_pct)          AS Ŀ�̼ǹ޴»�������
      ,AVG(nvl(commission_pct,0)) AS ��üĿ�̼����
      ,COUNT(salary) AS ��
FROM employees;

SELECT ROWID, ROWNUM, last_name FROM employees;

SELECT MIN(hire_date), MAX(hire_date)
FROM employees;


--������ IT_PROG�� ������� �ְ� ������, ���� ����, �� ������ ��, ������ ��, ��տ���, ���� ��
SELECT MAX(salary) AS �ְ���
       ,MIN(salary) AS ��������
       ,(MAX(salary)-MIN(salary)) AS ��������
       ,SUM(salary) AS ������
       ,AVG(salary) AS ��տ���
       ,COUNT(salary) AS ������
FROM employees
WHERE job_id = 'IT_PROG';

select count(distinct department_id) from employees;
select count(department_id) from employees;

--------�μ��� ����� �޿� �հ�
select  department_id, sum(salary) 
from    employees
group by department_id
order by 1, 2;   --col�� ����.

-------�μ��������� ����� �޿� �հ�
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

--6)employees ���̺��� ����鿡�� �μ��� ���� ���� �޿��� �޴� �����, ���� ���� �޿��� �޴� ����� �ݾ��� ���̸� ���
select department_id  as �μ���ȣ
       , max(salary)-min(salary) as �ִ�޿���
from employees
group by department_id;

--7)employees ���̺��� ����鿡�� �� �μ��� ������� ���
select department_id        as �μ���ȣ
       ,count(employee_id)  as "�μ��� �����"
from employees
group by department_id;

--8)employees ���̺��� ����鿡�� ��ü ������� Ŀ�̼� ����� ���
select avg(nvl(commission_pct,0)) as Ŀ�̼����
from employees;

--9)employees ���̺��� ����鿡�� �� �μ��� ������ 5000�̻��� ��� ���� ���
select department_id        as �μ���ȣ
       ,count(employee_id)  as �����
from employees
where salary>=5000
group by department_id;

--10)employees ���̺��� ����鿡�� �μ��� ������ �޿��հ� ���
select department_id        as �μ���ȣ
       ,job_id              as ����
       ,sum(salary)         as �޿���
from employees
group by department_id, job_id
order by department_id;

--11)employees ���̺��� ����鿡�� 'REP'��� ���ڿ��� �������� �ʴ� ������
--�޿� �հ� �� 13000�� �ʰ����� �ʴ� �����׷��� �޿� �հ��� ������������ ���
select department_id        as �μ���ȣ
      ,sum(salary)          as �޿���
from employees
where job_id not like '%REP%'
group by department_id
having sum(salary)>13000
order by sum(salary) asc;

---------------------------------------n1��
------------------------------------=scott����
select decode(rnum , 1, deptno, 2, deptno)
       ,decode(rnum,1, job), sumsal, rnum
from(select   nvl(deptno,999) as deptno
         ,job
         ,sum(sal) as sumsal
from     emp
group by deptno, job
order by 1,2),(select rownum as rnum from emp where rownum<=3);