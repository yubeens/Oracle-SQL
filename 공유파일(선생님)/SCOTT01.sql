--emp  모든 정보 조회
select * from emp;
--dept  모든 정보 조회

--dept테이블 : 부서정보 테이블
--emp 테이블 : 사원정보 테이블
select * from dept;
--1. 부서번호(deptno) 가 10번인 모든 사원정보 출력
select * from emp where deptno = 10;
--2. 부서번호(deptno) 가 10번인 이름(ename),입사일(hiredate),부서번호(deptno)출력
select ename, hiredate,deptno from emp where deptno = 10;
--3. 사원번호(empno)가 7369인 사원의 이름, 입사일, 부서번호 출력
select ename, hiredate,deptno   from emp where empno = 7369;
--4. 이름(ename)이 allen인 사원의 모든 정보 출력
select * from emp;
select * from emp where ename = 'allen';
select * from emp where ename = 'ALLEN';
SELECT * FROM EMP WHERE ENAME = 'allen';
SELECT * FROM EMP WHERE ENAME = 'ALLEN';
--5.입사일(hiredate)이 1980 12 17인 사원의 이름(ename), 부서번호(deptno),
--월급(sal)  출력
select ename, deptno, sal from emp where hiredate = '1980/12/17';
select ename, deptno, sal from emp where hiredate = '80/12/17';
--6.직업(job)이  MANAGER 인 사원의 모든 정보 출력
select * from emp where job ='MANAGER';
--7. 직업(job)이  MANAGER 가 아닌 사원의 모든 정보 출력
select * from emp where job !='MANAGER';
select * from emp where job <> 'MANAGER';
--8.입사일(hiredate)이 81/04/02 이후에 입사한 사원정보
select * from emp where hiredate > '81/04/02';
describe emp;
desc emp;
--9.급여(sal)가 1000 이상인 사원의 이름(ename), 급여(sal), 부서번호(deptno)조회
select ename, sal, deptno from emp where sal >= 1000;
select * from emp where sal >=1000;
--10.급여(sal)가 1000 이상인 사원의 이름(ename), 급여(sal), 부서번호(deptno)조회
-- 급여가 높은 순으로 출력
select ename, sal, deptno
from emp
where sal >= 1000
order by sal desc;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal asc;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal;
-- 급여를 내림차순으로 출력 / 급여가 같다면 이름으로 오름차순
select ename, sal, deptno
from emp
where sal >= 1000
order by sal desc, ename asc;
--11. 이름이 'K'로 시작하는 사람보다 높은 이름을 가진 사원의 모든 정보
select *
from emp
where ename > 'K';

-- 집합연산자(UNION / MINUS / INTERSECT)
--emp  테이블에서 부서번호가 10인 사원번호(empno),이름(ename),급여(sal),부서번호(deptno)
--emp  테이블에서 부서번호가 20인 사원번호(empno),이름(ename),급여(sal),부서번호(deptno)
select empno,ename,sal, deptno from emp where deptno=10
UNION
select empno,ename,sal, deptno from emp where deptno=20;

--모든 부서중에서 20인 부서를 제외하고 출력(집합연산자 사용)
select * from emp
MINUS
select * from emp where deptno = 20;

select * from emp
INTERSECT
select * from emp where deptno = 20;

--12. 부서번호가 10이거나 20인 부서의 사원정보
select empno, ename,sal, deptno
from emp
where deptno = 10 or deptno = 20;

