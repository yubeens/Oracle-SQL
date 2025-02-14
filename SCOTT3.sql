--1.ACCOUNTING(dname) �μ� �Ҽ� ����� �̸��� �Ի��� ���
select * from dept;
select * from emp;

select empno, hiredate, dname, e.deptno
from emp e, dept d
where e.deptno = d.deptno and dname = 'ACCOUNTING';

--SQL99 ǥ�ع���
select empno, hiredate
from emp e join dept d 
            on e.deptno = d.deptno
where dname = 'ACCOUNTING';

--2. 0���� ���� comm�� �޴� ����̸��� �μ��� ���
select * from emp;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno and comm > 0;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno
and comm is not null and comm <> 0;

--join ~ on
select ename, dname
from emp e join dept d
        on e.deptno = d. deptno
where comm > 0;

select ename, dname, comm
from emp e join dept d
on e.deptno = d.deptno
where comm is not null and comm <>0;

--3. ������ �Ŵ����� ���� �Դϴ�.
select e.ename ���, m.ename ���
from emp e, emp m
where e.mgr = m.empno
order by e.ename;

--��) SMITH�� �Ŵ����� FORD �Դϴ�.
select e.ename||' �� �Ŵ����� '|| m.ename ||'�Դϴ�.' ���_���
from emp e, emp m
where e.mgr = m.empno
order by e.ename;

--join~on
select e.ename||' �� �Ŵ����� '|| m.ename ||'�Դϴ�.' ���_�Ŵ���
from emp e join emp m
            on e.mgr = m.empno
order by e.ename;

-------------------
select * from emp;
select * from dept;

--1. ���忡�� �ٹ��ϴ� ����� �̸�(ename), �޿�(sal), ���
select d.loc,e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and d.loc = 'NEW YORK';
    
--join ~ on
select e.ename ����̸�, e.sal �޿�, d.loc �ٹ�����
from emp e join dept d
           on e.deptno = d.deptno
where d.loc = 'NEW YORK';

--2. �Ŵ���(mgr)�� KING�� ������� �̸��� ������ ���
select * from emp;
--KING�� empno
select empno from emp where ename = 'KING'; --7839

select ename, job
from emp
where mgr = 7839;

select ename, job
from emp
where mgr = (select empno
            from emp
            where ename = 'KING');

--self join
select e.ename, e.job
from emp e, emp m
where e.mgr = m.empno and m.ename = 'KING';

--3. SMITH ����(SMITH�� ���� �μ�)�� �̸� ���
select deptno from emp where ename = 'SMITH';

select ename
from emp
where deptno = 20;

select ename
from emp
where deptno = (select deptno 
                from emp 
                where ename = 'SMITH')
and ename <> 'SMITH';

--self join
select f.ename
from emp e, emp f
where e.deptno = f.deptno
and e.ename = 'SMITH' and f.ename <> 'SMITH';

--join ~ on
select f.ename
from emp e join emp f
            on e.deptno = f.deptno
where e.ename = 'SMITH' and f.ename <> 'SMITH';

--p.229
select * from emp; --12�� ���
--�����ȣ, ����̸�, ���(mgr) �������ȣ, ����̸� ���
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename --11�� ��� (KING�� ������ - null�� ��µ��� ����.)
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;

--�ܺ�����(outer join)
--��� ����� ���� �����ȣ, ����̸�, ���, �������ȣ, ����̸� ���
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename --11�� ��� (KING�� ������ - null�� ��µ��� ����.)
from emp e1, emp e2
where e1.mgr = e2.empno(+) --null���� ������ ���̺� +�� ��
order by e1.empno;

--join ~ on
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1 left outer join emp e2 --������ ������̺�
            on e1. mgr = e2.empno
order by e1.empno;

select e.empno, e.ename, e.mgr, m.empno, m.ename
from emp m right outer join emp e --������ ������̺�
            on e.mgr = m.empno
order by e.empno;

-------
--����̸�(ename), �μ���ȣ(deptno), �μ���(dname)
select * from emp;
select * from dept;

select ename ����̸�, e.deptno �μ���ȣ, dname �μ���
from emp e, dept d
where e.deptno = d.deptno;

