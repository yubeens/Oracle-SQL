--p439 반복문
set SERVEROUTPUT on; -- 출력 결과 확인
DECLARE
    v_num number := 0;
BEGIN
    LOOP
        dbms_output.put_line('v_num :' ||v_num );
        v_num := v_num+1;
        if v_num > 5 then
            exit;
        end if;
    end loop;    
end;
/
-----------------
DECLARE
    v_number number :=0;
BEGIN
    while  v_number < 5 loop
        dbms_output.put_line('v_number :' ||v_number );
        v_number := v_number+1;
    end loop;
    ----
    for  i in 1..4 loop
        dbms_output.put_line('현재 i :' ||i );
    end loop;
    ----
    for i in REVERSE 1..4 loop
        dbms_output.put_line('현재 REVERSE i :' ||i );
    end loop;
end;
/
----------------
-- for 문 이용해서 0 에서 4까지 동작 : 짝수만 출력
BEGIN
    for i in 0..4 loop
        if mod(i,2) = 0 then
            dbms_output.put_line('현재 짝수 i :'||i);
        end if;
    end loop;
end;
/
---
BEGIN
    for k in 0..4 loop
        CONTINUE when mod(k,2) = 1; -- continue는 조건이 맞으면 다시 for
        dbms_output.put_line('현재 k :'||k);
    end loop;
    dbms_output.put_line('--------');
    for m in 0..4 loop
        exit when mod(m,2) = 1; -- exit 조건이 맞으면 다시 for 문 빠져나옴
        dbms_output.put_line('현재 m :'||m);
    end loop;
end;
/
----p444  16장 연습문제
----1.숫자 1에서 10 사이 홀수 출력
BEGIN
    for i in 1..10 loop
        if mod(i,2)=1 then
         dbms_output.put_line('홀수 i 값 :' || i);
        end if;
    end loop;
end;
/
--- while
DECLARE
    m_number number := 1;
begin
    while  m_number < 10 loop
        dbms_output.put_line('홀수 :' || m_number);
        m_number := m_number+2;
    end loop;
end;
/
--2. dept테이블의 deptno와 자료형이 같은 변수   v_deptno 선언
-- v_deptno 값에 따른 부서명 출력(10,20,30,40,  이 아니면 N/A)
select * from dept;
DECLARE
    v_deptno dept.deptno%type;   -- v_deptno number;
BEGIN
    case v_deptno
        when 10 then dbms_output.put_line('DNAME: ACCOUNTING');
        when 20 then dbms_output.put_line('DNAME: RESEARCH');
        when 30 then dbms_output.put_line('DNAME: SALES');
        when 40 then dbms_output.put_line('DNAME: OPERATIONS');
        else dbms_output.put_line('DNAME: N/A');
    end case;    
end;
/
-- 부서번호를 입력받아 부서명 출력

ACCEPT  p_deptno PROMPT '부서번호 입력:';
DECLARE
    v_deptno dept.deptno%type := &p_deptno;   -- v_deptno number;
BEGIN
    case v_deptno
        when 10 then dbms_output.put_line('DNAME: ACCOUNTING');
        when 20 then dbms_output.put_line('DNAME: RESEARCH');
        when 30 then dbms_output.put_line('DNAME: SALES');
        when 40 then dbms_output.put_line('DNAME: OPERATIONS');
        else dbms_output.put_line('DNAME: N/A');
    end case;    
end;
/


ACCEPT  p_deptno PROMPT '부서번호 입력:';
DECLARE
    v_deptno dept.deptno%type := &p_deptno;   -- v_deptno number;
BEGIN
     if v_deptno= 10 then dbms_output.put_line('DNAME: ACCOUNTING');
     elsif v_deptno =20 then dbms_output.put_line('DNAME: RESEARCH');
     elsif v_deptno =30 then dbms_output.put_line('DNAME: SALES');
     elsif v_deptno =40 then dbms_output.put_line('DNAME: OPERATIONS');
     else dbms_output.put_line('DNAME: N/A');
    end if;    
