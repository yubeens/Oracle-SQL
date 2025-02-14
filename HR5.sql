--1. Professor ���̺��  department ���̺�
--������ȣ(profno)�� �����̸�(name), �Ҽ��а��̸�(dname)�� ��ȸ�ϴ�
--view ���� (v_prof_dept2)
select * from professor;
select * from department;

select *
from professor p, department d
where p.deptno = d.deptno;

----

create view v_prof_dept2
    as select profno,name,dname
        from professor p, department d
        where p.deptno = d.deptno;

select * from v_prof_dept2;

--2.1�� �並 �б� ��������  v_prof_dept3
create or replace view v_prof_dept3 
    as (select * from v_prof_dept2)
    with read only;
    
select * from v_prof_dept3;

--3. student , department ����Ͽ� 
--�а���(deptno1)�� �л����� �ִ�Ű�� �ִ� ������, �а� �̸��� ���
select * from student;
select * from department;

select s.deptno1, d.dname
from student s, department d
where s.deptno1 = d.deptno;

select s.name, s.weight,d.dname
from student s, department d
where s.deptno1 = d.deptno;

select s.deptno1 deptno, s.name, s.weight max_weight, d.dname
from student s 
join department d on s.deptno1 = d.deptno
where s.weight = (select max(s2.weight) 
                    from student s2
                    where s2.deptno1=s.deptno1
                    );
                    
------
select s.deptno1, d.dname, s.max_height, s.max_weight
from ( select deptno1, max(height) max_height, max(weight) max_weight
        from student
        group by deptno1) s, department d
where s.deptno1 = d.deptno;

select s.deptno1, d.dname, s.height, s.weight
from student s, department d
where s.deptno1 = d.deptno
and(s.deptno1, s.height, s.weight)
    in(select deptno1, max(height), max(weight)
        from student
        group by deptno1);
         
--(DNAME      MAX_HEIGHT    MAX_WEIGHT)
--4. �а��̸�, �а��� �ִ�Ű, �а����� ���� Ű�� ū �л����� �̸��� Ű��  
select deptno1, max(height)
from student s
group by deptno1;

--�ζ��κ�
select d.dname, s.max_height, s1.name, s1.height
from (select deptno1, max(height) max_height
        from student 
        group by deptno1)s, department d, student s1
where s.deptno1 = d.deptno 
and s.deptno1 = s1.deptno1 
and max_height = s1.height;

select d.dname, height �ִ�ŰȮ��, s.name, s.height 
from student s, department d
where s.deptno1 = d.deptno
and (deptno1,height) in (select deptno1, max(height) max_height
                        from student 
                        group by deptno1);

--5.  student �л��� Ű�� ���� �г��� ��� Ű���� ū �л���                           
--�г�, �̸�,Ű, �ش� �г��� ���Ű ��� (�ζ��κ� �̿�, �г����� ��������)
select grade, avg(height)
from student
group by grade;

select g.grade, g.���Ű, s.height �л�Ű
from (select grade, avg(height) ���Ű
        from student
        group by grade)g, student s
where g.grade = s.grade
and s.height > g.���Ű;

