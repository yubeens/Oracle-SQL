--p251(������ ��������)-- in, all, any, exits
select ename, sal, job
from emp
where job = 'SALESMAN';

select ename, sal
from emp
where sal in (1600,1250,1500);

select ename, sal
from emp
where sal < any (1600,1250,1500);

select ename, sal
from emp
where sal < any(select sal
                from emp
                where job = 'SALESMAN');

select ename, sal
from emp
where sal < (select max(sal)
                from emp
                where job = 'SALESMAN');
-----
select ename, sal
from emp
where sal < all(select sal
                from emp
                where job = 'SALESMAN');
                
select ename, sal
from emp
where sal < (select min(sal)
                from emp
                where job = 'SALESMAN');
-- emp���̺�
--30�� �μ�  �޿�
select sal from emp where deptno=30;--1600,1250,2850,1500,950
--30�� �μ��� �ִ�޿����� ���� �޿��� �޴� ��� ���(any, all ���)
select *
from emp
where sal < (select  max(sal) from emp where deptno=30);

select *
from emp
where sal < any(select  sal from emp where deptno=30);

select *
from emp
where sal < all(select  sal from emp where deptno=30);

--30�� �μ��� �ִ�޿����� ���� �޿��� �޴� ��� ���(any, all ���)
select *
from emp
where sal > (select max(sal) from emp where deptno=30);

select *
from emp
where sal > all(select  sal from emp where deptno=30);

select * from dept;

select *
from dept
where EXISTS (select deptno
                from dept
                where deptno=20);
                
select *
from dept
where EXISTS (select deptno
                from dept
                where deptno=50);
--------
--p266
--DML(���۾�:data manipulation language):�����͸� �߰�,����,����==>���������۾�(insert, update, delete)
--DDL(data definition language):��ü�� ����, ����, �����ϴ� ���������Ǿ�(create,alter,drop)
--DCL

-- test1(no, name, address, tel)���̺� ���� ==>create table ���̺��(�÷� ����)
---   ����(5),���ڿ�(10),���ڿ�(50),���ڿ�(20)
create table test1(
    no number(5),
    name varchar2(10),
    address varchar2(50),
    tel varchar2(20)
);
select * from test1;
select count(*) from test1;
--(no,name) �� (1,'aaa') �߰� ==> insert into ���̺��(�÷�) values(��)
insert into test1(no,name) values(1,'aaa');
--(2, 'bbb','�λ�','010-1111-2222') �߰�
insert into test1(no, name,address,tel) values(2, 'bbb','�λ�','010-1111-2222');
--(3, 'ccc','����','010-3333-4444') �߰�
insert into test1(no, name, address, tel) values(3, 'ccc','����','010-3333-4444');
--(4, 'ddd','�뱸','010-4444-5555') �߰�
insert into test1 values(4, 'ddd','�뱸','010-4444-5555');
select * from test1;
--(5, 'eee','����') �߰�  
insert into test1(no, name,address) values(5, 'eee','����');
commit;
--(6, 'ffff','010-6666-7777') �߰� 
insert into test1(no, name,tel) values(6, 'ffff','010-6666-7777');
rollback;   
--test1 ���̺� no �� 2�� �������
select * from test1 where no=2;
--����==>no=2 �� ����� �̸��� ȫ�浿 ����
update test1
set name = 'ȫ�浿'
where no=2;
commit;
-- no�� 4�� name�� �̼���  /  address ����� ����
select * from test1 where no=4;
update test1
set name ='�̼���',address = '����'
where no=4;
--����
--test1���� no=1 ����
select * from test1;
delete test1 where no=1;
delete from test1 where no=2;
commit;
delete from test1;
rollback;

-- test ���̺� ����(no, name, hiredate)
                --����(4), ���ڿ�(20), date
