--p.262 9장 연습문제
--emp 테이블 
--1) 'ALLEN'과 같은 직책(job)인 사원들의 사원정보, 부서정보 출력
select e.job, e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno 
and job = 'SALESMAN'; 

--2) emp테이블에서 전체 사원의 평균급여(sal)보다 높은 급여를 받는 사원들의
--사원정보, 부서정보, 급여 등급 정보를 출력 (급여가 많은 순으로 정렬 / 급여가 같을 경우 사원 번호 기준 오름차순)
select avg(sal) from emp;

select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
join salgrade s on e.sal between s.losal and s.hisal
where e.sal > (select avg(sal) from emp)
order by e.sal desc, e.empno asc;

--3) 10번 부서에서 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의
--사원정보, 부서정보를 출력
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 10
and e.job not in(select distinct job from emp where deptno = 30);

--4) 직책이 'SALESMAN'인 사람들의 최고급여보다 높은 급여를 받는 사원들의
--사원정보, 급여등급정보 출력 (서브쿼리 활용 시 1. 다중행 함수 사용 / 2. 다중행 함수 사용x => 사원번호 기준 오름차순 정렬)
--1. 다중행 함수 사용
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where e.sal > all(select sal from emp where job = 'SALESMAN')
order by e.empno;

--2. 다중행 함수 사용
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where e.sal > (select max(sal) from emp where job = 'SALESMAN')
order by e.empno;