end;
/
----
select dname from dept where deptno=40;

ACCEPT p_deptno1 PROMPT 'select  부서번호 입력 : ';
DECLARE
   v_dname dept.dname%type;
   v_deptno dept.deptno%type := &p_deptno1;
BEGIN
    select dname into v_dname
    from dept
    where deptno=v_deptno;
    dbms_output.put_line(v_deptno||' select DNAME: '||v_dname);
exception
    when no_data_found then
    dbms_output.put_line('부서명 : N/A'); 
end;
/
------------
--2단출력
--2*1=2
--2*2=4

--2*9=18
--for문 사용
BEGIN
    for i in 1..9 loop
        dbms_output.put_line('2*'||i||'='||2*i);
    end loop;
end;
/

DECLARE
  total number(3);
BEGIN
    for i in 1..9 loop
        total := 3*i;
        dbms_output.put_line('3*'||i||'='||total);
    end loop;
end;
/
-- 단을 입력받아 입력받은 단의 구구단 출력
ACCEPT p_dan PROMPT '단 입력 :';
DECLARE
    dan number := &p_dan;
    total number;
BEGIN
    for i in 1..9 loop
        total := dan*i;
        dbms_output.put_line(dan ||'*'|| i ||'='||total);
    end loop;
end;
/
---dept 테이블 이용
-- 부서번호를 입력받아 부서명과 지역을 출력하기
select dname, loc from dept where deptno = 10;

ACCEPT p_deptno PROMPT '부서번호 입력 :';
DECLARE
   v_deptno dept.deptno%type := &p_deptno;
   v_dname dept.dname%type;
   v_loc   dept.loc%type;
BEGIN
    select dname, loc into v_dname, v_loc
    from dept
    where deptno =v_deptno;
    dbms_output.put_line(' 부서명 : '||v_dname);
    dbms_output.put_line(' 지역 : '||v_loc);
EXCEPTION
    when no_data_found then
     dbms_output.put_line('없는 부서번호입니다. ');
end;
/
---
create table A(
    a1 number,
    a2 number,
    a3 number
);
select * from A;
accept p_dan PROMPT '단입력:';
DECLARE
    dan number(2) := &p_dan;
    total number(3);
BEGIN
    for i in 1..9 loop
        total := dan*i;
        dbms_output.put_line(dan ||'*'|| i ||'='||total);
        insert into A values(dan, i, total);
    end loop;
end;
/
select * from A;
-----
create table dept_tmp(
    num number,
    dname varchar2(50),
    loc varchar2(50)
);
-- num 시퀀스 : dept_tmp_seq
create sequence dept_tmp_seq
increment by 1
start with 1
minvalue 1
NOCACHE
NOCYCLE;
--부서번호를 입력받아 그 부서의 부서명과 지역을 출력하고
--dept_tmp 테이블에 그 내용을 추가하기
ACCEPT p_deptno2 PROMPT '부서번호입력~~ : ';
DECLARE
    v_deptno2 dept.deptno%type := &p_deptno2;
    v_dname2 dept.dname%type;
    v_loc2 dept.loc%type;
BEGIN
    select dname, loc into v_dname2, v_loc2
    from dept
    where deptno = v_deptno2;
    insert into  dept_tmp values(dept_tmp_seq.nextval,v_dname2,v_loc2);
    commit;
    dbms_output.put_line('부서명 : '||v_dname2);
    dbms_output.put_line('지역 : '||v_loc2);
EXCEPTION
    when no_data_found then
    dbms_output.put_line('검색 결과가 없습니다');  
end;
/
select * from dept_tmp;
---------------
--p446 record
--ctas 방법으로 dept 테이블을 이용해   dept_record 테이블 생성
create table dept_record
as select * from dept;

select * from dept_record;
--dept_record 테이블에  99 ,database, seoul  추가

DECLARE
    r_deptno number(3);
    r_dname varchar2(20);
    r_loc varchar2(20);
