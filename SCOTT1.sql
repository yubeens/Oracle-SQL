--emp ��� ���� ��ȸ
select * from emp;
--dept ��� ���� ��ȸ

--dept���̺� : �μ����� ���̺�
--emp���̺� : ������� ���̺�
select * from dept;

--1. �μ���ȣ(deptno)�� 10���� ��� ��� ������ ���
select * from emp where deptno = 10;

--2. �μ���ȣ(deptno)�� 10���� �̸�(ename), �Ի���(hiredate), �μ���ȣ(deptno)���
select ename, hiredate, deptno from emp where deptno = 10;

--3. �����ȣ(empno)�� 7369�� ����� �̸�, �Ի���, �μ���ȣ ���
select ename, hiredate, deptno from emp where empno = 7369;

--4. �̸�(ename)�� allen�� ����� ��� ���� ��� (���ڴ� ��������ǥ('')�� ��ҹ��� ���� / ��ɾ�� ��ҹ��� ����X)
select * from emp where ename = 'ALLEN';
SELECT * FROM EMP WHERE ENAME = 'ALLEN';

--5. �Ի���(hiredate)�� 1980 12 17�� ����� �̸�(ename), �μ���ȣ(deptno), ����(sal) ���
select ename, deptno, sal from emp where hiredate = '1980/12/17';
select ename, deptno, sal from emp where hiredate = '80/12/17';

--6. ����(job)�� MANAGER�� ����� ��� ���� ���
select * from emp where job = 'MANAGER';

--7. ����(job)�� MANAGER�� �ƴ� ����� ��� ���� ���
select * from emp where job != 'MANAGER';
select * from emp where job <> 'MANAGER';

--8. �Ի���(hiredate)�� 81/04/02 ���Ŀ� �Ի��� �������
select * from emp where hiredate > '81/04/02';
describe emp;
desc emp;

--9. �޿�(sal)�� 1,000 �̻��� ����� �̸�(ename), �޿�(sal), �μ���ȣ(deptno) ��ȸ
select ename, sal, deptno from emp where sal >= 1000;
select * from emp where sal >= 1000;

--10. �޿�(sal)�� 1,000 �̻��� ����� �̸�(ename), �޿�(sal), �μ���ȣ(deptno)�� ���� ������ ��� (order by - ���� , desc - ��������, asc - ��������)
select ename, sal, deptno from emp where sal >= 1000 order by sal desc;
select ename, sal, deptno from emp where sal >= 1000 order by sal asc;

-- �޿��� ������������ ����ϳ� �޿��� ���ٸ� �̸����� �������� ���
select ename, sal, deptno from emp where sal >= 1000 order by sal desc, ename asc;

--11. �̸��� 'K'�� �����ϴ� ������� ���� �̸��� ���� ����� ��� ����
select * from emp where ename > 'K';

--���տ�����(UNION)
--emp ���̺��� �μ���ȣ�� 10�� �����ȣ(empno), �̸�(ename), �޿�(sal), �μ���ȣ(deptno) ���
--emp ���̺��� �μ���ȣ�� 20�� �����ȣ(empno), �̸�(ename), �޿�(sal), �μ���ȣ(deptno) ���
select empno, ename, sal, deptno from emp where deptno = 10
UNION
select empno, ename, sal, deptno from emp where deptno = 20;

--���տ�����(MINUS)
--��� �μ��߿��� 20�� �μ��� �����ϰ� ���
select * from emp
MINUS
select * from emp where deptno = 20;

--���տ����� (INTERSECT)
--��� �μ��߿��� 20�� �μ��� ���
select * from emp
INTERSECT
select * from emp where deptno = 20;

--12. �μ���ȣ�� 10�̰ų� 20�� �μ��� ������� ��� (union, or, in())
select empno, ename, sal, deptno from emp where deptno = 10 or deptno = 20;
select empno, ename, sal, deptno from emp where deptno in (10,20);

--13. ����̸��� �빮�� S�� ������ ����� ��� ���� ��ȸ
select * from emp where ename like '%S';

--14. 30�� �μ����� �ٹ��ϴ� ��� �� job�� SALESMAN ����� �����ȣ(empno), �̸�(ename), ��å(job), �޿�(sal), �μ���ȣ(deptno) ��ȸ
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN';