create table test(
    no number(4) default 0,
    name varchar2(20)default 'NONAME',
    hiredate date default sysdate
);
-- test ���̺� �� (1, ȫ�浿) �߰�  
insert into test(no, name) values(1, 'ȫ�浿');
select * from test;
-- test �� 25/2/6 �߰�
insert into test(hiredate) values('25/2/6');
-- test���̺��� ��ȣ�� 1���� ����� �̸��� ������ ���� ����
update test
set name = '������'
where no=1;
-- test���� no = 0 �� ����
delete from test where no=0;
-- test���� no=2 �߰�
insert into test(no) values(2);
select * from test;
commit;
-------------
--CRUD(create, select ,update, delete)
--p266(CTAS:create table as select)
select * from dept;
-- dept_temp ���̺���� dept���̺� �״��
create table dept_temp
as select * from dept;

select * from dept_temp;
desc dept_temp;
--dept_temp ���̺� 50, DATABASE , SEOUL �߰�
insert into dept_temp values(50, 'DATABASE' , 'SEOUL');
commit;
--���̺� ������ ����
create table emp_temp
as select * from emp
where 1<>1;
select * from emp_temp;
--emp_temp : empno, ename, job, mgr, hiredate, sal, comm, deptno
--(2111,'�̼���','MANAGER',9999,'07/01/2019',4000,NULL,20) �߰�
insert into emp_temp
values(2111,'�̼���','MANAGER',9999,
      to_date('07/01/2019','DD/MM/YYYY'),4000,NULL,20);
describe emp_temp;
select * from emp_temp;

insert into emp_temp(empno,ename,job,mgr,hiredate,sal,deptno)
values(2112,'�̼���','MANAGER',9999,
      to_date('07/02/2025','DD/MM/YYYY'),4000,20);
                
insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(2113,'�̼���3','MANAGER',9999,
      to_date('06/02/2025','DD/MM/YYYY'),4000,null,20); 
insert into emp_temp
values(3111,'������','MANAGER',9999,sysdate,4000,null,20);
select * from emp_temp;
commit;

--p275
--���������� �̿��ؼ� �� ���� ���� �����͸� �߰�(values ������� �ʴ´�)
--emp���̺��� �޿��� �޿����(salgrade)�� 1(700~1200)����� emp_temp ���̺� �߰�
select * from emp_temp;
select * from salgrade;
select * from emp where sal between 700 and 1200;

insert into emp_temp
select * from emp
where sal between 700 and 1200;

insert into emp_temp(empno, ename,job, mgr, hiredate, sal ,comm, deptno)
select empno, ename,job, mgr, hiredate, sal ,comm, deptno from emp
where sal between 700 and 1200;
delete from emp_temp; --��� ������ ����
commit;
select * from emp_temp;
-- �޿����(salgrade)�� 3�� �����  emp_temp �߰�
--�޿����(salgrade)�� 3�� ��� ���ϱ�
select empno,ename, job, mgr,hiredate, sal, comm,deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade = 3;
--emp_temp �߰�
insert into emp_temp
select empno,ename, job, mgr,hiredate, sal, comm,deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade = 3;

select * from emp_temp;

--dept ���̺��� �����ؼ�  dept_temp2 ���̺��� �����ϰ�
-- 40�� �μ�����  DATABASE // ������  SEOUL �� ����
create table dept_temp2
as select * from dept;
select * from dept_temp2;

update dept_temp2
set dname = 'DATABASE', loc='SEOUL'
where deptno=40;
commit;
--dept_temp2  ���̺��� �μ���ȣ�� 40���� �μ���� ������ ����
-- dept ���̺��� 40�� �μ��� ������ �����ϱ�
select * from dept where deptno=40;

update dept_temp2
set dname='OPERATIONS', loc='BOSTON'
where deptno=40;

select * from dept_temp2;
rollback;

update dept_temp2
set dname=(select dname from dept where deptno=40) ,
  loc=(select loc from dept where deptno=40)
where deptno=40;

update dept_temp2
set (dname, loc) = (select dname, loc from dept where deptno=40)
where deptno=40;
commit;
--p262 9�� ��������
--1. ��ü ��� �� ALLEN �� ���� ��å(JOB)�� ������� �������, �μ����� ���
--job, empno, ename, sal, deptno, dname ���
select job, empno, ename, sal, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno
and job = (select job from emp where ename='ALLEN');
            
            
select job, empno, ename, sal, e.deptno, dname
from emp e join  dept d  on  e.deptno = d.deptno
where job = (select job from emp where ename='ALLEN');

