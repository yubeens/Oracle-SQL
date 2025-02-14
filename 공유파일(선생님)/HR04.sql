--@D:\jung\DATABASE\hr_test_data2.sql;
--professor 테이블
--1. 학과별(deptno) 로 소속 교수들의 평균급여, 최소급여, 최대급여 출력
-- 단, 평균급여가 300 넘는 것만 출력
select * from professor;
select avg(pay), min(pay), max(pay)
from professor;
-- 학과별
select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by  deptno;
---  평균급여가 300 넘는 것만 출력
select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by  deptno
HAVING avg(pay)>300;
--2.student 테이블
--학년(grade), 학생수, 평균키, 평균 몸무게를 계산하되 
--학생 수가 4명 이상인 학년에 대해서 출력
--단, 평균 키와 평균 몸무게는 소숫점 첫번째 자리에서 반올림
--출력순서는 평균 키가 높은 순부터 내림차순으로 출력
select  grade, count(*), round(avg(height)),round(avg(weight),0)
from student
group by grade
HAVING count(*) >=4
order by  avg(height) desc;

--3.  professor , student 테이블
-- 학생이름(name) 지도교수 이름(name) 출력
select * from professor; -- 16개
select * from student; --20개
select *
from professor,student; --320개
--조인
select s.name 학생이름, p.name 지도교수
from professor p, student s
where p.profno = s.profno;
--join~on
select s.name 학생이름, p.name 지도교수이름
from student s join professor p
                on s.profno = p.profno;
---gift, customer 테이블
select * from gift;
select * from customer;
--4. 고객이름(gname), 포인트(point), 선물(gname)
select c.gname 고객, to_char(c.point, '999,999') 포인트, g.gname  선물
from gift g, customer c
where c.point between g.g_start and g.g_end;


select c.gname 고객, to_char(c.point, '999,999') 포인트, g.gname  선물
from gift g, customer c
where c.point >= g.g_start and c.point <= g.g_end;
--join~on
select c.gname, c.point, g.gname
from gift g join customer c
             on  c.point between g.g_start and g.g_end;
--5.학생들의 이름(name), 점수(total), 학점(grade) 출력
--student, score, hakjum
select * from student;  -- studno
select * from score;  --studno, total
select * from hakjum; -- min_point, max_point

select s.name 학생이름, s1.total 총점, h.grade 학점
from student s, score s1, hakjum h
where s.studno = s1.studno 
   and s1.total between h.min_point and h.max_point;

select s.name 학생이름, s1.total 총점, h.grade 학점
from student s, score s1, hakjum h
where s.studno = s1.studno 
   and s1.total >= h.min_point and s1.total <=h.max_point;

--join~on
select s.name, s1.total, h.grade
from student s join score s1
               on s.studno = s1.studno 
               join hakjum h
               on s1.total >= h.min_point and  s1.total <=h.max_point;
-----------------------------
--student, professor 테이블
--1.학생이름과 지도교수 이름 출력하되 지도교수가 정해지지 않은 학생 이름(모든 학생)도 출력
select * from student; --20개 출력
select * from professor;
--  =============
select s.name  학생이름, p.name 교수이름  --- 15개 출력
from student s, professor p
where s.profno = p.profno;
--natural join 
--오류 발생(공통된 컬럼: name, profno)
--select  s.name  학생이름, p.name 교수이름
--from student s natural join professor p;

--join using
select s.name  학생이름, p.name 교수이름
from student s join professor p using(profno);

--join on
select s.name  학생이름, p.name 교수이름
from student s join professor p on s.profno=p.profno;
--  =====모든학생
select s.name  학생이름, p.name 교수이름  --- 20개 출력
from student s, professor p
where s.profno = p.profno(+);

select s.name  학생이름, p.name 교수이름  --- 20개 출력
from student s left outer join professor p 
            on s.profno = p.profno;

--2. 101(deptno1)번 학과에 소속
-- 단, 지도교수가 없는 학생(모든학생)도 출력(학과번호, 학생이름, 지도교수이름)
select s.name  학생이름, p.name 지도교수, deptno1
from student s, professor p
where s.profno = p.profno(+)   and deptno1 =  101;
 
select s.name  학생이름, p.name 지도교수, deptno1
from student s left outer join professor p
on s.profno = p.profno
where deptno1 =  101;


--3. dept2테이블/emp2 에서  area 가  Seoul Branch Office 인
-- 사원의 사원번호(empno), 이름(name), 부서번호(deptno) 출력
select * from emp2;
select * from dept2;
select dcode from dept2 where area = 'Seoul Branch Office';

select empno, name, deptno 
from emp2
where deptno in (1000,1001,1002,1010);
--서브쿼리
select empno, name, deptno
from emp2
where deptno in (select dcode from dept2 where area ='Seoul Branch Office');

--join
select *
from emp2 e2, dept2 d2
where e2.deptno = d2.dcode
and d2.area = 'Seoul Branch Office';

select *
from emp2 e join dept2 d on e.deptno=d.dcode
where d.area = 'Seoul Branch Office';

--4.student 테이블에서 각 학년별 최대 몸무게를 가진 학생의 학년,이름, 몸무게 출력
select grade, max(weight)
from student
group by grade;

select grade, name, weight
from student
where weight in (select max(weight) from student group by grade);

select grade, name, weight
from student
where (grade,weight) in (select grade, max(weight) from student group by grade);




