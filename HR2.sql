-- 1. professor ���̺���,
-- �а����� �Ҽ� �������� ��ձ޿�, �ּұ޿�, �ִ�޿� ���
-- ��, ��� �޿��� 300�� �Ѵ� �͸� ���

SELECT
    deptno �а�, avg(pay) ��ձ޿�, min(pay) �ּұ޿�, max(pay) �ִ�޿�
FROM professor
GROUP BY deptno
HAVING avg(pay) > 300;

-- 2. student ���̺���,
-- �г�, �л���, ��� Ű, ��� �����Ը� ����ϵ�,
-- �л� ���� 4�� �̻��� �г⿡ ���ؼ� ���
-- ��, ��� Ű�� ��� �����Դ� �Ҽ��� ù��° �ڸ����� �ݿø�
-- ��� ������ ��� Ű�� ���� ������ ������������ ���
SELECT
    grade �г�, count(*) �л���, round(avg(height)) "��� Ű", round(avg(weight)) "��� ������"
FROM student
GROUP BY grade
HAVING count(*) >= 4
ORDER BY avg(height) DESC;

-- 3. professor, student ���̺���,
-- �л��̸��� �������� �̸��� ���
SELECT
    student.name �л�, professor.name ��������
FROM student
    JOIN professor
    ON student.profno = professor.profno;
    
-- 4. gift, customer ���̺���,
-- ���̸�(gname), ����Ʈ(point), ����(gname)�� ���
SELECT
    customer.gname ���̸�, TO_CHAR(point, '999,999') ����Ʈ, gift.gname ����
FROM customer JOIN gift
    ON customer.point >= gift.g_start
        AND customer.point <= gift.g_end;
-- ����Ŭ ����
SELECT
    customer.gname ���̸�, TO_CHAR(point, '999,999') ����Ʈ, gift.gname ����
FROM
    customer, gift
WHERE
    customer.point BETWEEN gift.g_start AND gift.g_end;
    
-- 5. student, score, hakjum ���̺���
-- �л��̸�(name), ����(total), ����(grade) ���
SELECT
    name �л��̸�, total ����, hakjum.grade ����
FROM student
    JOIN score
        ON student.studno = score.studno
    JOIN hakjum
        ON score.total BETWEEN hakjum.min_point AND hakjum.max_point;
    
-- ����Ŭ ����
SELECT
    name �л��̸�, total ����, hakjum.grade ����
FROM
    student, score, hakjum
WHERE
    student.studno = score.studno
    AND
    score.total BETWEEN hakjum.min_point AND hakjum.max_point;
  
------------------------

--student, professor ���̺�
select * from student; 
select * from professor;

--1. �л��̸��� �������� �̸� ����ϵ� ���������� �������� ���� �л� �̸��� ���
--ǥ��
select s.name �л��̸�, p.name ��������
from student s , professor p
where s.profno = p.profno(+);

--outer join
select s.name �л��̸�, p.name ��������
from student s left outer join professor p
               on s.profno = p.profno;
               
--natural join (����� �÷� : name, profno)
-- ����� �÷��� 2���̹Ƿ� �����߻�!!
--select name s.name �л��̸�, p.name ��������
--from student s natural join professor p

--join ~ using (������ ��������� �������� ���x)
select s.name �л��̸�, p.name ��������
from student s join professor p using(profno);

--join ~ on
select s.name �л��̸�, p.name ��������
from student s join professor p 
on s.profno = p.profno;


--2. 101(deptno1)�� �а��� �Ҽ�
--��, ���������� ���� �л��� ���(�а���ȣ, �л��̸�, �������� �̸�)
--ǥ��
select deptno1 �а���ȣ, s.name �л��̸�, p.name ��������
from student s, professor p
    where s.profno = p.profno(+)
and deptno1 = 101;

--outer join
select deptno1 �а���ȣ, s.name �л��̸�, p.name ��������
from student s left outer join professor p
on s.profno = p.profno
where deptno1 = 101;


--3. dept2 ���̺��� area�� seoul Branch office��
-- ����� �����ȣ(empno), �̸�(name), �μ���ȣ(deptno) ���
select dcode from dept2 where area = 'Seoul Branch Office';

select empno, name, deptno 
from emp2
where deptno in (1000,1001,1002,1010);

--��������
select empno, name, deptno
from emp2
where deptno in (select dcode from dept2 where area = 'Seoul Branch Office');

--join
select e2.empno, e2.name, e2.deptno, d2.area
from emp2 e2, dept2 d2
where e2.deptno = d2.dcode
and d2.area = 'Seoul Branch Office';

select e.empno, e.name, e.deptno, d.area
from emp2 e join dept2 d on e.deptno = d.dcode
where d.area = 'Seoul Branch Office';

--4. student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л��� �г�, �̸�, ������ ���
select grade, max(weight)
from student
group by grade;

select grade, name, weight
from student
where weight in (select max(weight) from student group by grade);

select grade, name, weight
from student
where (grade,weight) in (select grade, max(weight) from student group by grade);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    