select * from emp;
--p.174~175(연습문제)
--1. empno와 empno 앞 두자리 외 뒷자리를 *기호 출력, ename과 ename사원 이름의 첫글자만 보여주고 나머지 *기호로 출력
-- 사원 이름(ename) 이 다섯글자 이상이며 여섯 글자 미만인 사원 정보 출력
--empno, masking_empno, ename, masking_ename

select empno,
       RPAD (substr(empno,1,2),length(empno),'*') masking_empno,
       ename,
       RPAD (substr(ename,1,1),length(ename),'*') masking_ename
    from emp;
    
select empno,
       RPAD (substr(empno,1,2),length(empno),'*') masking_empno,
       ename,
       RPAD (substr(ename,1,1),length(ename),'*') masking_ename
    from emp
    where length(ename)=5;
    
    
--2. 하루 근무시간을 8시간으로 보았을 때 사원들의 하루 급여(day-pay)와 시급(time-pay)을 계산하여 출력
-- 하루 급여는 소수점 세번째 자리에서 버리고, 시급은 두 번째 소수점에서 반올림
-- empno, ename, sal, day_pay, time_pay

select empno, ename, sal,
    trunc(sal/21.5,2) day_pay, -- 표현되어지는 수까지
    round(sal/21.5/8,1) timp_pay 
from emp;


--3. 사원들은 입사일(hiredate)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원들이 정직원이 되는 날짜(r_job)를 yyyy-mm-dd형식으로 출력 / 단 추가수당이 없는 사원은 N/A로 출력

select empno, ename, hiredate,comm,
    add_months(hiredate,3)"3개월 후",
    next_day(add_months(hiredate,3),'월')R_JOB
from emp;

--yyyy-mm-dd형식, n/a 출력
desc emp;
select empno, ename, hiredate,comm,
    to_char(next_day(add_months(hiredate,3),'월'),'yyyy-mm-dd')R_JOB,
    nvl(to_char(comm), 'N/A')COMM  --숫자를 문자로 바꾼 후 적용
from emp;


--4.직속상관의 사원번호(mgr)가 존재하지 않을 경우 = 0000, 앞 두자리가 75 = 5555
-- 앞 두자리 76 = 6666, 77 = 7777, 78 = 8888, 그 외 그대로 출력

select empno, ename, mgr,
case 
    when mgr is null then 0000
    when substr(mgr,1,2) = 75 then 5555
    when substr(mgr,1,2) = 76 then 6666
    when substr(mgr,1,2) = 77 then 7777
    when substr(mgr,1,2) = 78 then 8888
    else mgr
end CHG_MGR
from emp;

--문자 형 변환 해줘야함
select empno, ename, mgr,
case 
    when mgr is null then '0000'
    when substr(mgr,1,2) = '75' then '5555'
    when substr(mgr,1,2) = '76' then '6666'
    when substr(mgr,1,2) = '77' then '7777'
    when substr(mgr,1,2) = '78' then '8888'
    else to_char(mgr)
end CHG_MGR
from emp;

--decode
select empno, ename, mgr,
    decode(substr(mgr,1,2),null, '0000',
            '75','5555',
            '76','6666',
            '77','7777',
            '78','8888',
            to_char(mgr)) CHG_MGR
from emp;


select sal from emp;
select DISTINCT(sal) from emp; --DISTINCT 중복제외

--p.177
--그룹함수 = 복수행함수 = 다중행함수(하나의 열에 출력 결과를 담는 다중행 함수)
select sal, comm from emp;
select sum(sal),sum(comm) from emp;
select count(sal) from emp;
select count(distinct(sal)) from emp;
select count(comm) from emp;
select count(empno) from emp;
select count(*) from emp;

-- emp테이블에서 부서번호(deptno)가 30번인 사원 수 
select count(*)
from emp
where deptno = 30;

--comm 이 null이 아닌 수
select count(comm) from emp;

select count(comm)
from emp
where comm is not null;

