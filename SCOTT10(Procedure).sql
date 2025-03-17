set SERVEROUTPUT on;
--프로시져
--cats emp_mon 테이블 생성(emp 이용)
create table emp_mon
as
select *
from emp;

--(empno, ename, job, mgr, sal)
--4000, '홍길동', '사원', 5000, 800 추가
--4001, '홍길동1','사원', 5000, 900 추가

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

EXECUTE emp_proc(4000, '홍길동', '사원', 5000, 800);
EXECUTE emp_proc(4001, '홍길동1','사원', 5000, 900);
select * from emp_mon;
delete from emp_mon where empno = 1;

--부서명, 인원수, 급여합계를 구하는 프로시저(sumProcess)작성
create or replace PROCEDURE sumProcess
is
    CURSOR c1 is
    select d.dname 부서명, count(*) 인원수, sum(e.sal) 급여합계
    from emp e, dept d
    where d.deptno = d.deptno
    group by d.dname;
BEGIN
    for i in c1 loop
        dbms_output.put_line('부서명: '||i.부서명);
        dbms_output.put_line('인원수: '||i.인원수);
        dbms_output.put_line('급여합계: '||i.급여합계);
        dbms_output.put_line('');
    end loop;
end;
/
EXECUTE sumProcess;


declare