-- 15. 30�� �μ����� �ٹ��ϴ� ��� �� job�� SALESMAN ����� �����ȣ(empno), �̸�(ename), ��å(job), �޿�(sal), �μ���ȣ(deptno) ��ȸ / �޿��� ���������� ��ȸ
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN' order by sal desc;

-- 15. 30�� �μ����� �ٹ��ϴ� ��� �� job�� SALESMAN ����� �����ȣ(empno), �̸�(ename), ��å(job), �޿�(sal), �μ���ȣ(deptno) ��ȸ / �޿��� ���ٸ� �����ȣ�� ���� �� ���� ���
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN' order by sal desc, empno asc;

----------------------------
--[20��,30�� �μ��� �ٹ��ϴ� ��� �߿��� �޿�(sal)�� 2,000�� �ʰ��ϴ� ����� �����ȣ(empno), �̸�(ename), �޿�(sal), �μ���ȣ(deptno) ���

--17. ���տ����� ���
select empno, ename, sal, deptno from emp where deptno = 20 and sal > 2000
UNION
select empno, ename, sal, deptno from emp where deptno = 30 and sal > 2000;

select empno, ename, sal, deptno from emp where deptno in (20,30)
INTERSECT
select empno, ename, sal, deptno from emp where sal > 2000;

--18. ���տ����� ������� �ʰ�
select empno, ename, sal, deptno from emp where sal >= 2000 and deptno in (20,30);

select empno, ename, sal, deptno from emp where (deptno = 20 or deptno = 30) and sal > 2000;

--19. �޿�(sal)�� 2,000�̻� 3,000���� ������ ��� ���� ���
select * from emp where sal >=2000 and sal <=3000;

select * from emp where sal BETWEEN 2000 and 3000;

--20. �޿�(sal)�� 2,000�̻� 3,000���� ���� �̿��� ��� ���� ���
select * from emp where sal <2000 or sal >3000;

select * from emp where sal NOT BETWEEN 2000 and 3000;

--21. ����̸�, �����ȣ, �޿�, �μ���ȣ ���
select ename, empno, sal, deptno from emp;

select ename as ����̸�, empno as �����ȣ, sal �޿�, deptno "�μ� ��ȣ" from emp;

select ename as ����̸�, empno as �����ȣ, sal �޿�, deptno �μ�_��ȣ from emp;

--22. ����̸��� E�� ���ԵǾ� �ִ� 30�� �μ� ��� �߿��� �޿��� 1,000���� 2,000���̰� �ƴ� ����� ��� / �÷����� ����̸�, ��� ��ȣ, �޿�, �μ� ��ȣ ����ϱ�
select ename ����̸�, empno "��� ��ȣ", sal �޿�, deptno "�μ� ��ȣ" from emp where ename like '%E%' and deptno = 30 and sal not BETWEEN 1000 and 2000;

--23. �ְ�����(comm)�� �������� �ʴ�(���� �� ����) ��� ���� ���
select * from emp where comm is null;

--24. �ְ�����(comm)�� �����ϴ� ��� ���� ���
select * from emp where comm is not null and comm <>0;

--25. �ְ�����(comm)�� �������� �ʰ�, �����(mgr)�� �ְ�, ������ MANAGER, CLERK�� ��� �߿��� ����̸��� �ι�° ���ڰ� L�� �ƴ� ������� ���
select * from emp where comm is null and mgr is not null and job in ('MANAGER','CLERK') and ename not like '_L%';

-------------p.128 ����Ŭ�Լ�(�����Լ�)
select * from emp;
select  ename, upper(ename) as �빮��, lower(ename) �ҹ���, initcap(ename)
from emp;
--ename ���
select ename, length(ename) �̸����ڼ� 
from emp;
--��� �̸��� 5���� �̻��� ����� �̸��� ���� �� ���
select ename ,length(ename) as ���ڼ� from emp
where length(ename)>=5;
--�̸� ����
select ename, substr(ename,1,2), substr(ename,3,2), substr(ename,3),substr(ename,3,length(ename)),
              length(substr(ename,3)),length(substr(ename,3,length(ename)))
from emp;
------------
select 'CORPORATE FLOOR'
from dual;
--��ġ�� ����
select instr('CORPORATE FLOOR','OR',1,1)
from dual;

select instr('CORPORATE FLOOR','OR')
from dual;

select instr('CORPORATE FLOOR','OR',1,2)
from dual;

select instr('CORPORATE FLOOR','OR',-1,1)
from dual;

select instr('CORPORATE FLOOR','OR',-3,1)
from dual;

select instr('CORPORATE FLOOR','OR',-3,2)
from dual;
--- ���ڿ� ABCDEF���� D�� ��ġ�� ���
--- ó������ ù��° ��ġ��
select instr('ABCDDEF','D')
from dual;

--- ������ ù��° ��ġ��
select instr('ABCDDEF','D',-1,1)
from dual;
--- emp���̺��� ename�� s�� �ִ� ��ġ ���
select ename, instr(ename, 'S'), instr(ename,'S',-1,1), instr(ename,'S',3)
from emp;
--- emp���̺��� ����̸��� s�� ����ִ� �̸��� ��� (instr �Լ� ���)
select ename
from emp
where instr(ename,'S') > 0;

-- emp ���̺��� ename ��� (�̸��� 2���ڸ� �����Ͽ� �ҹ��ڷ� ��ȯ�ؼ� ���)
select substr(lower(ename),1,2)
from emp;

select ename, lower(substr(ename,1,2)) �ҹ���, substr(lower(ename),1,2)�ҹ���1
from emp;

-- Replace ��ü
select '010-1234-5678' as rep_before, 
    replace('010-1234-5678','-',' ') as rep_after
from dual;
-- emp ���̺��� s�� �ҹ��� s�� �����Ͽ� ��� (replace �Լ� ���)
select ename, replace(ename,'S','s')
from emp;

--
select length('�ѱ�'), lengthB('�ѱ�')
from dual;

select 'Oracle',length('Oracle'),lengthB('Oracle')
from dual;

select 'Oracle',LPAD('Oracle',10,'#')LPAD1,
                RPAD('Oracle',10,'#')RPAD1,
                LPAD('Oracle',10)LPAD2, length(LPAD('Oracle',10)),
                RPAD('Oracle',10)RPAD2
from dual;

-- emp ���̺��� �����ȣ(�� 2�ڸ� - ����, ������ - *), ��� �̸�(�� 2���� - �״��, ������ - *�� ���)
select RPAD(substr(empno,1,2),length(empno),'*')�����ȣ, RPAD(substr(ename,1,2),length(ename),'*') ����̸�
    from emp;

select rpad(substr(empno,1,2),length(empno),'*')�����ȣ,
       rpad(substr(ename,1,2),length(ename),'*')����̸�
from emp;

---p.141
select rpad('971225-',14,'*') as RPAD_JMNO,
       rpad('010-1234-',13,'*') as RPAD_PHONE
from dual;
-----------------
select * from student;
--1. jumin => 751023*******
select name,RPAD(substr(jumin,1,6),length(jumin),'*') as jumin
from student;
--2. tel => 055-381-2158
select name,replace(tel,')','-')as tel
from student;
--3. height 170�̻��� �л��� studno, name, grade, height, weight/ Ű�� ū �л������� ���, ���� Ű�� ���ٸ� studno���� ������ ���
select studno, name, grade, height, weight 
from student where height >= 170 order by height desc, studno asc;
--4. ���� professor ���̺��� ���ʽ��� ���� ���ϴ� ��� ��� / ������ȣ(profno), �̸�(name), ����(pay), ���ʽ�(bonus) ���
select profno ������ȣ, name �̸�, pay ����, bonus ���ʽ� from professor where bonus is null;
--5. ���� professor ���̺��� email�߿��� ���̵� ��� (@�ձ����� ���)
select name, substr(email,1,instr(email,'@')-1) ���̵�
from professor;

select * from professor;



--2025.01.24
-----------------------------------------
-- concat�Լ� ename:job ��)SMITH:CLERK
select concat(ename, ':'),
       concat(concat(ename, ':'),job),
       concat(ename,concat(':',job))
