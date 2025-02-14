select * from emp;
--p.174~175(��������)
--1. empno�� empno �� ���ڸ� �� ���ڸ��� *��ȣ ���, ename�� ename��� �̸��� ù���ڸ� �����ְ� ������ *��ȣ�� ���
-- ��� �̸�(ename) �� �ټ����� �̻��̸� ���� ���� �̸��� ��� ���� ���
--empno, masking_empno, ename, masking_ename

select empno,
       RPAD (substr(empno,1,2),length(empno),'*') masking_empno,
       ename,
       RPAD (substr(ename,1,1),length(ename),'*') masking_ename
    from emp;
    
select empno,
       RPAD (substr(empno,1,2),length(empno),'*') masking_empno,
       ename,
       RPAD (substr(ename,1,1),length(ename),'*') masking_ename
    from emp
    where length(ename)=5;
    
    
--2. �Ϸ� �ٹ��ð��� 8�ð����� ������ �� ������� �Ϸ� �޿�(day-pay)�� �ñ�(time-pay)�� ����Ͽ� ���
-- �Ϸ� �޿��� �Ҽ��� ����° �ڸ����� ������, �ñ��� �� ��° �Ҽ������� �ݿø�
-- empno, ename, sal, day_pay, time_pay

select empno, ename, sal,
    trunc(sal/21.5,2) day_pay, -- ǥ���Ǿ����� ������
    round(sal/21.5/8,1) timp_pay 
from emp;


--3. ������� �Ի���(hiredate)�� �������� 3������ ���� �� ù �����Ͽ� �������� �ȴ�.
-- ������� �������� �Ǵ� ��¥(r_job)�� yyyy-mm-dd�������� ��� / �� �߰������� ���� ����� N/A�� ���

select empno, ename, hiredate,comm,
    add_months(hiredate,3)"3���� ��",
    next_day(add_months(hiredate,3),'��')R_JOB
from emp;

--yyyy-mm-dd����, n/a ���
desc emp;
select empno, ename, hiredate,comm,
    to_char(next_day(add_months(hiredate,3),'��'),'yyyy-mm-dd')R_JOB,
    nvl(to_char(comm), 'N/A')COMM  --���ڸ� ���ڷ� �ٲ� �� ����
from emp;


--4.���ӻ���� �����ȣ(mgr)�� �������� ���� ��� = 0000, �� ���ڸ��� 75 = 5555
-- �� ���ڸ� 76 = 6666, 77 = 7777, 78 = 8888, �� �� �״�� ���

select empno, ename, mgr,
case 
    when mgr is null then 0000
    when substr(mgr,1,2) = 75 then 5555
    when substr(mgr,1,2) = 76 then 6666
    when substr(mgr,1,2) = 77 then 7777
    when substr(mgr,1,2) = 78 then 8888
    else mgr
end CHG_MGR
from emp;

--���� �� ��ȯ �������
select empno, ename, mgr,
case 
    when mgr is null then '0000'
    when substr(mgr,1,2) = '75' then '5555'
    when substr(mgr,1,2) = '76' then '6666'
    when substr(mgr,1,2) = '77' then '7777'
    when substr(mgr,1,2) = '78' then '8888'
    else to_char(mgr)
end CHG_MGR
from emp;

--decode
select empno, ename, mgr,
    decode(substr(mgr,1,2),null, '0000',
            '75','5555',
            '76','6666',
            '77','7777',
            '78','8888',
            to_char(mgr)) CHG_MGR
from emp;


select sal from emp;
select DISTINCT(sal) from emp; --DISTINCT �ߺ�����

--p.177
--�׷��Լ� = �������Լ� = �������Լ�(�ϳ��� ���� ��� ����� ��� ������ �Լ�)
select sal, comm from emp;
select sum(sal),sum(comm) from emp;
select count(sal) from emp;
select count(distinct(sal)) from emp;
select count(comm) from emp;
select count(empno) from emp;
select count(*) from emp;

-- emp���̺��� �μ���ȣ(deptno)�� 30���� ��� �� 
select count(*)
from emp
where deptno = 30;

--comm �� null�� �ƴ� ��
select count(comm) from emp;

select count(comm)
from emp
where comm is not null;

