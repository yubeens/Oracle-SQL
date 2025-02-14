--student ���̺�
select * from student;
--1.student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л����� �г�, �̸�, ������ ���
select grade, max(weight)
from student
group by grade;

select grade, name, weight
from student
where weight in (83,58,82,81);

select grade, name, weight
from student 
where weight in (select max(weight)
                 from student
                 group by grade);
                 
--2.professor department ���̺�
select * from professor; --������ȣ(profno), �̸�(name), �а���ȣ(deptno), �Ի���(hiredate)
select * from department; --�а���(dname), �а���ȣ(deptno)
--�� �а��� �Ի����� ���� ������ ������ ������ȣ, �̸�, �а��� ���
--��, �Ի����� ������������
select deptno, min(hiredate)
from professor
group by deptno;

select p.profno, p.name, d.dname, p.hiredate 
from professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                 from professor
                 group by deptno)
order by hiredate;

--�μ���ȣ �������� ���
select p.profno, d.deptno, p.name, d.dname, p.hiredate 
from professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                 from professor
                 group by deptno)
order by 2; -- �÷��� ��ġ(d.deptno)

--natural join
select p.profno, p.name, d.dname, p.hiredate 
from professor p natural join department d
where p.hiredate in(select min(hiredate)
                    from professor
                    group by deptno)
order by 2;

--join ~ using
select p.profno, p.name, d.dname, p.hiredate 
from professor p join department d
using(deptno)
where p.hiredate in(select min(hiredate)
                    from professor
                    group by deptno)
order by 2;

--join ~ on
select p.profno, p.name, d.dname, p.hiredate 
from professor p join department d
on p.deptno = d.deptno
where p.hiredate in(select min(hiredate)
                    from professor
                    group by deptno)
order by 2;

--3.emp2 ���̺�
--'Section head'(position) ������ �ּ� �����ں���
--������ ���� ����� �̸�(name), ����(position), ����(pay) ���
select * from emp2;
--'Section head'(position) ������ �ּ� ������
select min(pay) from emp2 where position ='Section head'; --49000000

select name, position, pay
from emp2
where pay > 49000000; --7��

-->>
select name, position, pay
from emp2
where pay > (select min(pay)
            from emp2
            where position ='Section head');

--������ õ����, ���� ǥ���ϱ�
select name, position, to_char(pay,'L999,999,999') ����
from emp2
where pay > (select min(pay)
            from emp2
            where position ='Section head');

--4.employees ���̺�
--�μ���ȣ�� 80���� ū �μ��� ������̵�(employee_id), ����̸�(first_name), �Ŵ����̸�(first_name) ���
--self join
select e.employee_id ������̵�, e.first_name ����̸�,
       m.employee_id �Ŵ������̵�, m.first_name �Ŵ����̸�
from employees e, employees m
where e.manager_id = m.employee_id
and e.department_id > 80
order by ������̵�;

--5.student, professor ���̺�
--��� �л� ���(��, ���������� ���� �л��� ���) �л��̸�(name), �����̸�(name)
select * from student;   --20�� ����Į�� profno
select * from professor; --16�� ����Į�� profno

select s.name �л��̸� , p.name �����̸�
from student s, professor p
where s.profno = p.profno(+);

select s.name �л��̸� , p.name �����̸�
from student s inner join professor p
on s.profno = p.profno;

select s.name �л��̸� , p.name �����̸�
from student s left outer join professor p
on s.profno = p.profno;

select s.name �л��̸� , p.name �����̸�
from professor p right outer join student s
on s.profno = p.profno;