from emp;


--p.142 ���ڿ� ���� ||
select ename || ':' || job as �̸�_����
from emp;

--��������
select '     orcle    ', length('     orcle    '),
    TRIM('     orcle    '),length(TRIM('     orcle    ')) trim����,
    LTRIM('     orcle    '),length(LTRIM('     orcle    ')) ltrim����,
    RTRIM('     orcle    '),length(RTRIM('     orcle    ')) rtrim����
from dual;

------ ����

--round(�ݿø�) ,���� (�������� ���� �ڸ�)
select 123.567, round(123.567,1), round(123.567,2),
    round(123.567,-1), round(123.567,-2), round(123.567)
from dual;

--trunc(����)
select 15.793, trunc(15.793,1), trunc(15.793,2),
    trunc(15.793,-1), trunc(15.793)
from dual;

--ceil(���� ����� ū ����), floor(���� ����� ���� ���� ��ȯ)
select 3.14, ceil(3.14), floor(3.14), trunc(3.14),
            ceil(-3.14), floor(-3.14), trunc(-3.14)
from dual;

-- power(A��B��, A��B����)
select power(2,3) from dual;

-- mod(A�� B�� ���� ������)
select mod(15,6) from dual;

-- ��¥���� �Լ�
select sysdate ����, sysdate+1 ����, sysdate-1 ����, sysdate+3
from dual;
--3���� ��
select sysdate, add_months(sysdate,3), add_months('22/05/01',3)
from dual;