BEGIN 
    r_deptno :=99;
    r_dname :='DATABASE';
    r_loc :='SEOUL';
    insert into dept_record values(r_deptno,r_dname,r_loc);
    commit;
end;
/
select * from dept_record;
-------
DECLARE
    type REC_DEPT is record(
        deptno number(2) not null :=99,
        dname dept.dname%type,
        loc   dept.loc%type
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 29;
    dept_rec.dname :='ORACLE';
    dept_rec.loc :='BUSAN';
    insert into dept_record values dept_rec;
    commit;
end;
/
-----
DECLARE
    v_dept_rec dept%rowType;
begin
    v_dept_rec.deptno := 11;
    v_dept_rec.dname := 'JAVA';
    v_dept_rec.loc :='BUSAN1';
    insert into dept_record values v_dept_rec;
    commit;
end;
/
select * from dept_record;
-------------------
--p450
--사원번호, 사원이름, 부서번호, 부서명 ,부서지역, ==>사원번호 :7369
select * from emp;
select * from dept;
select empno, ename, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno
and empno = 7369;

DECLARE
   v_empno emp.empno%type;
   v_ename emp.ename%type;
   v_deptno emp.deptno%type;
   v_dname dept.dname%type;
   v_loc dept.loc%type;
BEGIN
    select empno, ename, e.deptno, dname, loc 
    into  v_empno, v_ename, v_deptno, v_dname, v_loc
    from emp e, dept d
    where e.deptno = d.deptno
    and empno = 7369;
     dbms_output.put_line('사원번호 : ' || v_empno);
     dbms_output.put_line('사원이름 : ' || v_ename);
     dbms_output.put_line('부서번호 : ' || v_deptno);
     dbms_output.put_line('부서명 : ' || v_dname);
     dbms_output.put_line('부서지역 : ' || v_loc);
end;
/
---
DECLARE
    type REC_TABLE is record(
        empno emp.empno%type,
        ename emp.ename%type,
        deptno dept.deptno%type,
        dname dept.dname%type,
        loc dept.loc%type
    );
    emp_record  REC_TABLE;
BEGIN
    select empno, ename, e.deptno, dname, loc 
    into  emp_record
    from emp e, dept d
    where e.deptno = d.deptno
    and empno = 7369;
     dbms_output.put_line('사원번호~~ : ' || emp_record.empno);
     dbms_output.put_line('사원이름 : ' || emp_record.ename);
     dbms_output.put_line('부서번호 : ' || emp_record.deptno);
     dbms_output.put_line('부서명 : ' ||  emp_record.dname);
     dbms_output.put_line('부서지역 : ' || emp_record.loc);
end;
/
----------------
--p460 cursor
--select  문 데이터 조작어 같은   sql 문 실행했을때
-- 해당  sql 문 처리하는 정보를 저장하는 메모리 공간

-- cursor open fetch close   ==> for loop end
select * from emp where deptno =20;
DECLARE
  vemp  emp%rowType;  -- 생략가능
  cursor c1 is 
  select empno, ename, sal
  from emp
  where deptno = 20;
BEGIN
 dbms_output.put_line('번호    이름     급여' );
 for vemp  in  c1 loop
    dbms_output.put_line(vemp.empno || ' ' ||vemp.ename|| '  ' || vemp.sal);
 end loop;
end;
/
-----------------
---emp 테이블의 모든 사원 이름과 급여 출력하고 회원들의 급여 합도 출력
select ename, sal from emp;
select sum(sal) from emp;

DECLARE
    total number := 0;
    CURSOR emp_cursor is
    select ename, sal
    from emp;
BEGIN
    for emp_item in  emp_cursor loop
        dbms_output.put_line(emp_item.ename || ' ' ||emp_item.sal);
        total := total+emp_item.sal;
    end loop;
    dbms_output.put_line('급여합계 : '||to_char(total,'999,999'));
end;
/
----
DECLARE
    total number := 0;
    CURSOR emp_cursor is
    select ename, sal
    from emp;
BEGIN
  for emp_item in emp_cursor loop
     dbms_output.put_line(emp_item.ename || ' ' ||emp_item.sal);
  end loop;
  select sum(sal) into total  from emp;
   dbms_output.put_line('sal total :' ||to_char(total,'999,999'));
end;
/
------
select ename, sal from emp order by sal desc;
-- 사원별 급여현황 (급여의 내림차순으로 출력)
-- 이름  별표 (100에 별표하나)<- 반올림(sal)
-- 예) JAMES(950)  :  JAMES  *********(950)
DECLARE
 cursor star_cursor is
 select ename, sal
 from emp
 order by sal desc;
 
 cnt number := 0 ;  -- 별 갯수
 star varchar2(100) := null;