--comm이 null인 수
select count(*),count(comm)
from emp
where comm is null;

select comm
from emp
where comm is null;

--오류 발생 (ename값은 12ro, sum(sal)은 값이 1개이기 때문에 오류)
select ename, sum(sal) from emp;

select count(sal), count(distinct(sal)),count(all(sal))
from emp;

--최대값
select sal from emp;
select max(sal) from emp;

--최소값
select sal from emp;
select min(sal) from emp;

select max(sal), min(sal) from emp;

--평균
select avg(sal) from emp;

--평균 반올림, 소수 첫번째까지 출력
select round(avg(sal),1) from emp;

--부서번호가 20인 사원중에서 입사일이 가장 최근인 사원 출력
select max(hiredate)
from emp;

---------------------
--professor 테이블
select * from professor;

--1. 총 교수 수 출력
select count(*) from professor;
--2. 교수 급여 합계
select sum(pay) from professor; 
--3. 교수 급여 평균
select avg(pay) from professor;
--4. 교수들 급여의 평균을 소수점 첫째 자리에서 반올림
select round(avg(pay)) from professor;
--5. 최고 급여
select max(pay) from professor;
--6. 최저 급여
select min(pay) from professor;
--7. 교수 중 최고 급여를 받는 교수 이름(name)과 급여(pay) 출력
select name, pay from professor;

select name, pay 
from professor
where pay = 570;

select name, pay 
from professor
where pay = (select max(pay) from professor);

--8. 교수 급여 합계를 출력, 천 단위 쉼표 출력
select sum(pay), to_char(sum(pay),'9,999')sum_pay
from professor;


------------emp 테이블
select * from emp;

--1.10번 부서(deptno)의 평균 급여
select round(avg(sal)) from emp where deptno = 10;
--1.20번 부서(deptno)의 평균 급여
select round(avg(sal)) from emp where deptno = 20;
--1.30번 부서(deptno)의 평균 급여
select round(avg(sal)) from emp where deptno = 30;

--부서번호가 10,20,30인 부서의 평균 급여
--집합연산자 (union)
select round(avg(sal)) from emp where deptno = 10
union
select round(avg(sal)) from emp where deptno = 20
union
select round(avg(sal)) from emp where deptno = 30;

--in
select round(avg(sal)) from emp where deptno in(10,20,30);

--부서별 평균 급여
select deptno,round(avg(sal))"부서별 평균 급여"
from emp
group by deptno
order by deptno;

select deptno,round(avg(sal))"부서별 평균 급여"
from emp
group by deptno
order by "부서별 평균 급여"; -- 인식 가능


select * from emp;
select * from emp where deptno =30;
--부서(deptno) 및 직급별(job) 평균 급여
--부서번호 내림차순, 높은 급여 순으로 출력

select round(avg(sal))
from emp
group by deptno;

select deptno,job,round(avg(sal))AVG_SAL
from emp
group by deptno,job
order by deptno desc, AVG_SAL desc;


--------------
--professor 테이블
select * from professor;

--1.학과별(deptno) 교수들의 평균 급여(pay)
select deptno, round(avg(pay))평균급여 from professor group by deptno order by deptno desc;

--2.학과별 교수들의 급여 합계
select deptno, sum(pay) 급여합계 from professor group by deptno order by deptno desc;

--3.학과별 직급별(position) 교수들의 평균 급여
select deptno, position , round(avg(pay))평균급여 from professor group by deptno,position order by deptno desc;

--4.교수 중에서 급여(pay)와 보직수당(bonus)을 합친 금액이 가장 많은 경우와 가장 적은 경우를 출력 / 단, bonus가 없다면 0으로 계산
--급여(합친금액)는 소수 둘째 자리에서 반올림
select pay,bonus, pay+bonus, pay+nvl(bonus,0)급여,
       nvl(pay+bonus,0)급여1,
       nvl2(pay+bonus, pay+bonus, pay)급여2
from professor;

select round(max(pay+nvl(bonus,0)),1)최대급여, 
       round(min(pay+nvl(bonus,0)),1)최소급여
