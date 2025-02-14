-- 1. professor 테이블에서,
-- 학과별로 소속 교수들의 평균급여, 최소급여, 최대급여 출력
-- 단, 평균 급여가 300이 넘는 것만 출력

SELECT
    deptno 학과, avg(pay) 평균급여, min(pay) 최소급여, max(pay) 최대급여
FROM professor
GROUP BY deptno
HAVING avg(pay) > 300;

-- 2. student 테이블에서,
-- 학년, 학생수, 평균 키, 평균 몸무게를 계산하되,
-- 학생 수가 4명 이상인 학년에 대해서 출력
-- 단, 평균 키와 평균 몸무게는 소숫점 첫번째 자리에서 반올림
-- 출력 순서는 평균 키가 높은 순부터 내림차순으로 출력
SELECT
    grade 학년, count(*) 학생수, round(avg(height)) "평균 키", round(avg(weight)) "평균 몸무게"
FROM student
GROUP BY grade
HAVING count(*) >= 4
ORDER BY avg(height) DESC;

-- 3. professor, student 테이블에서,
-- 학생이름과 지도교수 이름을 출력
SELECT
    student.name 학생, professor.name 지도교수
FROM student
    JOIN professor
    ON student.profno = professor.profno;
    
-- 4. gift, customer 테이블에서,
-- 고객이름(gname), 포인트(point), 선물(gname)을 출력
SELECT
    customer.gname 고객이름, TO_CHAR(point, '999,999') 포인트, gift.gname 선물
FROM customer JOIN gift
    ON customer.point >= gift.g_start
        AND customer.point <= gift.g_end;
-- 오라클 문법
SELECT
    customer.gname 고객이름, TO_CHAR(point, '999,999') 포인트, gift.gname 선물
FROM
    customer, gift
WHERE
    customer.point BETWEEN gift.g_start AND gift.g_end;
    
-- 5. student, score, hakjum 테이블에서
-- 학생이름(name), 점수(total), 학점(grade) 출력
SELECT
    name 학생이름, total 점수, hakjum.grade 학점
FROM student
    JOIN score
        ON student.studno = score.studno
    JOIN hakjum
        ON score.total BETWEEN hakjum.min_point AND hakjum.max_point;
    
-- 오라클 문법
SELECT
    name 학생이름, total 점수, hakjum.grade 학점
FROM
    student, score, hakjum
WHERE
    student.studno = score.studno
    AND
    score.total BETWEEN hakjum.min_point AND hakjum.max_point;
  
------------------------

--student, professor 테이블
select * from student; 
select * from professor;

--1. 학생이름과 지도교수 이름 출력하되 지도교수가 정해지지 않은 학생 이름도 출력
--표준
select s.name 학생이름, p.name 지도교수
from student s , professor p
where s.profno = p.profno(+);

--outer join
select s.name 학생이름, p.name 지도교수
from student s left outer join professor p
               on s.profno = p.profno;
               
--natural join (공통된 컬럼 : name, profno)
-- 공통된 컬럼이 2개이므로 오류발생!!
--select name s.name 학생이름, p.name 지도교수
--from student s natural join professor p

--join ~ using (복수는 상관없지만 비등가조인은 사용x)
select s.name 학생이름, p.name 지도교수
from student s join professor p using(profno);

--join ~ on
select s.name 학생이름, p.name 지도교수
from student s join professor p 
on s.profno = p.profno;


--2. 101(deptno1)번 학과에 소속
--단, 지도교수가 없는 학생도 출력(학과번호, 학생이름, 지도교수 이름)
--표준
select deptno1 학과번호, s.name 학생이름, p.name 지도교수
from student s, professor p
    where s.profno = p.profno(+)
and deptno1 = 101;

--outer join
select deptno1 학과번호, s.name 학생이름, p.name 지도교수
from student s left outer join professor p
on s.profno = p.profno
where deptno1 = 101;


--3. dept2 테이블에서 area가 seoul Branch office인
-- 사원의 사원번호(empno), 이름(name), 부서번호(deptno) 출력
select dcode from dept2 where area = 'Seoul Branch Office';

select empno, name, deptno 
from emp2
where deptno in (1000,1001,1002,1010);

--서브쿼리
select empno, name, deptno
from emp2
where deptno in (select dcode from dept2 where area = 'Seoul Branch Office');

--join
select e2.empno, e2.name, e2.deptno, d2.area
from emp2 e2, dept2 d2
where e2.deptno = d2.dcode
and d2.area = 'Seoul Branch Office';

select e.empno, e.name, e.deptno, d.area
from emp2 e join dept2 d on e.deptno = d.dcode
where d.area = 'Seoul Branch Office';

--4. student 테이블에서 각 학년별 최대 몸무게를 가진 학생의 학년, 이름, 몸무게 출력
select grade, max(weight)
from student
group by grade;

select grade, name, weight
from student
where weight in (select max(weight) from student group by grade);

select grade, name, weight
from student
where (grade,weight) in (select grade, max(weight) from student group by grade);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    