--��� �μ��� ���� ��� => ����̸�(ename), �μ���ȣ(deptno), �μ���(dname)
select ename ����̸�, d.deptno �μ���ȣ, dname �μ���
from emp e, dept d
where e.deptno(+) = d.deptno; --null���� ������ ���̺� +�� ��

select ename ����̸�, d.deptno �μ���ȣ, dname �μ���
from emp e right outer join dept d
        on e.deptno = d.deptno
order by e.deptno;

select ename ����̸�, d.deptno �μ���ȣ, dname �μ���
from dept d left outer join emp e
        on e.deptno = d.deptno
order by d.deptno;

--p.232
--sal 2000���� ū �����ȣ, �̸�, �޿�, ���, �μ���ȣ, �μ���, ���� ���
select d.deptno, empno, ename, sal, mgr, dname, loc
from emp e, dept d
where e.deptno = d.deptno
and e.sal > 2000
order by deptno, e.empno;

--(sq-l99) ǥ��
select * from emp;
select * from dept;

--natural join
select deptno, e.empno, e.ename, e.sal, e.mgr, d.dname, d.loc
from emp e natural join dept d --�ش� ������ ���ٴ°��� natural join�� �˱⿡ ������ �� ����.
where e.sal>2000;

--join ~ using
select deptno, e.empno, e.ename, e.sal, e.mgr, d.dname, d.loc
from emp e join dept d using(deptno) --�̿��� Į���� ()�ȿ� �����ָ� ��.
where e.sal > 2000;

--p240 
--join ~ on : ���� ���� ����ϴ� ���
select d.deptno, empno, ename, sal, mgr, dname, loc
from emp e join dept d
            on e.deptno = d.deptno
where e.sal > 2000;

--p.238
--emp, dept ���̺�
--�޿�(sal)�� 2000�̻��̸� ���ӻ��(mgr)�� �ݵ�� �־�� ��
--empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc ���
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and sal >= 2000 and mgr is not null;

--join ~ using
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, deptno, d.dname, d.loc
from emp e join dept d using(deptno) --deptno�� �ĺ��ڸ� ���������.
where sal >= 2000 and mgr is not null;

--natural join
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, deptno, d.dname, d.loc
from emp e natural join dept d
where e.sal >= 2000 and mgr is not null;

--join ~ on
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, d.dname, d.loc
from emp e join dept d
on e.deptno = d.deptno
where e.sal >= 2000 and mgr is not null;

--------------------------
--p.239~240 (8�� ��������)
--1) �޿�(sal)�� 2000�ʰ��� ������� �μ� ����, ��� ������ ���
--deptno, dname, empno, ename, sal 
--(sql-99)ǥ��
--join ~ using
select deptno, d.dname, e.empno, e.ename, e.sal
from emp e 
join dept d using(deptno)
where e.sal >=2000
order by deptno;

--join ~ on
select d.deptno, d.dname, e.empno, e.ename, e.sal
from emp e join dept d
on e.deptno = d.deptno
where e.sal >= 2000
order by d.deptno asc;

--(sql-99)���� ���
select d.deptno, d.dname, e.empno, e.ename, e.sal
from dept d ,emp e
where d.deptno = e.deptno
and e.sal >= 2000
order by e.deptno asc;


--2)�� �μ���(�μ���ȣ, �μ���) ��� �޿�, �ִ�޿�, �ּұ޿�, ������� ���
-- deptno, dname, avg_sal, max_sal, min_sal, cnt
--(sql-99)ǥ��
--join ~ on
select e.deptno, d.dname, 
round((avg(e.sal))) as avg_sal, max(e.sal) as max_sal , min(e.sal) as min_sal, count(e.empno) as cnt
from dept d join emp e on d.deptno = e.deptno
group by e.deptno, d.dname
order by e.deptno;

--natural join
select deptno, d.dname, 
round((avg(e.sal))) as avg_sal, max(e.sal) as max_sal , min(e.sal) as min_sal, count(e.empno) as cnt
from emp e natural join dept d
group by deptno, d.dname
order by deptno;

--(sql-99)���� ���
select e.deptno, d.dname,
round((avg(e.sal))) as avg_sal, max(e.sal) as max_sal , min(e.sal) as min_sal, count(e.empno) as cnt
from dept d, emp e
where d.deptno = e.deptno
group by e.deptno, d.dname
order by e.deptno;


