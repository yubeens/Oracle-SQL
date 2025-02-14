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
select to_char(hiredate,'YYYY')Hire_year, deptno, count(*)cnt
from emp 
group by deptno, to_char(hiredate, 'YYYY')
order by to_char(hiredate, 'YYYY') desc;

--4. 추가수당(comm)을 받는 사원 수와 받지 않는 사원 수 출력
--exist_comm(o,x) , cnt
select nvl2(comm, 'O','X'), count(*)
from emp
group by nvl2(comm,'O','X');

--5. 각 부서의(deptno) 입사 연도별(hire_year) 사원 수(cnt), 최고급여(max_sal), 급여 합(sum_sal), 평균급여(avg_sal)를 출력 
--각 부서별 소계와 총계도 출력
select deptno, to_char(hiredate,'YYYY') Hire_year, count(*) cnt, max(sal) max_sal, sum(sal) sum_sal, round(avg(sal)) avg_sal
from emp
group by rollup(deptno, to_char(hiredate, 'YYYY'))
order by deptno, to_char(hiredate, 'YYYY');