select job, empno, ename, sal, deptno, dname
from emp e NATURAL join  dept d 
where job = (select job from emp where ename='ALLEN');

select job, empno, ename, sal, deptno, dname
from emp e  join  dept d using(deptno)
where job = (select job from emp where ename='ALLEN');
--2.��ü ����� ��� �޿����� 
--���� �޿��� �޴� ������� �������, �μ�����, �޿� ��� ���� ���
select empno,ename, dname, hiredate,loc, sal, grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno and e.sal between s.losal and s.hisal
and sal > (select avg(sal) from emp)
order by empno;

select empno,ename, dname, hiredate,loc, sal, grade
from emp e join  dept d on e.deptno=d.deptno
           join  salgrade s on  e.sal between s.losal and s.hisal
where sal > (select avg(sal) from emp)
order by empno;
--3. 10�� �μ��� �ٹ��ϴ� ��� ��
-- 30�� �μ����� �������� �ʴ� ��å�� ���� ������� ������� �μ����� ���
select empno, ename, job, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno
and e.deptno= 10
and job not  in (select  job from emp where deptno=30);

select empno, ename, job, e.deptno, dname, loc
from emp e join dept d on e.deptno =  d.deptno
where e.deptno= 10 and job not  in (select  job from emp where deptno=30);

select  job from emp where deptno=30;
--4.��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� 
--�������, �޿��������( �����ȣ�� ��������)
-- ������ �Լ��� ������� �ʴ� ���
select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > (select max(sal) from emp where job = 'SALESMAN')
order by empno;
--������ �Լ� ���

select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal -- all �� ���� �� Ŀ�� true
and sal > all(select sal from emp where job = 'SALESMAN') 
order by empno;

select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal -- any �� 1250 ���� ũ��  true
and sal > any(select sal from emp where job = 'SALESMAN')
order by empno;

