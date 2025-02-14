-- p125~126 연습문제
-- 1. Emp 테이블에서 사원이름(ename)이 s로 끝나는 사원의 정보 출력
select * 
from emp 
where ename like '%S';

-- 2. Emp 테이블에서 30번 부서 중 직책(job)이 SALESMAN인 사원의 
-- 사원 번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno)를 출력
select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and job = 'SALESMAN';

-- 3. 20번,30번 부서에 근무하면서 급여가 2,000을 초과하는 사원의
-- 사원 번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno)를 출력
-- 1) 집합연산자 사용
select empno, ename, job, sal, deptno 
from emp 
where deptno = 20 and sal > 2000

UNION

select empno, ename, job, sal, deptno 
from emp 
where deptno = 30 and sal > 2000;

select empno, ename, job, sal, deptno 
from emp 
where deptno in(20,30)

INTERSECT

select empno, ename, job, sal, deptno 
from emp 
where sal > 2000;

-- 2) 집합연산자 미사용
select empno, ename, job, sal, deptno 
from emp 
where sal >= 2000 
and deptno in (20,30);

select empno, ename, job, sal, deptno 
from emp 
where (deptno = 20 or deptno = 30) 
and sal > 2000;

-- 4. 급여가 2,000이상 3,000이하 범위 이 외 not between a and b 사용하지 않기
select * 
from emp
where sal < 2000 or sal >3000;

-- 5. 사원이름에 E가 포함되어 있는 30번 부서의 사원 중 급여가 1,000~2,000 사이가 아닌 사원의
-- 이름(ename), 사원번호(empno), 급여(sal), 부서번호(deptno)를 출력
select ename, empno, sal, deptno 
from emp 
where ename like '%E%' 
    and deptno = 30 
    and sal not between 1000 and 2000;

-- 6. 추가수당(comm)이 존재하지 않고 상급자(mgr)가 있고 MANAGER CLERK (job)중에서 사원이름의 두번 째 글자가 L이 아닌 정보를 출력
select * 
from emp 
where comm is null 
    and mgr is not null 
    and job in ('MANAGER','CLERK')
    and ename not like '_L%';
