--@D:\jung\DATABASE\hr_test_data2.sql;

--1.student 테이블에서 각 학년별 최대 몸무게를 가진 학생들의 학년, 이름, 몸무게 출력
select * from student;
--각 학년별 최대 몸무게
select  grade, max(weight) 
from student
group by grade;

select grade, name, weight
from student
where weight in (83,58,82,81);

select grade, name ,weight
from student
where weight in (select   max(weight) 
                from student
                group by grade);

--2.professor  department 테이블
select * from professor; --교수번호(profno), 이름(name), 학과번호(deptno)
select * from department;  --dname(학과명),  학과번호(deptno)
-- 각 학과별 입사일이 가장 오래된 교수의 교수번호, 이름, 학과명 출력
-- 단, 입사일은 오름차순으로
--각 학과별 입사일이 가장 오래된 교수의 교수번호
select deptno, min(hiredate)
from professor
group by deptno;

select p.profno, p.name, d.dname
from  professor p, department d
where p.deptno = d.deptno;

select p.profno, d.deptno, p.name, d.dname,p.hiredate
from  professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by hiredate;
--부서번호 오름차순 출력
select p.profno, d.deptno, p.name, d.dname,p.hiredate
from  professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by d.deptno;

select p.profno, d.deptno, p.name, d.dname,p.hiredate
from  professor p, department d
where p.deptno = d.deptno
and hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by 2; -- 2는 컬럼의 위치(d.deptno)
-- natural join
select p.profno, deptno, p.name, d.dname,p.hiredate
from  professor p NATURAL join department d
where hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by 2;
-- join using
select p.profno, deptno, p.name, d.dname,p.hiredate
from  professor p join department d using(deptno)
where hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by 2;
-- join~on
select p.profno, p.deptno, p.name, d.dname,p.hiredate
from  professor p join department d on p.deptno = d.deptno
where hiredate in (select min(hiredate)
                    from professor
                    group by deptno)
order by 2;

--3. emp2 테이블
-- 'Section head'(position) 직급의 최소 연봉자보다
--연봉이 높은 사람의 이름(name), 직급(position), 연봉(pay) 출력
select *  from emp2;
--'Section head'(position) 직급의 최소 연봉자
select  min(pay) from  emp2 where position = 'Section head'; --49000000
select name, position,pay
from emp2
where pay > 49000000;

select name, position, pay
from emp2
where pay > (select min(pay)
            from emp2
            where position = 'Section head');
 -- 연봉을 천단위 , 구분 표시하기
select name, position, pay, to_char(pay,'999,999,999')연봉
from emp2
where pay > (select min(pay)
            from emp2
            where position = 'Section head');
--4.employees 테이블
--부서번호가 80보다 큰 부서의 사원아이디(employee_id), 사원이름(first_name),
--매니저이름(first_name) 출력