--comm�� null�� ��
select count(*),count(comm)
from emp
where comm is null;

select comm
from emp
where comm is null;

--���� �߻� (ename���� 12ro, sum(sal)�� ���� 1���̱� ������ ����)
select ename, sum(sal) from emp;

select count(sal), count(distinct(sal)),count(all(sal))
from emp;

--�ִ밪
select sal from emp;
select max(sal) from emp;

--�ּҰ�
select sal from emp;
select min(sal) from emp;

select max(sal), min(sal) from emp;

--���
select avg(sal) from emp;

--��� �ݿø�, �Ҽ� ù��°���� ���
select round(avg(sal),1) from emp;

--�μ���ȣ�� 20�� ����߿��� �Ի����� ���� �ֱ��� ��� ���
select max(hiredate)
from emp;

---------------------
--professor ���̺�
select * from professor;

--1. �� ���� �� ���
select count(*) from professor;
--2. ���� �޿� �հ�
select sum(pay) from professor; 
--3. ���� �޿� ���
select avg(pay) from professor;
--4. ������ �޿��� ����� �Ҽ��� ù° �ڸ����� �ݿø�
select round(avg(pay)) from professor;
--5. �ְ� �޿�
select max(pay) from professor;
--6. ���� �޿�
select min(pay) from professor;
--7. ���� �� �ְ� �޿��� �޴� ���� �̸�(name)�� �޿�(pay) ���
select name, pay from professor;

select name, pay 
from professor
where pay = 570;

select name, pay 
from professor
where pay = (select max(pay) from professor);

--8. ���� �޿� �հ踦 ���, õ ���� ��ǥ ���
select sum(pay), to_char(sum(pay),'9,999')sum_pay
from professor;


------------emp ���̺�
select * from emp;

--1.10�� �μ�(deptno)�� ��� �޿�
select round(avg(sal)) from emp where deptno = 10;
--1.20�� �μ�(deptno)�� ��� �޿�
select round(avg(sal)) from emp where deptno = 20;
--1.30�� �μ�(deptno)�� ��� �޿�
select round(avg(sal)) from emp where deptno = 30;

--�μ���ȣ�� 10,20,30�� �μ��� ��� �޿�
--���տ����� (union)
select round(avg(sal)) from emp where deptno = 10
union
select round(avg(sal)) from emp where deptno = 20
union
select round(avg(sal)) from emp where deptno = 30;

--in
select round(avg(sal)) from emp where deptno in(10,20,30);

--�μ��� ��� �޿�
select deptno,round(avg(sal))"�μ��� ��� �޿�"
from emp
group by deptno
order by deptno;

select deptno,round(avg(sal))"�μ��� ��� �޿�"
from emp
group by deptno
order by "�μ��� ��� �޿�"; -- �ν� ����


select * from emp;
select * from emp where deptno =30;
--�μ�(deptno) �� ���޺�(job) ��� �޿�
--�μ���ȣ ��������, ���� �޿� ������ ���

select round(avg(sal))
from emp
group by deptno;

select deptno,job,round(avg(sal))AVG_SAL
from emp
group by deptno,job
order by deptno desc, AVG_SAL desc;


--------------
--professor ���̺�
select * from professor;

--1.�а���(deptno) �������� ��� �޿�(pay)
select deptno, round(avg(pay))��ձ޿� from professor group by deptno order by deptno desc;

--2.�а��� �������� �޿� �հ�
select deptno, sum(pay) �޿��հ� from professor group by deptno order by deptno desc;

--3.�а��� ���޺�(position) �������� ��� �޿�
select deptno, position , round(avg(pay))��ձ޿� from professor group by deptno,position order by deptno desc;

--4.���� �߿��� �޿�(pay)�� ��������(bonus)�� ��ģ �ݾ��� ���� ���� ���� ���� ���� ��츦 ��� / ��, bonus�� ���ٸ� 0���� ���
--�޿�(��ģ�ݾ�)�� �Ҽ� ��° �ڸ����� �ݿø�
select pay,bonus, pay+bonus, pay+nvl(bonus,0)�޿�,
       nvl(pay+bonus,0)�޿�1,
       nvl2(pay+bonus, pay+bonus, pay)�޿�2
