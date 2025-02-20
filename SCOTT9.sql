--p.468 커서에 사용할 파라미터 입력받기
--부서번호를 입력받아 그 부서의 번호, 부서명, 지역을 출력
DECLARE
    v_deptno dept.deptno%type;
    cursor c1(p_deptno dept.deptno%type) is
    select deptno, dname, loc
    from dept
    where deptno = p_deptno;
BEGIN
    v_deptno := &INPUT_DEPTNO; --번호를 받아옴
    for item in c1(v_deptno) loop
        dbms_output.put_line('deptno : '||item.deptno);
        dbms_output.put_line('dname : '||item.dname);
        dbms_output.put_line('loc : '||item.loc);
    end loop;
end;
/
----
--input_deptno에 부서번호를 입력받고 v_deptno에 대입
--input_deptno 이거나 부서명이 sales사원 정보 출력 부서명은 'SALES'
DECLARE
    v_deptno dept.deptno%type;
    cursor c1(p_deptno dept.deptno%type, p_dname dept.dname%type) is 
    select deptno, dname, loc
    from dept
    where deptno = p_deptno or dname = p_dname;
BEGIN
    v_deptno := &input_deptno;
    for item in c1(v_deptno, 'SALES') loop
        dbms_output.put_line('deptno : '||item.deptno);
        dbms_output.put_line('dname : '||item.dname);
        dbms_output.put_line('loc : '||item.loc);
    end loop;
end;
/

----
DECLARE
    v_deptno dept.deptno%type;
    v_dname dept.dname%type;
    cursor c1(p_deptno dept.deptno%type, p_dname dept.dname%type) is 
    select deptno, dname, loc
    from dept
    where deptno = p_deptno or dname = p_dname;
BEGIN
    v_deptno := &input_deptno;
    v_dname := &input_dname; --입력 시 문자열이므로 ' ' 해야함
    for item in c1(v_deptno, v_dname) loop
        dbms_output.put_line('deptno : '||item.deptno);
        dbms_output.put_line('dname : '||item.dname);
        dbms_output.put_line('loc : '||item.loc);
    end loop;
end;
/


