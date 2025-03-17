/*
사번, 성명, 부서코드, 부서명, 기타를 출력하되,
employee_id/ first_name /department_id/department_name
부서코드가 80이면 '우리부서', 아니면 '타부서'를 기타 자리에 출력.
EMPLOYEES   DEPARTMENTS
*/
select * from EMPLOYEES;
select * from DEPARTMENTS;

--sql작성
select employee_id 사번, first_name 이름, d.department_id 부서번호, department_name 부서명
        from employees e, departments d
        where e.department_id = d.department_id;
        
--커서 이용
SET SERVEROUTPUT ON;

DECLARE
    cursor c1 is
        select employee_id 사번, first_name 이름, d.department_id 부서번호, department_name 부서명
        from employees e, departments d
        where e.department_id = d.department_id;
        
        depart varchar(20);    
BEGIN
    for e in c1 loop
        if e.부서번호 = 80 then depart:='우리부서';
        elsif e.부서번호 <> 80 then depart:='타부서';
        end if;
        dbms_output.put_line(e.사번 || ' ' || e.이름 || ' ' || e.부서번호 || ' ' || e.부서명 || ' ' || depart);   
    end loop;
end;
/

--join on
DECLARE
    cursor c1 is
    select e.employee_id 사번, e.first_name 이름, d.department_id 부서코드, d.department_name 부서명
    from employees e join departments d
    on e.department_id = d.department_id;
    
    depart VARCHAR2(20);
BEGIN
    for i in c1 loop
        if i.부서코드 = 80 then depart := '우리부서';
        else depart := '타부서';
        end if;
        dbms_output.put_line(i.사번||' '||i.이름||' '||i.부서코드||' '||i.부서명||' '||depart);
    end loop;
end;
/