from professor;

select round(max(pay+nvl(bonus,0)),1)�ִ�޿�, 
       round(min(pay+nvl(bonus,0)),1)�ּұ޿�
from professor;

--5. ����(position)�� ��� �޿�(pay)�� 300���� ũ�� '���', �۰ų� ������ '����'
--����(position), ��ձ޿�, ��� ���
select position, round(avg(pay))��ձ޿�,
case 
    when avg(pay) > 300 then '���'
    when avg(pay) <= 300 then '����'
end ���
from professor
group by position;

------------------
--emp���̺��� �Ի�⵵�� �ο���
-- total  1980�⵵  1981�⵵  1982�⵵
-- 12       1        10        1
select hiredate from emp;

select count(*) total,
    sum(decode(to_char(hiredate,'YYYY'),1980,1,0))"1980�⵵",
    sum(decode(to_char(hiredate,'YYYY'),1981,1,0))"1981�⵵",
    sum(decode(to_char(hiredate,'YYYY'),1982,1,0))"1982�⵵"
from emp;
-------------------
select count(*) total,
    count(decode(to_char(hiredate,'YYYY'),1980,2,null))"1980�⵵",
    count(decode(to_char(hiredate,'YYYY'),1981,3,null))"1981�⵵",
    count(decode(to_char(hiredate,'YYYY'),1982,4,null))"1982�⵵"
from emp;

-- emp���̺��� 1,000�̻��� �޿��� ������ ����� ���ؼ��� �μ��� ����� ���ϵ�
-- �� �μ��� ����� 2,000�̻��� �μ���ȣ, �μ��� ��ձ޿� ���
select deptno, round(avg(sal))
from emp
where sal >= 1000
group by deptno
HAVING avg(sal) >= 2000; --group by�� ������ where X, having���� �ؾ���


-----------professor ���̺�
select * from professor;
--1.�а����� �Ҽ� �������� ��� �޿�, �ּ� �޿�, �ִ� �޿� ���ϱ�
--��, ��� �޿��� 300 �Ѵ� �͸� ���
select deptno, round(avg(pay))��ձ޿�, min(pay)�ּұ޿�, max(pay)�ִ�޿�
from professor
group by deptno
having avg(pay) > 300;

select deptno, avg(pay)��ձ޿�, min(pay)�ּұ޿�, max(pay)�ִ�޿�
from professor
where pay > 300
group by deptno;

--2.�а���(deptno), ���޺�(position)�������� ��� �޿� ���ϱ�
--��� �޿��� 400 �̻��� �͸� ��� => �а���ȣ, ����, ��ձ޿�
select deptno �а���ȣ, position ����, round(avg(pay))"��� �޿�"
from professor
group by deptno, position
having avg(pay) >= 400;

-----------student ���̺�
--3.�г⺰(grade) �л���, ��� Ű, ��� ������ ���ϱ�
--��, �л����� 4�� �̻��� �͸� ���, ��� Ű�� ��� �����Դ� �Ҽ��� ù°�ڸ����� �ݿø�
--��¼��� : ��� Ű�� ���� ������ ������������ ���
select * from student;

select grade, count(*) �л���, round(avg(height))"��� Ű", round(avg(weight)) "��� ������"
from student
group by grade
having count(*) >= 4
order by "��� Ű" desc;

--p.196
--1.�μ� �� ���޺� 
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by deptno, job
order by deptno, job;

--rollup(A,B) A,B / A�� ���� �͵� ���
--rollup(A,B,C) A,B,C / A,B/C�� ���� �͵� ���
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by rollup(deptno, job)
order by deptno, job;

--cube(A,B) A,B / A/B�� ���� �͵� ���
--cube(A,B,C) A,B,C / A,B/ A,C/ B,C/ A/B/C�� ���� �͵� ���
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by cube(deptno, job)
order by deptno, job;

--emp���̺�
--�μ��� ���޺� ��� �޿� �� ��� �� ���ϱ�
--��, �μ��� ��ձ޿��� ��� ��, ��ü ����� ��ձ޿��� ��� �� ���
select deptno, job, avg(sal), count(*)
from emp
group by deptno, job
order by deptno, job;

