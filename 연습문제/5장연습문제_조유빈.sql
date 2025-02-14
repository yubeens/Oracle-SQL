-- p125~126 ��������
-- 1. Emp ���̺��� ����̸�(ename)�� s�� ������ ����� ���� ���
select * 
from emp 
where ename like '%S';

-- 2. Emp ���̺��� 30�� �μ� �� ��å(job)�� SALESMAN�� ����� 
-- ��� ��ȣ(empno), �̸�(ename), ��å(job), �޿�(sal), �μ���ȣ(deptno)�� ���
select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and job = 'SALESMAN';

-- 3. 20��,30�� �μ��� �ٹ��ϸ鼭 �޿��� 2,000�� �ʰ��ϴ� �����
-- ��� ��ȣ(empno), �̸�(ename), ��å(job), �޿�(sal), �μ���ȣ(deptno)�� ���
-- 1) ���տ����� ���
select empno, ename, job, sal, deptno 
from emp 
where deptno = 20 and sal > 2000

UNION

select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and sal > 2000;

select empno, ename, job, sal, deptno 
from emp 
where deptno in(20,30)

INTERSECT

select empno, ename, job, sal, deptno 
from emp 
where sal > 2000;

-- 2) ���տ����� �̻��
select empno, ename, job, sal, deptno 
from emp 
where sal >= 2000 
and deptno in (20,30);

select empno, ename, job, sal, deptno 
from emp 
where (deptno = 20 or deptno = 30) 
and sal > 2000;

-- 4. �޿��� 2,000�̻� 3,000���� ���� �� �� not between a and b ������� �ʱ�
select * 
from emp
where sal < 2000 or sal >3000;

-- 5. ����̸��� E�� ���ԵǾ� �ִ� 30�� �μ��� ��� �� �޿��� 1,000~2,000 ���̰� �ƴ� �����
-- �̸�(ename), �����ȣ(empno), �޿�(sal), �μ���ȣ(deptno)�� ���
select ename, empno, sal, deptno 
from emp 
where ename like '%E%' 
    and deptno = 30 
    and sal not between 1000 and 2000;

-- 6. �߰�����(comm)�� �������� �ʰ� �����(mgr)�� �ְ� MANAGER CLERK (job)�߿��� ����̸��� �ι� ° ���ڰ� L�� �ƴ� ������ ���
select * 
from emp 
where comm is null 
    and mgr is not null 
    and job in ('MANAGER','CLERK')
    and ename not like '_L%';