select empno, ename, sal, deptno
from emp
where deptno in (10,20);
--13.사원이름이 S로 끝나는 사원의 모든 정보 조회
select * from emp where ename like '%S';
--14. 30번 부서에서 근무하는 사원 중 job 이 SALESMAN 사원의
-- 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 조회
select empno, ename, job, sal, deptno
from emp
where deptno=30 and job ='SALESMAN';
--15. 30번 부서에서 근무하는 사원 중 job 이 SALESMAN 사원의
-- 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 
-- 급여가 많은 순으로 조회
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job ='SALESMAN'
order by sal desc;
--16. 30번 부서에서 근무하는 사원 중 job 이 SALESMAN 사원의
-- 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 
-- 급여가 많은 순으로 출력, 급여가 같다면 사원번호가 작은 순 먼저 출력
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job ='SALESMAN'
order by sal desc, empno asc;
------------------
--[20번, 30번 부서에 근무하는 사원 중에서 급여(sal)가  2000초과하는 
--사원의 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno) 출력
select * from emp where sal > 2000;
--17.집합연산자 사용
select empno, ename, sal, deptno
from emp
where deptno =20 and sal > 2000
UNION
select empno, ename, sal, deptno
from emp
where deptno =30 and sal > 2000;
--
select empno, ename, sal, deptno from emp where deptno in (20,30)
INTERSECT
select empno, ename, sal, deptno from emp where sal > 2000;

--18. 집합연산자 사용하지 않고
select empno, ename, sal, deptno
from emp
where deptno in (20,30) and sal>2000;

select empno, ename, sal, deptno
from emp
where (deptno = 20 or deptno = 30)  and sal>2000;
--19.급여(sal) 가 2000 이상 3000 이하 범위인 사원 정보 출력
select *
from emp
where sal >=2000 and sal<=3000;

select *
from emp
where sal BETWEEN 2000 and 3000;
--20.급여(sal) 가 2000 이상 3000 이하 범위 이외의 사원 정보 출력
select *
from emp
where sal <2000 or sal >3000;

select *
from emp
where sal NOT BETWEEN 2000 and 3000;
--21. 사원이름, 사원번호, 급여, 부서번호 출력
select ename, empno, sal , deptno 
from emp;

select ename as 사원이름, empno as 사원번호, sal 급여, deptno "부서 번호"
from emp;

select ename  사원이름, empno  사원번호, sal 급여, deptno 부서_번호
from emp;
--22. 사원이름에 E 가 포함되어 있는 30번 부서 사원 중에서
-- 급여가 1000~2000 사이가 아닌 사원을 출력
-- 단, 컬럼명을 사원이름, 사원 번호, 급여, 부서 번호 사용하기
select ename 사원이름, empno "사원 번호", sal 급여, deptno "부서 번호"
from emp
where ename like '%E%'
        and deptno = 30 
        and sal not BETWEEN 1000 and 2000;
        
select ename as 사원이름, empno "사원 번호", sal 급여, deptno "부서 번호"
from emp
where ename like '%E%'
        and deptno = 30 
        and (sal < 1000 or sal > 2000);   
--23. 주가수당(comm) 이 존재하지 않는(받을 수 없는) 사원 정보 출력
select * 
from emp
where comm is null;
--23. 주가수당(comm) 이 존재하는 사원 정보 출력
select *
from emp
where comm is not null;
--24. 주가수당(comm) 이 존재하는 사원 정보 출력(comm 이 0인 사원 제외)
select *
from emp
where comm is not null and comm <> 0;
--25.주가수당(comm)이 존재하지 않고, 상급자(mgr)는 있고, 직급이 MANAGER, CLERK 인
-- 사원 중에서 사원이름의 두번째 글자가 L 이 아닌 사원정보 출력
select * from emp;
select *
from emp
where comm is null
   and mgr is not null
   and job in ('MANAGER', 'CLERK')
   and ename not like '_L%';
   
------p128 오라클함수(내장함수)
select * from emp;
select ename, upper(ename) as 대문자, lower(ename) 소문자, initcap(ename)
from emp;
--ename  출력
select ename, length(ename)  이름글자수
from emp;
--사원이름(ename)이 5글자 이상인 사원의 이름(ename), 글자수 출력
select ename, length(ename)
from emp
where length(ename) >=5;
--  이름 추출
select ename, substr(ename,1,2),substr(ename, 3, 2),
       substr(ename,3),substr(ename,3,length(ename)),
       length(substr(ename,3)), length(substr(ename,3,length(ename)))
