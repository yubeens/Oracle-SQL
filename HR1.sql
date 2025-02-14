--@C:\SQL_Practice\데이터자료\hr_table.sql;

--1. employee 테이블 모든 정보 조회
select * from employees;

--2. departments 테이블 모든 정보 조회
select * from departments;

--3. employee 테이블에서 first_name 조회
select first_name from employees;

--4. employee 테이블에서 department_id가 30번인 first_name만 조회
select first_name, department_id 
from employees 
where department_id = 30;

--5. employees 테이블에서 연봉(salary)이 9,000 이상인 사람의 first_name 조회
-- 연봉이 높은 순으로 출력
select first_name, salary 
from employees 
where salary >= 9000 order by salary desc; -- 같은 연봉을 이름 오름차순 조건 추가 first_name asc;

--6. employees 테이블에서 연봉이 9,000이상이고 부서번호(department_id)가 30번인 사람의 first_name조회
select first_name, salary, department_id 
from employees 
where salary >= 9000 and department_id = 30;

--7. employees 테이블에서 연봉이 9,000 이상이거나 부서번호가 30번인 사람의 first_name 조회
select first_name, salary, department_id 
from employees 
where salary >= 9000 or department_id = 30;

--8. 부서번호가 20이 아닌 사람의 first_name, department_id 조회
select first_name, department_id 
from employees 
where not department_id  = 20; --다른 방법 : department_id <> 20; , !=

--9. job_id가 PU_CLERK거나 ST_MAN이거나 SA_MAN인 사람의 first_name과 job_id 출력
select first_name, job_id 
from employees 
where job_id in ('PU_CLERK','ST_MAN','SA_MAN'); -- job_id = 'PU_CLERK' or job_id = 'ST_MAN' or job_id = 'SA_MAN';

--10. 부서번호과 100인 사원의 first_name, first_name의 첫 문자(첫 글자),부서번호 출력
select department_id 부서번호, first_name, substr(first_name,1,1) as 첫글자 
from employees 
where department_id = 100;

--11. 부서번호가 100인 사원의 first_name를 10글자로 표현하되 안쪽을 '*'로 채우기
select first_name, LPAD(first_name, 10),LPAD(first_name, 10, '*')
from employees
where department_id = 100;

--12. 부서번호가 100인 사원의 first_name의 두글자만 나오고 나머지 * 채우기
select first_name, substr(first_name,1,2),
    RPAD(substr(first_name,1,2),length(first_name),'*')사원이름
from employees
where department_id = 100;