--emp���̺��� �����ȣ(empno), �̸�(ename), �Ի���(hiredate)
--�Ի� 10�� ��(�Ի�10����)��¥ ���

select empno, ename, hiredate,add_months(hiredate,120) �Ի�10����
from emp;

select months_between(sysdate, '24/01/24')
from dual;

--emp���̺� �̸�(ename), �Ի���(hiredate), �ٹ� ���� �� (���� - �Ի���)
--�Ҽ� ù°�ڸ����� ǥ��(trunc ���)
select ename, hiredate,months_between(sysdate,hiredate)�ٹ�������,
    trunc(months_between(sysdate,hiredate),1)�ٹ�������1,
    trunc(months_between(hiredate,sysdate),1)�ٹ�������1
from emp;

--�ٹ����� ���� ����ϴµ� '����'���� ���, �Ҽ��� ���ϴ� ���� => ��)529����
--�̸�, �ٹ����� �� ���
--concat(A,B)�Լ� ���

select ename, concat(trunc(months_between(sysdate,hiredate)),'����')�ٹ�������
from emp;

--|| ��� (���ڿ� ����)
select ename, trunc(months_between(sysdate, hiredate))||'����' �ٹ�����
from emp;
    
--
select sysdate,next_day(sysdate,'������')������,
       next_day(sysdate,'�����')�����,
       last_day(sysdate)��������,
       last_day('24/07/01')
from dual;

--�����ȣ(empno)�� ¦���� ����� �����ȣ(empno), �̸�(ename), ����(job) ���
select empno, ename, job
from emp
where mod(empno,2)=0
order by empno;

--�޿�(sal)�� 1,500���� 3,000������ ����� �� �޿��� 15%(0.15)�� ȸ��� ����
-- �̸�(ename), �޿�(sal), ȸ��(�ݿø�) ���

select ename, sal, round(sal * 0.15,0)ȸ��
from emp
where sal between 1500 and 3000;

---p.157 �� ��ȯ �Լ�
describe emp; --����Ȯ��

--empno(����) '500'(����)=> ���� 7369+500 = 7869 (500 -> ���ڷ� �˾Ƽ� ��ȯ)
select empno, ename, empno+'500'
from emp;

--���� ����--
-- empno(����) 'ABCD'(����)=> ���� 7369+ABCD =>�����߻�
--select empno, ename, empno+'ABCD' 
--from emp;
--select empno, ename, 'ABCD'+empno
--from emp;

----------
select sysdate from dual;
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')���糯¥�ð�
from dual;

select to_char(sysdate,'mm')�� from dual;
select to_char(sysdate,'dd')�� from dual;
select to_char(sysdate,'hh')�� from dual;
select to_char(sysdate,'mi')�� from dual;
select to_char(sysdate,'ss')�� from dual;
select to_char(sysdate,'mon')�� from dual;
select to_char(sysdate,'month')�� from dual;
select to_char(sysdate,'day')���� from dual;
select to_char(sysdate,'DAY')���� from dual;

--�Ի����� 1,2,3���� ����� ��ȣ(empno),�̸�(ename),�Ի���(hiredate)���
select empno,ename,to_char(hiredate,'mm')�� 
from emp
where to_char(hiredate,'mm')between '01' and '03';

select sal, to_char(sal,'$999,999')sal_$,
            to_char(sal,'L999,999')sal_L, -- �� ���� ǥ�� L 
            to_char(sal,'999,999')sal_9, --���ڸ� ���� ǥ���� �� 9����
            to_char(sal,'000,999')sal_0  