select deptno, job, round(avg(sal)), count(*)
from emp
group by rollup(deptno, job) 
order by deptno, job;

select deptno, job, round(avg(sal)), count(*)
from emp
group by rollup(job, deptno) --���޺�, ��ü �Ұ� ���
order by job,deptno;

--�μ� �� ���޺� ��� �޿��� ��� �� ���
--��, �μ��� ��� �޿��� ��� ��, ���޺� ��� �޿��� ��� ��, ��ü ����� ��� �޿��� ��� ��
select deptno, job, round(avg(sal)), count(*)
from emp
group by deptno, job
order by deptno, job;

---------------------
--p.212 7�� ��������
select * from emp;
--1.emp���̺��� �μ���ȣ(deptno), ��ձ޿�(avg_sal), �ְ�޿�(max_sal), �����޿�(min_sal), ��� ��(cnt)�� ���
--��, ��� �޿��� �Ҽ����� �����ϰ� �� �μ� ��ȣ���� ���
select deptno, round(avg(sal)) ��ձ޿�, max(sal) �ְ�޿�, min(sal) �����޿�, count(*) cnt
from emp
group by deptno
order by deptno desc;

--2. ���� ��å(job)�� �����ϴ� ����� 3�� �̻��� ��å�� �ο���(count)�� ���
select job, count(*)
from emp
group by job
having count(*) >= 3;

--3. ������� �Ի翬��(hire_year)�� �������� �μ���(deptno)�� �� ��(cnt)�� �Ի��ߴ��� ���
select to_char(hiredate,'YYYY') from emp;

select to_char(hiredate,'YYYY')Hire_year, deptno, count(*)cnt
from emp 
group by deptno, to_char(hiredate, 'YYYY')
order by to_char(hiredate, 'YYYY') desc;

--4. �߰�����(comm)�� �޴� ��� ���� ���� �ʴ� ��� �� ���
--exist_comm(o,x) , cnt
select nvl2(comm, 'O','X') EXIST_COMM
from emp;

select nvl2(comm, 'O','X') EXIST_COMM, count(*)cnt
from emp
group by nvl2(comm,'O','X');

--5. �� �μ���(deptno) �Ի� ������(hire_year) ��� ��(cnt), �ְ�޿�(max_sal), �޿� ��(sum_sal), ��ձ޿�(avg_sal)�� ��� 
--�� �μ��� �Ұ�� �Ѱ赵 ���
select deptno, to_char(hiredate,'YYYY') Hire_year, count(*) cnt, max(sal) max_sal, sum(sal) sum_sal, round(avg(sal)) avg_sal
from emp
group by rollup(deptno, to_char(hiredate, 'YYYY'))
order by deptno, to_char(hiredate, 'YYYY');

--�� �μ���, �� ������, ��ü �Ұ�
select deptno, to_char(hiredate,'YYYY') Hire_year, count(*) cnt, max(sal) max_sal, sum(sal) sum_sal, round(avg(sal)) avg_sal
from emp
group by cube(deptno, to_char(hiredate, 'YYYY'))
order by deptno;

---------------------
--p.215 ����
select * from emp; --12��
select * from dept; -- 4��

--smith�� �ٴϴ� �μ��� ���
select deptno from emp where ename = 'SMITH';
select dname from dept where deptno = 20;

select dname
from dept
where deptno = (select deptno from emp where ename = 'SMITH');

------
select * --48�� ���
from emp , dept;

select * 
from emp e , dept d
where e.deptno = d.deptno;
--�����ȣ(empno), ����̸�(ename), ����(job), �μ���(dname), ����(loc)
--�����
select empno, ename, job, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

select * from emp;
select * from salgrade;

--������
select *
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

select *
from emp e, salgrade s
where e.sal >= s.losal and e.sal <= s.hisal;

select * from emp;
--smith�� ����� �̸���?
select mgr from emp where ename = 'SMITH';
select ename from emp where empno = 7902;

select ename 
from emp
where empno = (select mgr from emp where ename = 'SMITH');

--��ü����(self join)
--����� ���(mgr)�� ���� ���
select *
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;

select e1.empno �����ȣ, e1.ename ����̸�, e1.mgr �������ȣ,
       e2.empno �������ȣ, e2.ename ����̸�
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;




