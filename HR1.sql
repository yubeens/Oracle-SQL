--@C:\SQL_Practice\�������ڷ�\hr_table.sql;

--1. employee ���̺� ��� ���� ��ȸ
select * from employees;

--2. departments ���̺� ��� ���� ��ȸ
select * from departments;

--3. employee ���̺��� first_name ��ȸ
select first_name from employees;

--4. employee ���̺��� department_id�� 30���� first_name�� ��ȸ
select first_name, department_id 
from employees 
where department_id = 30;

--5. employees ���̺��� ����(salary)�� 9,000 �̻��� ����� first_name ��ȸ
-- ������ ���� ������ ���
select first_name, salary 
from employees 
where salary >= 9000 order by salary desc; -- ���� ������ �̸� �������� ���� �߰� first_name asc;

--6. employees ���̺��� ������ 9,000�̻��̰� �μ���ȣ(department_id)�� 30���� ����� first_name��ȸ
select first_name, salary, department_id 
from employees 
where salary >= 9000 and department_id = 30;

--7. employees ���̺��� ������ 9,000 �̻��̰ų� �μ���ȣ�� 30���� ����� first_name ��ȸ
select first_name, salary, department_id 
from employees 
where salary >= 9000 or department_id = 30;

--8. �μ���ȣ�� 20�� �ƴ� ����� first_name, department_id ��ȸ
select first_name, department_id 
from employees 
where not department_id  = 20; --�ٸ� ��� : department_id <> 20; , !=

--9. job_id�� PU_CLERK�ų� ST_MAN�̰ų� SA_MAN�� ����� first_name�� job_id ���
select first_name, job_id 
from employees 
where job_id in ('PU_CLERK','ST_MAN','SA_MAN'); -- job_id = 'PU_CLERK' or job_id = 'ST_MAN' or job_id = 'SA_MAN';

--10. �μ���ȣ�� 100�� ����� first_name, first_name�� ù ����(ù ����),�μ���ȣ ���
select department_id �μ���ȣ, first_name, substr(first_name,1,1) as ù���� 
from employees 
where department_id = 100;

--11. �μ���ȣ�� 100�� ����� first_name�� 10���ڷ� ǥ���ϵ� ������ '*'�� ä���
select first_name, LPAD(first_name, 10),LPAD(first_name, 10, '*')
from employees
where department_id = 100;

--12. �μ���ȣ�� 100�� ����� first_name�� �α��ڸ� ������ ������ * ä���
select first_name, substr(first_name,1,2),
    RPAD(substr(first_name,1,2),length(first_name),'*')����̸�
from employees
where department_id = 100;

