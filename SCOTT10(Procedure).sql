set SERVEROUTPUT on;
--���ν���
--cats emp_mon ���̺� ����(emp �̿�)
create table emp_mon
as
select *
from emp;

--(empno, ename, job, mgr, sal)
--4000, 'ȫ�浿', '���', 5000, 800 �߰�
--4001, 'ȫ�浿1','���', 5000, 900 �߰�

create or replace PROCEDURE emp_proc(
    v_empno emp.empno%type, 
    v_ename emp.ename%type,
    v_job emp.job%type,
    v_mgr emp.mgr%type,
    v_sal emp.sal%type)
IS
begin
    insert into emp_mon(empno, ename, job, mgr, sal)
    values(v_empno,v_ename,v_job,v_mgr,v_sal);
    commit;
end;
/

EXECUTE emp_proc(4000, 'ȫ�浿', '���', 5000, 800);
EXECUTE emp_proc(4001, 'ȫ�浿1','���', 5000, 900);
select * from emp_mon;
delete from emp_mon where empno = 1;

--�μ���, �ο���, �޿��հ踦 ���ϴ� ���ν���(sumProcess)�ۼ�
create or replace PROCEDURE sumProcess
is
    CURSOR c1 is
    select d.dname �μ���, count(*) �ο���, sum(e.sal) �޿��հ�
    from emp e, dept d
    where d.deptno = d.deptno
    group by d.dname;
BEGIN
    for i in c1 loop
        dbms_output.put_line('�μ���: '||i.�μ���);
        dbms_output.put_line('�ο���: '||i.�ο���);
        dbms_output.put_line('�޿��հ�: '||i.�޿��հ�);
        dbms_output.put_line('');
    end loop;
end;
/
EXECUTE sumProcess;


declare