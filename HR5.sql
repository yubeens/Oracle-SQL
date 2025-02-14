--1. Professor 테이블과  department 테이블
--교수번호(profno)와 교수이름(name), 소속학과이름(dname)을 조회하는
--view 생성 (v_prof_dept2)
select * from professor;
select * from department;

select *
from professor p, department d
where p.deptno = d.deptno;

----

create view v_prof_dept2
    as select profno,name,dname
        from professor p, department d
        where p.deptno = d.deptno;

select * from v_prof_dept2;

--2.1번 뷰를 읽기 전용으로  v_prof_dept3
create or replace view v_prof_dept3 
    as (select * from v_prof_dept2)
    with read only;
    
select * from v_prof_dept3;

--3. student , department 사용하여 
--학과별(deptno1)로 학생들의 최대키와 최대 몸무게, 학과 이름을 출력
select * from student;
select * from department;

select s.deptno1, d.dname
from student s, department d
where s.deptno1 = d.deptno;

select s.name, s.weight,d.dname
from student s, department d
where s.deptno1 = d.deptno;

select s.deptno1 deptno, s.name, s.weight max_weight, d.dname
from student s 
join department d on s.deptno1 = d.deptno
where s.weight = (select max(s2.weight) 
                    from student s2
                    where s2.deptno1=s.deptno1
                    );
                    
------
select s.deptno1, d.dname, s.max_height, s.max_weight
from ( select deptno1, max(height) max_height, max(weight) max_weight
        from student
        group by deptno1) s, department d
where s.deptno1 = d.deptno;

select s.deptno1, d.dname, s.height, s.weight
from student s, department d
where s.deptno1 = d.deptno
and(s.deptno1, s.height, s.weight)
    in(select deptno1, max(height), max(weight)
        from student
        group by deptno1);
         
--(DNAME      MAX_HEIGHT    MAX_WEIGHT)
--4. 학과이름, 학과별 최대키, 학과별로 가장 키가 큰 학생들의 이름과 키를  
select deptno1, max(height)
from student s
group by deptno1;

--인라인뷰
select d.dname, s.max_height, s1.name, s1.height
from (select deptno1, max(height) max_height
        from student 
        group by deptno1)s, department d, student s1
where s.deptno1 = d.deptno 
and s.deptno1 = s1.deptno1 
and max_height = s1.height;

select d.dname, height 최대키확인, s.name, s.height 
from student s, department d
where s.deptno1 = d.deptno
and (deptno1,height) in (select deptno1, max(height) max_height
                        from student 
                        group by deptno1);

--5.  student 학생의 키가 동일 학년의 평균 키보다 큰 학생의                           
--학년, 이름,키, 해당 학년의 평균키 출력 (인라인뷰 이용, 학년으로 오름차순)
select grade, avg(height)
from student
group by grade;

select g.grade, g.평균키, s.height 학생키
from (select grade, avg(height) 평균키
        from student
        group by grade)g, student s
where g.grade = s.grade
and s.height > g.평균키;