BEGIN
    dbms_output.put_line('----사원별 급여현황----');
    for item in star_cursor loop
       cnt := round(item.sal/100);
       star := null;
       for i in 1..cnt loop
            star := star ||'*'; --100
       end loop;
      -- dbms_output.put_line(item.ename||' ' || star ||' ('||item.sal||')');
      dbms_output.put_line(LPAD(item.ename,10)||' ' || star ||' ('||item.sal||')');
    end loop;
end;
/

--- 급여가 2000이상인 것만 출력
DECLARE
 cursor star_cursor is
 select ename, sal
 from emp
 where sal > 2000
 order by sal desc;
 
 cnt number := 0 ;  -- 별 갯수
 star varchar2(100) := null;
BEGIN
    dbms_output.put_line('----사원별 급여현황----');
    for item in star_cursor loop
       cnt := round(item.sal/100);
       star := null;
       for i in 1..cnt loop
            star := star ||'*'; --100
       end loop;
       dbms_output.put_line(LPAD(item.ename,10)||' ' || star ||' ('||item.sal||')');
    end loop;
end;
/
---
DECLARE
 cursor star_cursor is
 select ename, sal
 from emp
 order by sal desc;
 
 cnt number := 0 ;  -- 별 갯수
 star varchar2(100) := null;
BEGIN
    dbms_output.put_line('----사원별 급여현황----');
    for item in star_cursor loop
        if item.sal > 2000 then
           cnt := round(item.sal/100);
           star := null;
           for i in 1..cnt loop
                star := star ||'*'; --100
           end loop;
         dbms_output.put_line(LPAD(item.ename,10)||' ' || star ||' ('||item.sal||')');
        end if;
    end loop;
end;
/

--p.462 하나의 데이터를 저장 => 커서 사용
DECLARE
    v_dept_row dept%rowType;
    --명시적 커서 선언
    cursor c1 is
    select deptno, dname, loc
    from dept
    where deptno =10;
BEGIN
    --커서 열기(open)
    open c1;
    --커서로부터 읽어온 데이터 사용(fetch)
    fetch c1 into v_dept_row;
    dbms_output.put_line('deptno :' || v_dept_row.deptno);
    dbms_output.put_line('deptno :' || v_dept_row.dname);
    dbms_output.put_line('deptno :' || v_dept_row.loc);
    --커서닫기
    close c1;
end;
/
--cursor for loop
DECLARE
    cursor c1 is
    select deptno, dname, loc
    from dept
    where deptno=40;
BEGIN
    for i in c1 loop
        dbms_output.put_line('deptno :' || i.deptno);
        dbms_output.put_line('deptno :' || i.dname);
        dbms_output.put_line('deptno :' || i.loc);
    end loop;
end;
/

--cursor 사용하지 않고 
DECLARE
    v_row dept%rowType;
BEGIN
    select deptno, dname, loc into v_row
    from dept
    where deptno = 20;
    dbms_output.put_line('deptno :' || v_row.deptno);
    dbms_output.put_line('deptno :' || v_row.dname);
    dbms_output.put_line('deptno :' || v_row.loc);
end;
/















