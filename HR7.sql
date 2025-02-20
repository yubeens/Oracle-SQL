set serveroutput on;
---1)employee_id = 200 �� ȸ����� ��� ���� �����ؼ� ���̵�, �̸�, �Ի��� ���
---employee_id , first_name, hire_date
select * from employees where employee_id = 200;
--Ŀ�� ��� ���ϱ�
DECLARE
 v_employees  employees%rowType;
BEGIN
    select * into v_employees
    from employees 
    where  employee_id = 200;
    dbms_output.put_line(v_employees.employee_id);
    dbms_output.put_line(v_employees.first_name);
    dbms_output.put_line(v_employees.hire_date);
end;
/
--Ŀ�� ���
DECLARE
    cursor c1 is
    select *
    from employees 
    where  employee_id = 200;
begin
   for item in c1 loop
    dbms_output.put_line(item.employee_id);
    dbms_output.put_line(item.first_name);
    dbms_output.put_line(item.hire_date);
   end loop;
end;
/

/*2.
EMPLOYEES ���� DEPARTMENT_ID, FIRST_NAME,SALARY, 
                PHONE_NUMBER,��Ÿ�� ����ϵ� 
�޿��� õ���� �и� ��ȣ ���
�޿��� 5000������ ��� ��Ÿ�� '���ӱ�', 5000~10000 '�����ӱ�',
10000 �ʰ� '���ӱ�'  
*/
--sql��
select  DEPARTMENT_ID,FIRST_NAME,SALARY,PHONE_NUMBER,
    case
        when SALARY >= 10000 then '���ӱ�'
        when SALARY > 5000  then '�����ӱ�'
        when SALARY <= 5000 then '���ӱ�'
    end  ��Ÿ
from  EMPLOYEES
order by department_id;
------
DECLARE
    cursor c1 is
    select  DEPARTMENT_ID,FIRST_NAME,SALARY,PHONE_NUMBER
    from EMPLOYEES;
    
    etc varchar2(20);
BEGIN
     for i in c1 loop
        if i.SALARY > 10000 then etc := '���ӱ�';
        elsif i.SALARY > 5000 then etc :='�����ӱ�';
        elsif i.SALARY <= 5000 then etc :='���ӱ�';
        end if;
       dbms_output.put_line(i.DEPARTMENT_ID || ' '||i.FIRST_NAME ||' '||
       to_char(i.SALARY,'999,999')||'  '||i.PHONE_NUMBER||' '||etc);
      end loop;
end;
/