from emp;
--------------
select 'CORPORATE FLOOR'
from dual;
--위치값 리턴
select instr('CORPORATE FLOOR','OR',1,1)
from dual;

select instr('CORPORATE FLOOR','OR')
from dual;

select instr('CORPORATE FLOOR','OR',1,2)
from dual;

select instr('CORPORATE FLOOR','OR',-1,1)
from dual;

select instr('CORPORATE FLOOR','OR',-3,1)
from dual;

select instr('CORPORATE FLOOR','OR',-3,2)
from dual;
--- 문자열 ABCDDEF 에서  D 의 위치값 출력
-- 처음부터 첫번째 위치값 ==> 4
select instr('ABCDDEF','D',1,1), instr('ABCDDEF','D')
from dual;

-- 끝에서 첫번째 위치값
select instr('ABCDDEF','D',-1,1)
from dual;
--- emp 테이블에서 ename 중 S가 있는 위치 출력
select ename, instr(ename,'S'),instr(ename,'S',-1,1),instr(ename,'S',3)
from emp;
-- emp테이블에서 사원이름에 S가 들어있는 이름만 출력(instr 함수 사용)
select * from emp where ename like '%S%';
select ename
from emp
where instr(ename,'S') > 0;

-- emp 테이블에서 ename  출력 (이름의 앞 2글자만 추출하여 소문자로 출력)
select ename from emp;
--소문자
select lower(ename)  from emp;
--이름의 앞 2글자
select substr(ename, 1,2) from emp;

select ename ,lower(substr(ename,1,2)) 소문자, substr(lower(ename),1,2)소문자1
from emp;

--Replace
select '010-1234-5678' as rep_before,
     replace('010-1234-5678','-',' ') as rep_after
from dual;
--emp 테이블에서 S를 소문자 s로 변경하여 출력(replace 함수 사용)
select  ename, replace(ename, 'S', 's')
from emp;
-----
select length('한글'), lengthB('한글')
from dual;

select 'Oracle', length('Oracle'), lengthB('Oracle')
from dual;

select 'Oracle' ,LPAD('Oracle',10,'#') LPAD1,
                 RPAD('Oracle',10,'#') RPAD1,
                 LPAD('Oracle',10) LPAD2, length(LPAD('Oracle',10)),
                 RPAD('Oracle',10) RPAD2
from dual;
--emp 테이블에서  사원번호(앞2자리 숫자 나머지는 *) 사원번호,
-- 사원이름(첫 2글자만 나오고  나머지는 '*' 로 출력 사원이름
select empno,substr(empno,1,2),
       rpad(substr(empno,1,2),length(empno),'*') 사원번호,
       ename,substr(ename,1,2),
       rpad(substr(ename,1,2),length(ename),'*') 사원이름
from emp;
--p141
select rpad('971225-',14,'*') as RPAD_JMNO,
       rpad('010-1234-',13,'*') as RPAD_PHONE
from dual;
----------------------
select * from student;
--1. jumin 7510231901810  ==> 751023*******
select name,rpad(substr(jumin,1,7),length(jumin),'*') JUMIN_NO
from student;

--2. tel 055)381-2158  ==> 055-381-2158
select tel, name, replace(tel,')','-')
from student;

--3. 키(height)가 170이상인 학생의 studno, name, grade, height, weight
--키가 큰 학생순으로 출력, 만약 키가 같다면  studno 작은 순으로 출력
select studno, name, grade, height, weight
from student
where height >= 170
order by height desc, studno asc;

--4. 교수 professor 테이블에서  보너스를 받지 못하는 사람
-- 교수번호(profno), 이름(name), 월급(pay), 보너스(bonus) 출력
select profno 교수번호 ,name 이름,pay 월급,bonus 보너스
from professor
where bonus is null;

--5. 교수 professor 테이블에서 email중에서  아이디만 출력
--(@앞까지만 출력 : captain@abc.net ==>captain)
select name, email, substr(email,1,instr(email,'@')-1) 아이디
from professor;










