--p1/sql(p.420)
SET SERVEROUTPUT ON; --��� ��� Ȯ��

BEGIN
    dbms_output.put_line('HELLO');
end;
/ -- declare�� �ߺ� ������� �ʰ� ������ �ǹ�

--p.421
DECLARE --(����)
    v_ename varchar2(20);
    v_empno number(4);
    v_tax CONSTANT number(3) :=3; --constant �����Ұ� (final)
    v_deptno number(2) not null default 10;
    v_deptno1 dept.deptno%type := 5; --������ (deptno�� ���� ������ �־��ִ� ������)
BEGIN --(����)
    v_ename := 'SMITH';
    v_empno := 7788;
    dbms_output.put_line('v_ename :'||v_ename);
    dbms_output.put_line('v_ename :'||v_empno);
    v_empno := 9900;
    dbms_output.put_line('v_ename :'||v_empno);
    dbms_output.put_line('v_tax :'||v_tax);
    --v_tax := 5; �����߻�
    --dbms_output.put_line('v_tax :'||v_tax);
    dbms_output.put_line('v_deptno :'||v_deptno);
end;
/
--------------
--p.429
select * from dept;
select deptno, dname, loc from dept where deptno = 40;
---
DECLARE
    v_deptno dept.deptno%type;
    v_dname varchar2(20);
    v_loc varchar2(20);
BEGIN
    select deptno, dname, loc into v_deptno, v_dname, v_loc
        from dept
            where deptno = 40;
    dbms_output.put_line('deptno :'||v_deptno);
    dbms_output.put_line('dname :'||v_dname);
    dbms_output.put_line('loc :'||v_loc);
END;
/
select * from dept;

DECLARE
    v_deptno_row dept%rowtype; 
BEGIN
    select deptno, dname, loc into v_deptno_row
        from dept
            where deptno = 40;
    dbms_output.put_line('deptno :'||v_deptno_row.deptno);
    dbms_output.put_line('dname :'||v_deptno_row.dname);
    dbms_output.put_line('loc :'||v_deptno_row.loc);
END;
/

DECLARE
    v_deptno_row dept%rowtype;
    v_number number := 30;
BEGIN
    select deptno, dname, loc into v_deptno_row
    from dept
    where deptno = 40;
    if mod(v_number,2) = 0 then
        dbms_output.put_line(v_number || '¦��');
    else
        dbms_output.put_line(v_number || 'Ȧ��');
    end if;
        dbms_output.put_line('deptno :'||v_deptno_row.deptno);
        dbms_output.put_line('dname :'||v_deptno_row.dname);
        dbms_output.put_line('loc :'||v_deptno_row.loc);
   
END;
/
-------------------
--p.434 ���� ���
--(A,B,C,D,F ����)

DECLARE
    v_score number := 88;   
BEGIN
    if v_score >= 90 then
        dbms_output.put_line('A����');
        elsif v_score >= 80 then
            dbms_output.put_line('B����');
        elsif v_score >= 70 then
            dbms_output.put_line('C����');
        elsif v_score >= 60 then
            dbms_output.put_line('D����');
    else
        dbms_output.put_line('F����');
    end if;
END;
/

DECLARE
    v_score number := 88;   
BEGIN
    case
        when v_score >= 90 then dbms_output.put_line('A����!!');
        when v_score >= 80 then dbms_output.put_line('B����!!');
        when v_score >= 70 then dbms_output.put_line('C����!!');
        when v_score >= 60 then dbms_output.put_line('D����!!');
        else dbms_output.put_line('F����');
    end case;
END;
/

DECLARE
    v_score number := 88;   
BEGIN
    case trunc(v_score/10)
        when 10 then dbms_output.put_line('A����!!');
        when 9 then dbms_output.put_line('A����!!');
        when 8 then dbms_output.put_line('B����!!');
        when 7 then dbms_output.put_line('C����!!');
        when 6 then dbms_output.put_line('D����!!');
        else dbms_output.put_line('F����!!');
    end case;
END;
/