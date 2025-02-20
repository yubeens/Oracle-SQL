set serveroutput on;
---1)employee_id = 200 인 회사원의 모든 정보 추출해서 아이디, 이름, 입사일 출력
---employee_id , first_name, hire_date
select * from employees where employee_id = 200;
--커서 사용 안하기
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
--커서 사용
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
EMPLOYEES 에서 DEPARTMENT_ID, FIRST_NAME,SALARY, 
                PHONE_NUMBER,기타를 출력하되 
급여는 천단위 분리 기호 사용
급여가 5000이하인 경우 기타에 '저임금', 5000~10000 '보통임금',
10000 초과 '고임금'  
*/
--sql문
select  DEPARTMENT_ID,FIRST_NAME,SALARY,PHONE_NUMBER,
    case
        when SALARY >= 10000 then '고임금'
        when SALARY > 5000  then '보통임금'
        when SALARY <= 5000 then '저임금'
    end  기타
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
        if i.SALARY > 10000 then etc := '고임금';
        elsif i.SALARY > 5000 then etc :='보통임금';
        elsif i.SALARY <= 5000 then etc :='저임금';
        end if;
       dbms_output.put_line(i.DEPARTMENT_ID || ' '||i.FIRST_NAME ||' '||
       to_char(i.SALARY,'999,999')||'  '||i.PHONE_NUMBER||' '||etc);
      end loop;
end;
/




