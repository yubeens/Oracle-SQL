--@D:\jung\DATABASE\hr_test_data2.sql;
--professor ���̺�
--1. �а���(deptno) �� �Ҽ� �������� ��ձ޿�, �ּұ޿�, �ִ�޿� ���
-- ��, ��ձ޿��� 300 �Ѵ� �͸� ���
select * from professor;
select avg(pay), min(pay), max(pay)
from professor;
-- �а���
select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by  deptno;
---  ��ձ޿��� 300 �Ѵ� �͸� ���
select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by  deptno
HAVING avg(pay)>300;
--2.student ���̺�
--�г�(grade), �л���, ���Ű, ��� �����Ը� ����ϵ� 
--�л� ���� 4�� �̻��� �г⿡ ���ؼ� ���
--��, ��� Ű�� ��� �����Դ� �Ҽ��� ù��° �ڸ����� �ݿø�
--��¼����� ��� Ű�� ���� ������ ������������ ���
select  grade, count(*), round(avg(height)),round(avg(weight),0)
from student
group by grade
HAVING count(*) >=4
order by  avg(height) desc;

--3.  professor , student ���̺�
-- �л��̸�(name) �������� �̸�(name) ���
select * from professor; -- 16��
select * from student; --20��
select *
from professor,student; --320��
--����
select s.name �л��̸�, p.name ��������
from professor p, student s
where p.profno = s.profno;
--join~on
select s.name �л��̸�, p.name ���������̸�
from student s join professor p
                on s.profno = p.profno;
---gift, customer ���̺�
select * from gift;
select * from customer;
--4. ���̸�(gname), ����Ʈ(point), ����(gname)
select c.gname ��, to_char(c.point, '999,999') ����Ʈ, g.gname  ����
from gift g, customer c
where c.point between g.g_start and g.g_end;


select c.gname ��, to_char(c.point, '999,999') ����Ʈ, g.gname  ����
from gift g, customer c
where c.point >= g.g_start and c.point <= g.g_end;
--join~on
select c.gname, c.point, g.gname
from gift g join customer c
             on  c.point between g.g_start and g.g_end;
--5.�л����� �̸�(name), ����(total), ����(grade) ���
--student, score, hakjum
select * from student;  -- studno
select * from score;  --studno, total
select * from hakjum; -- min_point, max_point

select s.name �л��̸�, s1.total ����, h.grade ����
from student s, score s1, hakjum h
where s.studno = s1.studno 
   and s1.total between h.min_point and h.max_point;

select s.name �л��̸�, s1.total ����, h.grade ����
from student s, score s1, hakjum h
where s.studno = s1.studno 
   and s1.total >= h.min_point and s1.total <=h.max_point;

--join~on
select s.name, s1.total, h.grade
from student s join score s1
               on s.studno = s1.studno 
               join hakjum h
               on s1.total >= h.min_point and  s1.total <=h.max_point;
-----------------------------
--student, professor ���̺�
--1.�л��̸��� �������� �̸� ����ϵ� ���������� �������� ���� �л� �̸�(��� �л�)�� ���
select * from student; --20�� ���
select * from professor;
--  =============
select s.name  �л��̸�, p.name �����̸�  --- 15�� ���
from student s, professor p
where s.profno = p.profno;
--natural join 
--���� �߻�(����� �÷�: name, profno)
--select  s.name  �л��̸�, p.name �����̸�
--from student s natural join professor p;

--join using
select s.name  �л��̸�, p.name �����̸�
from student s join professor p using(profno);

--join on
select s.name  �л��̸�, p.name �����̸�
from student s join professor p on s.profno=p.profno;
--  =====����л�
select s.name  �л��̸�, p.name �����̸�  --- 20�� ���
from student s, professor p
where s.profno = p.profno(+);

select s.name  �л��̸�, p.name �����̸�  --- 20�� ���
from student s left outer join professor p 
            on s.profno = p.profno;

--2. 101(deptno1)�� �а��� �Ҽ�
-- ��, ���������� ���� �л�(����л�)�� ���(�а���ȣ, �л��̸�, ���������̸�)
select s.name  �л��̸�, p.name ��������, deptno1
from student s, professor p
where s.profno = p.profno(+)   and deptno1 =  101;
 
select s.name  �л��̸�, p.name ��������, deptno1
from student s left outer join professor p
on s.profno = p.profno
where deptno1 =  101;


--3. dept2���̺�/emp2 ����  area ��  Seoul Branch Office ��
-- ����� �����ȣ(empno), �̸�(name), �μ���ȣ(deptno) ���
select * from emp2;
select * from dept2;
select dcode from dept2 where area = 'Seoul Branch Office';

select empno, name, deptno 
from emp2
where deptno in (1000,1001,1002,1010);
--��������
select empno, name, deptno
from emp2
where deptno in (select dcode from dept2 where area ='Seoul Branch Office');

--join
select *
from emp2 e2, dept2 d2
where e2.deptno = d2.dcode
and d2.area = 'Seoul Branch Office';

select *
from emp2 e join dept2 d on e.deptno=d.dcode
where d.area = 'Seoul Branch Office';

--4.student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л��� �г�,�̸�, ������ ���
select grade, max(weight)
from student
group by grade;

select grade, name, weight
from student
where weight in (select max(weight) from student group by grade);

select grade, name, weight
from student
where (grade,weight) in (select grade, max(weight) from student group by grade);




