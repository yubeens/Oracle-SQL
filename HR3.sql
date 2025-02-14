--student 테이블
select * from student;
--1.student 테이블에서 각 학년별 최대 몸무게를 가진 학생들의 학년, 이름, 몸무게 출력
select grade, max(weight)
from student
group by grade;

select grade, name, weight
from student
where weight in (83,58,82,81);

select grade, name, weight
from student 
where weight in (select max(weight)
                 from student
                 group by grade);
                 
--2.professor department 테이블
select * from professor; --교수번호(profno), 이름(name), 학과번호(deptno), 입사일(hiredate)
select * from department; --학과명(dname), 학과번호(deptno)
--각 학과별 입사일이 가장 오래된 교수의 교수번호, 이름, 학과명 출력
--단, 입사일은 오름차순으로
select deptno, min(hiredate)
from professor
group by deptno;

select p.profno, p.name, d.dname, p.hiredate 
from professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                 from professor
                 group by deptno)
order by hiredate;

--부서번호 오름차순 출력
select p.profno, d.deptno, p.name, d.dname, p.hiredate 
from professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                 from professor
                 group by deptno)
order by 2; -- 컬럼의 위치(d.deptno)

--natural join
select p.profno, p.name, d.dname, p.hiredate 
from professor p natural join department d
where p.hiredate in(select min(hiredate)
                    from professor
                    group by deptno)
order by 2;

--join ~ using
select p.profno, p.name, d.dname, p.hiredate 
from professor p join department d
using(deptno)
where p.hiredate in(select min(hiredate)
                    from professor
                    group by deptno)
order by 2;

--join ~ on
select p.profno, p.name, d.dname, p.hiredate 
from professor p join department d
on p.deptno = d.deptno
where p.hiredate in(select min(hiredate)
                    from professor
                    group by deptno)
order by 2;

--3.emp2 테이블
--'Section head'(position) 직급의 최소 연봉자보다
--연봉이 높은 사람의 이름(name), 직급(position), 연봉(pay) 출력
select * from emp2;
--'Section head'(position) 직급의 최소 연봉자
select min(pay) from emp2 where position ='Section head'; --49000000

select name, position, pay
from emp2
where pay > 49000000; --7명

-->>
select name, position, pay
from emp2
where pay > (select min(pay)
            from emp2
            where position ='Section head');

--연봉을 천단위, 구분 표시하기
select name, position, to_char(pay,'L999,999,999') 연봉
from emp2
where pay > (select min(pay)
            from emp2
            where position ='Section head');

--4.employees 테이블
--부서번호가 80보다 큰 부서의 사원아이디(employee_id), 사원이름(first_name), 매니저이름(first_name) 출력
--self join
select e.employee_id 사원아이디, e.first_name 사원이름,
       m.employee_id 매니저아이디, m.first_name 매니저이름
from employees e, employees m
where e.manager_id = m.employee_id
and e.department_id > 80
order by 사원아이디;

--5.student, professor 테이블
--모든 학생 출력(즉, 지도교수가 없는 학생도 출력) 학생이름(name), 교수이름(name)
select * from student;   --20명 공통칼럼 profno
select * from professor; --16명 공통칼럼 profno

select s.name 학생이름 , p.name 교수이름
from student s, professor p
where s.profno = p.profno(+);

select s.name 학생이름 , p.name 교수이름
from student s inner join professor p
on s.profno = p.profno;

select s.name 학생이름 , p.name 교수이름
from student s left outer join professor p
on s.profno = p.profno;

select s.name 학생이름 , p.name 교수이름
from professor p right outer join student s
on s.profno = p.profno;