--emp  모든 정보 조회
select * from emp;
--dept  모든 정보 조회

--dept테이블 : 부서정보 테이블
--emp 테이블 : 사원정보 테이블
select * from dept;
--1. 부서번호(deptno) 가 10번인 모든 사원정보 출력
select * from emp where deptno = 10;
--2. 부서번호(deptno) 가 10번인 이름(ename),입사일(hiredate),부서번호(deptno)출력
select ename, hiredate,deptno from emp where deptno = 10;
--3. 사원번호(empno)가 7369인 사원의 이름, 입사일, 부서번호 출력
select ename, hiredate,deptno   from emp where empno = 7369;
--4. 이름(ename)이 allen인 사원의 모든 정보 출력
select * from emp;
select * from emp where ename = 'allen';
select * from emp where ename = 'ALLEN';
SELECT * FROM EMP WHERE ENAME = 'allen';
SELECT * FROM EMP WHERE ENAME = 'ALLEN';
--5.입사일(hiredate)이 1980 12 17인 사원의 이름(ename), 부서번호(deptno),
--월급(sal)  출력
select ename, deptno, sal from emp where hiredate = '1980/12/17';
select ename, deptno, sal from emp where hiredate = '80/12/17';
--6.직업(job)이  MANAGER 인 사원의 모든 정보 출력
select * from emp where job ='MANAGER';
--7. 직업(job)이  MANAGER 가 아닌 사원의 모든 정보 출력
select * from emp where job !='MANAGER';
select * from emp where job <> 'MANAGER';
--8.입사일(hiredate)이 81/04/02 이후에 입사한 사원정보
select * from emp where hiredate > '81/04/02';
describe emp;
desc emp;
--9.급여(sal)가 1000 이상인 사원의 이름(ename), 급여(sal), 부서번호(deptno)조회
select ename, sal, deptno from emp where sal >= 1000;
select * from emp where sal >=1000;
--10.급여(sal)가 1000 이상인 사원의 이름(ename), 급여(sal), 부서번호(deptno)조회
-- 급여가 높은 순으로 출력
select ename, sal, deptno
from emp
where sal >= 1000
order by sal desc;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal asc;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal;
-- 급여를 내림차순으로 출력 / 급여가 같다면 이름으로 오름차순
select ename, sal, deptno
from emp
where sal >= 1000
order by sal desc, ename asc;
--11. 이름이 'K'로 시작하는 사람보다 높은 이름을 가진 사원의 모든 정보
select *
from emp
where ename > 'K';

-- 집합연산자(UNION / MINUS / INTERSECT)
--emp  테이블에서 부서번호가 10인 사원번호(empno),이름(ename),급여(sal),부서번호(deptno)
--emp  테이블에서 부서번호가 20인 사원번호(empno),이름(ename),급여(sal),부서번호(deptno)
select empno,ename,sal, deptno from emp where deptno=10
UNION
select empno,ename,sal, deptno from emp where deptno=20;

--모든 부서중에서 20인 부서를 제외하고 출력(집합연산자 사용)
select * from emp
MINUS
select * from emp where deptno = 20;

select * from emp
INTERSECT
select * from emp where deptno = 20;

--12. 부서번호가 10이거나 20인 부서의 사원정보
select empno, ename,sal, deptno
from emp
where deptno = 10 or deptno = 20;