from emp;

select 1300-1500 from dual;

select '1300'-'1500' from dual;

select to_number('1300') - to_number('1500')
from dual;

select to_number('1,300','999,999')
from dual;

--�����߻�
--select to_number('1,300') - to_number('1,500') from dual;

select to_number('1,300','999,999') - to_number('1,500','999,999')
from dual;

---p.164
-- '20240727' ���� => ��¥��
select to_date('20240727') as str_date
from dual;

select to_date('20240727','yyyy-mm-dd') as str_date
from dual;

--81/12/03 ���� �Ի��� ��� ���
--hiredate������ date�����̶� ���ں�ȯ ���ص� ������ �Ǳ� ��.
select * from emp where hiredate > '81/12/03';

select * 
from emp
where hiredate > to_date('81/12/03','rr/mm/dd');

----------
--null
--���(empno), �̸�(ename), �޿�(sal), Ŀ�̼�(comm), �޿�+Ŀ�̼�(sal+comm) ���
select empno, ename, sal, comm, sal+comm ����,
       nvl(comm, 0), sal+nvl(comm,0) ��������
from emp;

--���(empno), �̸�(ename), �޿�(sal), Ŀ�̼�(comm), �޿�+Ŀ�̼�(sal+comm) ���� ���
-- ������ õ������ �����Ͽ� ���

select empno, ename, sal,comm,
    sal*12+nvl(comm,0)����,
    to_char(sal+nvl(comm,0), '999,999')����,
    to_char(sal*12+nvl(comm,0), '999,999')||'��' as ���� 
from emp;

--comm�� ������ o, ���� ������ x �� ���
select empno, ename, comm, nvl2(comm,'O','X') comm����
from emp;

--nvl2 ����Ͽ� ���� ���(sal*12)
-- empno, ename, sal. comm, ���� *(sal*12+comm)
select empno, ename, sal, comm, nvl2(comm,(sal*12+comm),(sal*12))����
from emp;

select empno, ename, sal, comm, nvl2(comm,sal*12+comm, sal*12)����
from emp;

select empno, ename, sal, comm, sal*12+nvl2(comm,comm,0)����
from emp;

--nvl���
select empno, ename, sal, comm,sal*12+nvl(comm,0)����,
        to_char(sal*12+nvl(comm,0), '999,999')����1
from emp;

select * from emp;
--empno, ename, mgr ��� / mgr�� null�̸� 'CEO'���

select empno, ename, mgr, nvl(to_char(mgr),'CEO')mgr,
    nvl2(to_char(mgr), to_char(mgr),'CEO'),
    nvl2(mgr,to_char(mgr),'CEO')
from emp;

-empno, ename, mgr ��� / mgr�� null�̸� 9999 ���
select empno, ename, mgr, nvl(mgr,9999)
from emp;

----------
--p.170
--job�� ���� �޿� �ٸ��� �λ�
-- MANAGER 1.5 / SALESMAN 1.2 / ANALYST 1.05 / 1.04
select empno, ename, job, sal,
    decode(job,'MANAGER',sal*1.5,
               'SALESMAN', sal*1.2,
               'ANALYST', sal*1.05,
               sal*1.04) �λ�޿�
from emp;

--case when
select empno, ename, job, sal,
    case job
        when 'MANAGER' then sal*1.5
        when 'SALESMNAN' then sal*1.2
        when 'ANALYST' then sal*1.05
        else sal*1.04
    end �λ�޿�
from emp;

--------
--comm�� null�̸� �ش���� ����, comm = 0�̸� ���� ����
--comm�� ������ ����(��: comm�� 50�̸� => ����:50)
--empno, ename, comm, comm_txt ��� 
--decode ���
select empno, ename, comm, 
    decode(comm, null, '�ش���� ����',
                 0,'���� ����',
                 '����:'||to_char(comm)
                 )comm_txt
from emp;
--case when ~ then ���
select empno, ename, comm,
    case 
        when comm is null then '�ش���� ����'
        when comm = 0 then '���� ����'
        when comm > 0 then '����:'||comm
    end as comm_txt
from emp;

----------------
--professor���̺�
select * from professor;
-- 1. professor���̺� ������(name)�� �а���ȣ(deptno), �а��� ���
--deptno = 101�̸� '��ǻ�Ͱ��а�'
--case
select name, deptno,
    case 
        when deptno = 101 then '��ǻ�Ͱ��а�'
    end as �а���
