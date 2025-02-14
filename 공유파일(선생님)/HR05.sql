--@D:\jung\DATABASE\hr_test_data2.sql;

--1.student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л����� �г�, �̸�, ������ ���
select * from student;
--�� �г⺰ �ִ� ������
select  grade, max(weight) 
from student
group by grade;

select grade, name, weight
from student
where weight in (83,58,82,81);

select grade, name ,weight
from student
where weight in (select   max(weight) 
                from student
                group by grade);

--2.professor  department ���̺�
select * from professor; --������ȣ(profno), �̸�(name), �а���ȣ(deptno)
select * from department;  --dname(�а���),  �а���ȣ(deptno)
-- �� �а��� �Ի����� ���� ������ ������ ������ȣ, �̸�, �а��� ���
-- ��, �Ի����� ������������
--�� �а��� �Ի����� ���� ������ ������ ������ȣ
select deptno, min(hiredate)
from professor
group by deptno;

select p.profno, p.name, d.dname
from  professor p, department d
where p.deptno = d.deptno;

select p.profno, d.deptno, p.name, d.dname,p.hiredate
from  professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by hiredate;
--�μ���ȣ �������� ���
select p.profno, d.deptno, p.name, d.dname,p.hiredate
from  professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by d.deptno;

select p.profno, d.deptno, p.name, d.dname,p.hiredate
from  professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by 2; -- 2�� �÷��� ��ġ(d.deptno)
-- natural join
select p.profno, deptno, p.name, d.dname,p.hiredate
from  professor p NATURAL join department d
where hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by 2;
-- join using
select p.profno, deptno, p.name, d.dname,p.hiredate
from  professor p join department d using(deptno)
where hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by 2;
-- join~on
select p.profno, p.deptno, p.name, d.dname,p.hiredate
from  professor p join department d on p.deptno = d.deptno
where hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by 2;

--3. emp2 ���̺�
-- 'Section head'(position) ������ �ּ� �����ں���
--������ ���� ����� �̸�(name), ����(position), ����(pay) ���
select *  from emp2;
--'Section head'(position) ������ �ּ� ������
select  min(pay) from  emp2 where position = 'Section head'; --49000000
select name, position,pay
from emp2
where pay > 49000000;

select name, position, pay
from emp2
where pay > (select min(pay)
            from emp2
            where position = 'Section head');
 -- ������ õ���� , ���� ǥ���ϱ�
select name, position, pay, to_char(pay,'999,999,999')����
from emp2
where pay > (select min(pay)
            from emp2
            where position = 'Section head');
--4.employees ���̺�
--�μ���ȣ�� 80���� ū �μ��� ������̵�(employee_id), ����̸�(first_name),
--�Ŵ����̸�(first_name) ���