select empno, ename, sal, deptno
from emp
where deptno in (10,20);
--13.사원이름이 S로 끝나는 사원의 모든 정보 조회
select * from emp where ename like '%S';
--14. 30번 부서에서 근무하는 사원 중 job 이 SALESMAN 사원의
-- 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 조회
select empno, ename, job, sal, deptno
from emp
where deptno=30 and job ='SALESMAN';
--15. 30번 부서에서 근무하는 사원 중 job 이 SALESMAN 사원의
-- 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 
-- 급여가 많은 순으로 조회
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job ='SALESMAN'
order by sal desc;
--16. 30번 부서에서 근무하는 사원 중 job 이 SALESMAN 사원의
-- 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 
-- 급여가 많은 순으로 출력, 급여가 같다면 사원번호가 작은 순 먼저 출력
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job ='SALESMAN'
order by sal desc, empno asc;
------------------
--[20번, 30번 부서에 근무하는 사원 중에서 급여(sal)가  2000초과하는 
--사원의 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno) 출력
select * from emp where sal > 2000;
--17.집합연산자 사용
select empno, ename, sal, deptno
from emp
where deptno =20 and sal > 2000
UNION
select empno, ename, sal, deptno
from emp
where deptno =30 and sal > 2000;
--
select empno, ename, sal, deptno from emp where deptno in (20,30)
INTERSECT
select empno, ename, sal, deptno from emp where sal > 2000;

--18. 집합연산자 사용하지 않고
select empno, ename, sal, deptno
from emp
where deptno in (20,30) and sal>2000;

select empno, ename, sal, deptno
from emp
where (deptno = 20 or deptno = 30)  and sal>2000;
--19.급여(sal) 가 2000 이상 3000 이하 범위인 사원 정보 출력
select *
from emp
where sal >=2000 and sal<=3000;

select *
from emp
where sal BETWEEN 2000 and 3000;
--20.급여(sal) 가 2000 이상 3000 이하 범위 이외의 사원 정보 출력
select *
from emp
where sal <2000 or sal >3000;

select *
from emp
where sal NOT BETWEEN 2000 and 3000;
--21. 사원이름, 사원번호, 급여, 부서번호 출력
select ename, empno, sal , deptno 
from emp;

select ename as 사원이름, empno as 사원번호, sal 급여, deptno "부서 번호"
from emp;

select ename  사원이름, empno  사원번호, sal 급여, deptno 부서_번호
from emp;
--22. 사원이름에 E 가 포함되어 있는 30번 부서 사원 중에서
-- 급여가 1000~2000 사이가 아닌 사원을 출력
-- 단, 컬럼명을 사원이름, 사원 번호, 급여, 부서 번호 사용하기
select ename 사원이름, empno "사원 번호", sal 급여, deptno "부서 번호"
from emp
where ename like '%E%'
        and deptno = 30 
        and sal not BETWEEN 1000 and 2000;
        
select ename as 사원이름, empno "사원 번호", sal 급여, deptno "부서 번호"
from emp
where ename like '%E%'
        and deptno = 30 
        and (sal < 1000 or sal > 2000);   
--23. 주가수당(comm) 이 존재하지 않는(받을 수 없는) 사원 정보 출력
select * 
from emp
where comm is null;
--23. 주가수당(comm) 이 존재하는 사원 정보 출력
select *
from emp
where comm is not null;
--24. 주가수당(comm) 이 존재하는 사원 정보 출력(comm 이 0인 사원 제외)
select *
from emp
where comm is not null and comm <> 0;
--25.주가수당(comm)이 존재하지 않고, 상급자(mgr)는 있고, 직급이 MANAGER, CLERK 인
-- 사원 중에서 사원이름의 두번째 글자가 L 이 아닌 사원정보 출력
select * from emp;
select *
from emp
where comm is null
   and mgr is not null
   and job in ('MANAGER', 'CLERK')
   and ename not like '_L%';
   
------p128 오라클함수(내장함수)
select * from emp;
select ename, upper(ename) as 대문자, lower(ename) 소문자, initcap(ename)
from emp;
--ename  출력
select ename, length(ename)  이름글자수
from emp;
--사원이름(ename)이 5글자 이상인 사원의 이름(ename), 글자수 출력
select ename, length(ename)
from emp
where length(ename) >=5;
--  이름 추출
select ename, substr(ename,1,2),substr(ename, 3, 2),
       substr(ename,3),substr(ename,3,length(ename)),
       length(substr(ename,3)), length(substr(ename,3,length(ename)))