from professor;
--decode
select name, deptno, 
    decode(deptno, 101,'��ǻ�Ͱ��а�'
                    )�а���
from professor;

-- 2. professor���̺� ������(name)�� �а���ȣ(deptno), �а��� ���
--deptno = 101�̸� '��ǻ�Ͱ��а�', ������ �а��� ��Ÿ ���
--case
select name, deptno,
    case 
        when deptno = 101 then '��ǻ�Ͱ��а�'
        else '��Ÿ'
    end as �а���
from professor;
--decode
select name, deptno,
    decode(deptno, 101,'��ǻ�Ͱ��а�','��Ÿ')�а���
from professor;

-- 3. professor���̺� ������(name)�� �а���ȣ(deptno), �а��� ���
--deptno = 101�̸� '��ǻ�Ͱ��а�' / 102 - '��Ƽ�̵����а�' / 201 - '����Ʈ������а�' / �������� ��Ÿ ���
--case
select name, deptno,
    case 
        when deptno = 101 then '��ǻ�Ͱ��а�'
        when deptno = 102 then '��Ƽ�̵����а�'
        when deptno = 201 then '����Ʈ������а�'
        else '��Ÿ'
    end as �а���
from professor;
-- decode
select name, deptno,
    decode(deptno, 101,'��ǻ�Ͱ��а�',
                   102,'��Ƽ�̵����а�',
                   201,'����Ʈ������а�','��Ÿ')�а���
from professor;

--student���̺�
select * from student;

--�л��� 3�� ������ �з��ϱ� ���� �й�(studno)�� 3���� ������
--�������� 0�̸� A��, 1�̸� B��, 2�̸� C��
--�л���ȣ(studno),�̸�(name),�а���ȣ(deptno1),���̸� ���
--case
select studno, name, deptno1,
    case 
        when mod(studno, 3) = 0 then 'A'
        when mod(studno, 3) = 1 then 'B'
        when mod(studno, 3) = 2 then 'C'
    end as ���̸�
from student;

--decode
select studno, name, deptno1,
    decode(mod(studno,3),0,'A',1,'B',2,'C')���̸�
from student;

---
select * from student;
select jumin from student;
--1.�л����̺��� jumin 7��°�� 1�̸� ����, 2�̸� ����
-- �й�(studno), �̸�(name), �ֹ�(jumin), ����

select studno, name, jumin,
    case
        when substr(jumin,7,1) ='1' then '����'
        when substr(jumin,7,1) ='2' then '����'
    end ����
from student;


select studno, name, jumin,
    case substr(jumin,7,1) 
        when '1' then '����'
        when '2' then '����'
    end ����
from student;

select studno, name, jumin,
    decode substr(jumin,7,1),'1','����','2','����')����
from student;

--2. tel�� ������ȣ���� 02����, 051�λ�, 052���, 053�뱸 / �������� ��Ÿ�� ���
--�̸�, ��ȭ��ȣ, ���� ���

select * from student;
--decode 
--(1)
select name,tel,
    decode(substr(tel,1,instr(tel,')')-1),'02','����',
                                          '051','�λ�',
                                          '052','���',
                                          '053','�뱸',
                                          '��Ÿ') ����
from student;
--(2)
select name, tel, 
    decode(substr(tel,1,3),
    '02)','����',
    '051','�λ�',
    '052','���',
    '053','�뱸',
    '��Ÿ')����
from student;
--instr : ���ڿ� ���� ����
select name,tel,substr(tel,1,3),instr(tel,')'),
 case substr(tel,1,instr(tel,')')-1)
    when '02' then '����'
    when '051' then '�λ�'
    when '052' then '���'
    when '053' then '�뱸'
    else '��Ÿ'
end ����
from student;
--case decode
select name, tel, 
    case decode( substr(tel,2,1) , '2', substr(tel,1,2), substr(tel,1,3)) 
        when '02' then '����'
        when '051' then '�λ�'
        when '052' then '���'
        when '053' then '�뱸'
        else '��Ÿ'
    end ����
from student;

--�ֹι�ȣ ������
select name, jumin, rpad(substr(jumin,1,7),length(jumin),'*')�ֹι�ȣ,
substr(jumin,1,7)||'-'||substr(jumin,7)�ֹι�ȣ1
from student;