--3)��� �μ� ������ ��� ������ ���
--deptno, dname, empno, ename, job, sal >> �μ���ȣ, ��� �̸������� ����
--(sql-99)ǥ��
--outer join
--left outer join
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal 
from dept d left outer join emp e 
on d.deptno = e.deptno
order by deptno;

--right outer join
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal 
from emp e right outer join dept d
on d.deptno = e.deptno
order by deptno;

--(sql-99)���� ���
--(+)
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal 
from dept d, emp e
where d.deptno = e.deptno(+)
order by e.deptno;


--4)��� �μ� ����, ��� ����, �޿� ��� ����, ���� ����� ���� ���
--deptno, dname, empno, ename, mgr, sal, deptno_1, losal, hisal, grade, mgr}_empno, mgr_ename
--�μ���ȣ, ��� ��ȣ������ ����
--(sql-99)ǥ��
--join ~ on
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno as deptno_1, g.losal, g.hisal, g.grade,
m.empno as mgr_empno, m.ename as mgr_ename
from emp e right outer join dept d on (e.deptno = d.deptno) 
    left outer join salgrade g on (e.sal between g.losal and g.hisal) 
    left outer join emp m on (e.mgr = m.empno)
order by d.deptno, e.empno; 

--(sql-99)�������
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno as deptno_1, 
g.losal, g.hisal, g.grade, m.empno as mgr_empno, m.ename as mgr_ename
from dept d, emp e, salgrade g, emp m
where e.deptno(+) = d.deptno
    and e.sal between g.losal(+) and g.hisal(+)
    and e.mgr = m.empno(+)
order by d.deptno, e.empno;
-----------------------------

--p.242 ��������(SQL ���ο� ����ϴ� select��)
--WARD��� �ϴ� ������� ������ ���� �޴� ��� �̸��� ���
select sal from emp where ename = 'WARD';
select ename from emp where sal > 1250;

select ename
from emp
where sal > (select sal from emp where ename = 'WARD');

--'ALLEN'�� ����(job)�� ���� ����� �̸�(ename), �μ���(dname), �޿�(sal), ����(job) ���
select job from emp where ename = 'ALLEN';

select e.ename, d.dname, e.sal, e.job
from emp e, dept d
where e.deptno = d.deptno
and job = (select job from emp where ename = 'ALLEN')
and ename <> 'ALLEN';

-- ��ü ����� ��� �ӱݺ��� ���� �����
-- �����ȣ(empno), �̸�(ename), �μ���(dname), �Ի���(hiredate}) ���
select empno, ename, dname, hiredate, sal
from emp e, dept d
where e.deptno = d.deptno
and sal > (select avg(sal) from emp); 

--'ALLEN'���� ���� �Ի��� ����� ����
select hiredate from emp where ename = 'ALLEN';
select ename,hiredate from emp;

select * 
from emp
where hiredate < (select hiredate 
                    from emp 
                    where ename = 'ALLEN');
                    
--p.248
--��ü ����� ��ձ޿����� �۰ų� ���� �޿��� �޴� 20�� �μ��� ��� �� �μ������� ���
-- empno, ename, job, sal, deptno, dname, loc
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 20
and e.sal <= (select avg(sal) from emp);

--natural join
select e.empno, e.ename, e.job, e.sal, deptno, d.dname, d.loc
from emp e natural join dept d
where deptno = 20 
and e.sal <= (select avg(sal) from emp);

--join ~ using
select e.empno, e.ename, e.job, e.sal, deptno, d.dname, d.loc
from emp e join dept d using(deptno)
where deptno = 20
and e.sal <= (select avg(sal) from emp);

--join ~ on
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
from emp e join dept d
on d.deptno = e.deptno
where d.deptno = 20
and e.sal <= (select avg(sal) from emp);


-- �� �μ��� �ְ�޿��� ������ �޿��� �޴� ��� ���� ���
-- �� �μ� �� �ְ�޿�
select deptno, max(sal)
from emp
group by deptno;

--������ ��������
select * 
from emp 
where (deptno,sal) in (select deptno, max(sal)
                        from emp
                        group by deptno);
                        
select * 
from emp
where sal in (select max(sal)
                     from emp
                     group by deptno);
                     
select * from emp where sal in (2850,5000,3000);
