--p287  10�� ��������
create table CHAP10HW_EMP  as select * from emp;
create table CHAP10HW_DEPT  as select * from dept;
create table CHAP10HW_salgrade  as select * from salgrade;
--1.
select * from CHAP10HW_DEPT;
insert into CHAP10HW_DEPT(deptno, dname, loc) values(50, 'ORACLE','BUSAN');
insert into CHAP10HW_DEPT(deptno, dname, loc) values(60, 'SQL','BUSAN');
insert into CHAP10HW_DEPT(deptno, dname, loc) values(70, 'SELECT','INCHEON');
insert into CHAP10HW_DEPT(deptno, dname, loc) values(80, 'DML','BUNDANG');
commit;
--2.
INSERT INTO CHAP10HW_EMP
VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016-01-02', 'YYYY-MM-DD'), 4500, NULL, 50);
INSERT INTO CHAP10HW_EMP
VALUES(7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016-02-21', 'YYYY-MM-DD'), 1800, NULL, 50);
INSERT INTO CHAP10HW_EMP
VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016-04-11', 'YYYY-MM-DD'), 3400, NULL, 60);
INSERT INTO CHAP10HW_EMP
VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016-05-31', 'YYYY-MM-DD'), 2700, 300, 60);
INSERT INTO CHAP10HW_EMP
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016-07-20', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016-09-08', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016-10-28', 'YYYY-MM-DD'), 2300, NULL, 80);
 
INSERT INTO CHAP10HW_EMP
VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2018-03-09', 'YYYY-MM-DD'), 1200, NULL, 80);
commit;
select * from CHAP10HW_EMP;
--3. CHAP10HW_EMP �� ���� ��� �� 
-- 50�� �μ����� �ٹ��ϴ� ������� ��� �޿����� ���� �޿��� �ް� �ִ� �������
-- 70�� �μ��� �ű��
select avg(sal) from CHAP10HW_EMP where deptno = 50;  --3150
update CHAP10HW_EMP
set deptno = 70
where sal > 3150;

update CHAP10HW_EMP
set deptno = 70
where sal > (select avg(sal) from CHAP10HW_EMP where deptno = 50);
commit;
select * from CHAP10HW_EMP;
--4. CHAP10HW_EMP �� ���� ��� ��
--60�� �μ��� ��� �߿� �Ի����� ���� ���� ������� �ʰ� �Ի��� 
-- ����� �޿��� 10% �λ��ϰ� 80�� �μ���  �ű��
select min(hiredate) from CHAP10HW_EMP where deptno = 60; --16/05/31

update CHAP10HW_EMP
set sal = sal*1.1, deptno = 80
where hiredate > '16/05/31';

update CHAP10HW_EMP
set sal = sal*1.1, deptno = 80
where hiredate > (select min(hiredate) from CHAP10HW_EMP where deptno = 60);
commit;
select * from CHAP10HW_EMP;

--5. CHAP10HW_EMP�� ���� ��� �� �޿� ����� 5�� ����� �����Ѵ� SQL
select * from CHAP10HW_EMP;
select *
from CHAP10HW_EMP e,  CHAP10HW_SALGRADE s
where e.sal between s.losal and s.hisal and grade = 5;  -- 5000,4500,3400
-- ����
delete from CHAP10HW_EMP
where sal in (5000,4500,3400);
rollback;

delete from CHAP10HW_EMP
where sal in (select sal
            from CHAP10HW_EMP e,  CHAP10HW_SALGRADE s
            where  e.sal between s.losal and s.hisal and grade = 5);
commit;
select * from CHAP10HW_EMP;
---------------------------------
--dept_temp2 ��� ������ ����
select * from dept_temp2;
delete from dept_temp2;
commit;
----dept_temp2 ���̺� ����
drop table  dept_temp2;
-- �����߻�(���̺� ���� �Ǿ)
--select * from dept_temp2
--dept_temp ���̺� ����
drop table dept_temp;
--emp_temp ���̺� ����
drop table emp_temp;

--- dept ���̺��� �̿��ؼ�  dept_temp ���̺� ����
create table dept_temp
as select * from dept;

select * from dept_temp;
--LOCATION   �÷� �߰�
alter table dept_temp add(LOCATION varchar2(30));
--10�� �μ��� LOCATION �� �������� ����
update dept_temp
set LOCATION = '����'
where deptno = 10;
-- LOCATION   �÷� ���� : varchar2(70)
alter table dept_temp modify(LOCATION  varchar2(70));
describe dept_temp;
-- LOCATION   �÷� ����
alter table dept_temp drop column LOCATION;
-- LOC �÷����� LOCATION ����
alter table dept_temp rename column LOC to LOCATION;
describe dept_temp;
--���̺� �̸� ���� dept_temp ==> dept_temptemp
alter table dept_temp rename to dept_temptemp;
describe dept_temptemp;
rename dept_temptemp to dept_temp;

-- dept_temp ������ ��� ����
delete from dept_temp;
select * from dept_temp;
--���
rollback; --������ ���� ����
-- dept_temp ������ ��� ����(truncate :DDL�̹Ƿ� rollback ������� �ʾ� ���� �ȵ�)
truncate table dept_temp;
select * from dept_temp;
--���
rollback; --  rollback   �ص� ������ ���� �ȵ�
select * from dept_temp;
-- dept_temp ���̺����
drop table dept_temp;
--���� �߻�
--select * from dept_temp;
----------------
select * from test1;
--1.�÷� �߰� :  birthday date �� 
alter table test1 add (birthday date) ;
describe test1;
--2.�÷� �� ���� : tel => phone 
alter table test1 rename column tel to phone;
--3 no �÷��� ����
alter table test1 drop column no;

--4. num �÷� �߰� : number(3)
alter table test1 add(num number(3));
--5. address ���ڿ�(50)==> ���ڿ�(70) ����
alter table test1 modify (address varchar2(70));
describe test1;
--6. test1 ���̺� �̸��� ==> testtest
alter table test1 rename to testtest;
select * from testtest;
rename testtest to test2;
select * from test2;
--���̺� ����
drop table test2;
---�����߻�(���̺� ����)
--select * from test2;



