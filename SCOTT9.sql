--p.468 Ŀ���� ����� �Ķ���� �Է¹ޱ�
--�μ���ȣ�� �Է¹޾� �� �μ��� ��ȣ, �μ���, ������ ���
DECLARE
    v_deptno dept.deptno%type;
    cursor c1(p_deptno dept.deptno%type) is
    select deptno, dname, loc
    from dept
    where deptno = p_deptno;
BEGIN
    v_deptno := &INPUT_DEPTNO; --��ȣ�� �޾ƿ�
    for item in c1(v_deptno) loop
        dbms_output.put_line('deptno : '||item.deptno);
        dbms_output.put_line('dname : '||item.dname);
        dbms_output.put_line('loc : '||item.loc);
    end loop;
end;
/
----
--input_deptno�� �μ���ȣ�� �Է¹ް� v_deptno�� ����
--input_deptno �̰ų� �μ����� sales��� ���� ��� �μ����� 'SALES'
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
    v_dname := &input_dname; --�Է� �� ���ڿ��̹Ƿ� ' ' �ؾ���
    for item in c1(v_deptno, v_dname) loop
        dbms_output.put_line('deptno : '||item.deptno);
        dbms_output.put_line('dname : '||item.dname);
        dbms_output.put_line('loc : '||item.loc);
    end loop;
end;
/