from emp;
--------------
select 'CORPORATE FLOOR'
from dual;
--위치값 리턴
select instr('CORPORATE FLOOR','OR',1,1)
from dual;

select instr('CORPORATE FLOOR','OR')
from dual;

select instr('CORPORATE FLOOR','OR',1,2)
from dual;

select instr('CORPORATE FLOOR','OR',-1,1)
from dual;

select instr('CORPORATE FLOOR','OR',-3,1)
from dual;

select instr('CORPORATE FLOOR','OR',-3,2)
from dual;
--- 문자열 ABCDDEF 에서  D 의 위치값 출력
-- 처음부터 첫번째 위치값 ==> 4
select instr('ABCDDEF','D',1,1), instr('ABCDDEF','D')
from dual;

-- 끝에서 첫번째 위치값
select instr('ABCDDEF','D',-1,1)
from dual;
--- emp 테이블에서 ename 중 S가 있는 위치 출력
select ename, instr(ename,'S'),instr(ename,'S',-1,1),instr(ename,'S',3)
from emp;
-- emp테이블에서 사원이름에 S가 들어있는 이름만 출력(instr 함수 사용)
select * from emp where ename like '%S%';
select ename
from emp
where instr(ename,'S') > 0;

-- emp 테이블에서 ename  출력 (이름의 앞 2글자만 추출하여 소문자로 출력)
select ename from emp;
--소문자
select lower(ename)  from emp;
--이름의 앞 2글자
select substr(ename, 1,2) from emp;

select ename ,lower(substr(ename,1,2)) 소문자, substr(lower(ename),1,2)소문자1
from emp;

--Replace
select '010-1234-5678' as rep_before,
     replace('010-1234-5678','-',' ') as rep_after
from dual;
--emp 테이블에서 S를 소문자 s로 변경하여 출력(replace 함수 사용)
select  ename, replace(ename, 'S', 's')
from emp;
-----
select length('한글'), lengthB('한글')
from dual;

select 'Oracle', length('Oracle'), lengthB('Oracle')
from dual;

select 'Oracle' ,LPAD('Oracle',10,'#') LPAD1,
                 RPAD('Oracle',10,'#') RPAD1,
                 LPAD('Oracle',10) LPAD2, length(LPAD('Oracle',10)),
                 RPAD('Oracle',10) RPAD2
from dual;
--emp 테이블에서  사원번호(앞2자리 숫자 나머지는 *) 사원번호,
-- 사원이름(첫 2글자만 나오고  나머지는 '*' 로 출력 사원이름
select empno,substr(empno,1,2),
       rpad(substr(empno,1,2),length(empno),'*') 사원번호,
       ename,substr(ename,1,2),
       rpad(substr(ename,1,2),length(ename),'*') 사원이름
from emp;
--p141
select rpad('971225-',14,'*') as RPAD_JMNO,
       rpad('010-1234-',13,'*') as RPAD_PHONE
from dual;
----------------------
select * from student;
--1. jumin 7510231901810  ==> 751023*******
select name,rpad(substr(jumin,1,7),length(jumin),'*') JUMIN_NO
from student;

--2. tel 055)381-2158  ==> 055-381-2158
select tel, name, replace(tel,')','-')
from student;

--3. 키(height)가 170이상인 학생의 studno, name, grade, height, weight
--키가 큰 학생순으로 출력, 만약 키가 같다면  studno 작은 순으로 출력
select studno, name, grade, height, weight
from student
where height >= 170
order by height desc, studno asc;

--4. 교수 professor 테이블에서  보너스를 받지 못하는 사람
-- 교수번호(profno), 이름(name), 월급(pay), 보너스(bonus) 출력
select profno 교수번호 ,name 이름,pay 월급,bonus 보너스
from professor
where bonus is null;

--5. 교수 professor 테이블에서 email중에서  아이디만 출력
--(@앞까지만 출력 : captain@abc.net ==>captain)
select name, email, substr(email,1,instr(email,'@')-1) 아이디
from professor;










