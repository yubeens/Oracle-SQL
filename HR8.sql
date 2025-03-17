/*
���, ����, �μ��ڵ�, �μ���, ��Ÿ�� ����ϵ�,
employee_id/ first_name /department_id/department_name
�μ��ڵ尡 80�̸� '�츮�μ�', �ƴϸ� 'Ÿ�μ�'�� ��Ÿ �ڸ��� ���.
EMPLOYEES   DEPARTMENTS
*/
select * from EMPLOYEES;
select * from DEPARTMENTS;

--sql�ۼ�
select employee_id ���, first_name �̸�, d.department_id �μ���ȣ, department_name �μ���
        from employees e, departments d
        where e.department_id = d.department_id;
        
--Ŀ�� �̿�
SET SERVEROUTPUT ON;

DECLARE
    cursor c1 is
        select employee_id ���, first_name �̸�, d.department_id �μ���ȣ, department_name �μ���
        from employees e, departments d
        where e.department_id = d.department_id;
        
        depart varchar(20);    
BEGIN
    for e in c1 loop
        if e.�μ���ȣ = 80 then depart:='�츮�μ�';
        elsif e.�μ���ȣ <> 80 then depart:='Ÿ�μ�';
        end if;
        dbms_output.put_line(e.��� || ' ' || e.�̸� || ' ' || e.�μ���ȣ || ' ' || e.�μ��� || ' ' || depart);   
    end loop;
end;
/

--join on
DECLARE
    cursor c1 is
    select e.employee_id ���, e.first_name �̸�, d.department_id �μ��ڵ�, d.department_name �μ���
    from employees e join departments d
    on e.department_id = d.department_id;
    
    depart VARCHAR2(20);
BEGIN
    for i in c1 loop
        if i.�μ��ڵ� = 80 then depart := '�츮�μ�';
        else depart := 'Ÿ�μ�';
        end if;
        dbms_output.put_line(i.���||' '||i.�̸�||' '||i.�μ��ڵ�||' '||i.�μ���||' '||depart);
    end loop;
end;
/