from professor;

--5. 직급(position)별 평균 급여(pay)가 300보다 크면 '우수', 작거나 같으면 '보통'
--직급(position), 평균급여, 비고 출력
select position, round(avg(pay))평균급여,
case 
    when avg(pay) > 300 then '우수'
    when avg(pay) <= 300 then '보통'
end 비고
from professor
group by position;

------------------
--emp테이블에서 입사년도별 인원수
-- total  1980년도  1981년도  1982년도
-- 12       1        10        1
select hiredate from emp;

select count(*) total,
    sum(decode(to_char(hiredate,'YYYY'),1980,1,0))"1980년도",
    sum(decode(to_char(hiredate,'YYYY'),1981,1,0))"1981년도",
    sum(decode(to_char(hiredate,'YYYY'),1982,1,0))"1982년도"
from emp;
-------------------
select count(*) total,
    count(decode(to_char(hiredate,'YYYY'),1980,2,null))"1980년도",
    count(decode(to_char(hiredate,'YYYY'),1981,3,null))"1981년도",
    count(decode(to_char(hiredate,'YYYY'),1982,4,null))"1982년도"
from emp;

-- emp테이블에서 1,000이상의 급여를 가지는 사원에 대해서만 부서별 평균을 구하되
-- 그 부서별 평균이 2,000이상인 부서번호, 부서별 평균급여 출력
select deptno, round(avg(sal))
from emp
where sal >= 1000
group by deptno
HAVING avg(sal) >= 2000; --group by의 조건은 where X, having으로 해야함


-----------professor 테이블
select * from professor;
--1.학과별로 소속 교수들의 평균 급여, 최소 급여, 최대 급여 구하기
--단, 평균 급여가 300 넘는 것만 출력
select deptno, round(avg(pay))평균급여, min(pay)최소급여, max(pay)최대급여
from professor
group by deptno
having avg(pay) > 300;

select deptno, avg(pay)평균급여, min(pay)최소급여, max(pay)최대급여
from professor
where pay > 300
group by deptno;

--2.학과별(deptno), 직급별(position)교수들의 평균 급여 구하기
--평균 급여가 400 이상인 것만 출력 => 학과번호, 직급, 평균급여
select deptno 학과번호, position 직급, round(avg(pay))"평균 급여"
from professor
group by deptno, position
having avg(pay) >= 400;

-----------student 테이블
--3.학년별(grade) 학생수, 평균 키, 평균 몸무게 구하기
--단, 학생수가 4명 이상인 것만 출력, 평균 키와 평균 몸무게는 소수점 첫째자리에서 반올림
--출력순서 : 평균 키가 높은 순부터 내림차순으로 출력
select * from student;

select grade, count(*) 학생수, round(avg(height))"평균 키", round(avg(weight)) "평균 몸무게"
from student
group by grade
having count(*) >= 4
order by "평균 키" desc;

--p.196
--1.부서 및 직급별 
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by deptno, job
order by deptno, job;

--rollup(A,B) A,B / A에 대한 것도 출력
--rollup(A,B,C) A,B,C / A,B/C에 대한 것도 출력
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by rollup(deptno, job)
order by deptno, job;

--cube(A,B) A,B / A/B에 대한 것도 출력
--cube(A,B,C) A,B,C / A,B/ A,C/ B,C/ A/B/C에 대한 것도 출력
select deptno, job, count(*), max(sal), min(sal), sum(sal), avg(sal)
from emp
group by cube(deptno, job)
order by deptno, job;

--emp테이블
--부서와 직급별 평균 급여 및 사원 수 구하기
--단, 부서별 평균급여와 사원 수, 전체 사원의 평균급여와 사원 수 출력
select deptno, job, avg(sal), count(*)
from emp
group by deptno, job
order by deptno, job;

select deptno, job, round(avg(sal)), count(*)
from emp
group by rollup(deptno, job) 
order by deptno, job;

select deptno, job, round(avg(sal)), count(*)
from emp
group by rollup(job, deptno) --직급별, 전체 소계 출력
order by job,deptno;

--부서 및 직급별 평균 급여와 사원 수 출력
--단, 부서별 평균 급여와 사원 수, 직급별 평균 급여와 사원 수, 전체 사원의 평균 급여와 사원 수
select deptno, job, round(avg(sal)), count(*)
from emp
group by deptno, job
order by deptno, job;

---------------------
--p.212 7장 연습문제
select * from emp;
--1.emp테이블에서 부서번호(deptno), 평균급여(avg_sal), 최고급여(max_sal), 최저급여(min_sal), 사원 수(cnt)를 출력
--단, 평균 급여는 소수점을 제외하고 각 부서 번호별로 출력
select deptno, round(avg(sal)) 평균급여, max(sal) 최고급여, min(sal) 최저급여, count(*) cnt
from emp
group by deptno
order by deptno desc;

--2. 같은 직책(job)에 종사하는 사원이 3명 이상인 직책과 인원수(count)를 출력
select job, count(*)
from emp
group by job
having count(*) >= 3;

--3. 사원들의 입사연도(hire_year)를 기준으로 부서별(deptno)로 몇 명(cnt)이 입사했는지 출력
select to_char(hiredate,'YYYY') from emp;

select to_char(hiredate,'YYYY')Hire_year, deptno, count(*)cnt
from emp 
group by deptno, to_char(hiredate, 'YYYY')
order by to_char(hiredate, 'YYYY') desc;

--4. 추가수당(comm)을 받는 사원 수와 받지 않는 사원 수 출력
--exist_comm(o,x) , cnt
select nvl2(comm, 'O','X') EXIST_COMM
from emp;

select nvl2(comm, 'O','X') EXIST_COMM, count(*)cnt
from emp
group by nvl2(comm,'O','X');

--5. 각 부서의(deptno) 입사 연도별(hire_year) 사원 수(cnt), 최고급여(max_sal), 급여 합(sum_sal), 평균급여(avg_sal)를 출력 
--각 부서별 소계와 총계도 출력
select deptno, to_char(hiredate,'YYYY') Hire_year, count(*) cnt, max(sal) max_sal, sum(sal) sum_sal, round(avg(sal)) avg_sal
from emp
group by rollup(deptno, to_char(hiredate, 'YYYY'))
order by deptno, to_char(hiredate, 'YYYY');

--각 부서별, 각 연도별, 전체 소계
select deptno, to_char(hiredate,'YYYY') Hire_year, count(*) cnt, max(sal) max_sal, sum(sal) sum_sal, round(avg(sal)) avg_sal
from emp
group by cube(deptno, to_char(hiredate, 'YYYY'))
order by deptno;

---------------------
--p.215 조인
select * from emp; --12개
select * from dept; -- 4개

--smith가 다니는 부서명 출력
select deptno from emp where ename = 'SMITH';
select dname from dept where deptno = 20;

select dname
from dept
where deptno = (select deptno from emp where ename = 'SMITH');

------
select * --48개 출력
from emp , dept;

select * 
from emp e , dept d
where e.deptno = d.deptno;
--사원번호(empno), 사원이름(ename), 직급(job), 부서명(dname), 지역(loc)
--등가조인
select empno, ename, job, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

select * from emp;
select * from salgrade;

--비등가조인
select *
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

select *
from emp e, salgrade s
where e.sal >= s.losal and e.sal <= s.hisal;

select * from emp;
--smith의 상사의 이름은?
select mgr from emp where ename = 'SMITH';
select ename from emp where empno = 7902;

select ename 
from emp
where empno = (select mgr from emp where ename = 'SMITH');

--자체조인(self join)
--사원의 상사(mgr)의 정보 출력
select *
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;

select e1.empno 사원번호, e1.ename 사원이름, e1.mgr 상사사원번호,
       e2.empno 상사사원번호, e2.ename 상사이름
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;




