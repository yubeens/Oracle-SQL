--emp 모든 정보 조회
select * from emp;
--dept 모든 정보 조회

--dept테이블 : 부서정보 테이블
--emp테이블 : 사원정보 테이블
select * from dept;

--1. 부서번호(deptno)가 10번인 모든 사원 정보를 출력
select * from emp where deptno = 10;

--2. 부서번호(deptno)가 10번인 이름(ename), 입사일(hiredate), 부서번호(deptno)출력
select ename, hiredate, deptno from emp where deptno = 10;

--3. 사원번호(empno)가 7369인 사원의 이름, 입사일, 부서번호 출력
select ename, hiredate, deptno from emp where empno = 7369;

--4. 이름(ename)이 allen인 사원의 모든 정보 출력 (문자는 작은따옴표('')와 대소문자 구분 / 명령어는 대소문자 구분X)
select * from emp where ename = 'ALLEN';
SELECT * FROM EMP WHERE ENAME = 'ALLEN';

--5. 입사일(hiredate)이 1980 12 17인 사원의 이름(ename), 부서번호(deptno), 월급(sal) 출력
select ename, deptno, sal from emp where hiredate = '1980/12/17';
select ename, deptno, sal from emp where hiredate = '80/12/17';

--6. 직업(job)이 MANAGER인 사원의 모든 정보 출력
select * from emp where job = 'MANAGER';

--7. 직업(job)이 MANAGER가 아닌 사원의 모든 정보 출력
select * from emp where job != 'MANAGER';
select * from emp where job <> 'MANAGER';

--8. 입사일(hiredate)이 81/04/02 이후에 입사한 사원정보
select * from emp where hiredate > '81/04/02';
describe emp;
desc emp;

--9. 급여(sal)가 1,000 이상인 사원의 이름(ename), 급여(sal), 부서번호(deptno) 조회
select ename, sal, deptno from emp where sal >= 1000;
select * from emp where sal >= 1000;

--10. 급여(sal)가 1,000 이상인 사원의 이름(ename), 급여(sal), 부서번호(deptno)를 높은 순으로 출력 (order by - 정렬 , desc - 내림차순, asc - 오름차순)
select ename, sal, deptno from emp where sal >= 1000 order by sal desc;
select ename, sal, deptno from emp where sal >= 1000 order by sal asc;

-- 급여를 내림차순으로 출력하나 급여가 같다면 이름으로 오름차순 출력
select ename, sal, deptno from emp where sal >= 1000 order by sal desc, ename asc;

--11. 이름이 'K'로 시작하는 사람보다 높은 이름을 가진 사원의 모든 정보
select * from emp where ename > 'K';

--집합연산자(UNION)
--emp 테이블에서 부서번호가 10인 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno) 출력
--emp 테이블에서 부서번호가 20인 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno) 출력
select empno, ename, sal, deptno from emp where deptno = 10
UNION
select empno, ename, sal, deptno from emp where deptno = 20;

--집합연산자(MINUS)
--모든 부서중에서 20인 부서를 제외하고 출력
select * from emp
MINUS
select * from emp where deptno = 20;

--집합연산자 (INTERSECT)
--모든 부서중에서 20인 부서만 출력
select * from emp
INTERSECT
select * from emp where deptno = 20;

--12. 부서번호가 10이거나 20인 부서의 사원정보 출력 (union, or, in())
select empno, ename, sal, deptno from emp where deptno = 10 or deptno = 20;
select empno, ename, sal, deptno from emp where deptno in (10,20);

--13. 사원이름이 대문자 S로 끝나는 사원의 모든 정보 조회
select * from emp where ename like '%S';

--14. 30번 부서에서 근무하는 사원 중 job이 SALESMAN 사원의 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 조회
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN';

-- 15. 30번 부서에서 근무하는 사원 중 job이 SALESMAN 사원의 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 조회 / 급여가 높은순으로 조회
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN' order by sal desc;

-- 15. 30번 부서에서 근무하는 사원 중 job이 SALESMAN 사원의 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 조회 / 급여가 같다면 사원번호가 작은 순 먼저 출력
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN' order by sal desc, empno asc;

----------------------------
--[20번,30번 부서에 근무하는 사원 중에서 급여(sal)가 2,000을 초과하는 사원의 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno) 출력

--17. 집합연산자 사용
select empno, ename, sal, deptno from emp where deptno = 20 and sal > 2000
UNION
select empno, ename, sal, deptno from emp where deptno = 30 and sal > 2000;

select empno, ename, sal, deptno from emp where deptno in (20,30)
INTERSECT
select empno, ename, sal, deptno from emp where sal > 2000;

--18. 집합연산자 사용하지 않고
select empno, ename, sal, deptno from emp where sal >= 2000 and deptno in (20,30);

select empno, ename, sal, deptno from emp where (deptno = 20 or deptno = 30) and sal > 2000;

--19. 급여(sal)가 2,000이상 3,000이하 범위인 사원 정보 출력
select * from emp where sal >=2000 and sal <=3000;

select * from emp where sal BETWEEN 2000 and 3000;

--20. 급여(sal)가 2,000이상 3,000이하 범위 이외의 사원 정보 출력
select * from emp where sal <2000 or sal >3000;

select * from emp where sal NOT BETWEEN 2000 and 3000;

--21. 사원이름, 사원번호, 급여, 부서번호 출력
select ename, empno, sal, deptno from emp;

select ename as 사원이름, empno as 사원번호, sal 급여, deptno "부서 번호" from emp;

select ename as 사원이름, empno as 사원번호, sal 급여, deptno 부서_번호 from emp;

--22. 사원이름에 E가 포함되어 있는 30번 부서 사원 중에서 급여가 1,000에서 2,000사이가 아닌 사원을 출력 / 컬럼명은 사원이름, 사원 번호, 급여, 부서 번호 사용하기
select ename 사원이름, empno "사원 번호", sal 급여, deptno "부서 번호" from emp where ename like '%E%' and deptno = 30 and sal not BETWEEN 1000 and 2000;

--23. 주가수당(comm)이 존재하지 않는(받을 수 없는) 사원 정보 출력
select * from emp where comm is null;

--24. 주가수당(comm)이 존재하는 사원 정보 출력
select * from emp where comm is not null and comm <>0;

--25. 주가수당(comm)이 존재하지 않고, 상급자(mgr)는 있고, 직급이 MANAGER, CLERK인 사원 중에서 사원이름의 두번째 글자가 L이 아닌 사원정보 출력
select * from emp where comm is null and mgr is not null and job in ('MANAGER','CLERK') and ename not like '_L%';

-------------p.128 오라클함수(내장함수)
select * from emp;
select  ename, upper(ename) as 대문자, lower(ename) 소문자, initcap(ename)
from emp;
--ename 출력
select ename, length(ename) 이름글자수 
from emp;
--사원 이름이 5글자 이상인 사원의 이름과 글자 수 출력
select ename ,length(ename) as 글자수 from emp
where length(ename)>=5;
--이름 추출
select ename, substr(ename,1,2), substr(ename,3,2), substr(ename,3),substr(ename,3,length(ename)),
              length(substr(ename,3)),length(substr(ename,3,length(ename)))
from emp;
------------
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
--- 문자열 ABCDEF에서 D의 위치값 출력
--- 처음부터 첫번째 위치값
select instr('ABCDDEF','D')
from dual;

--- 끝에서 첫번째 위치값
select instr('ABCDDEF','D',-1,1)
from dual;
--- emp테이블에서 ename중 s가 있는 위치 출력
select ename, instr(ename, 'S'), instr(ename,'S',-1,1), instr(ename,'S',3)
from emp;
--- emp테이블에서 사원이름에 s가 들어있는 이름만 출력 (instr 함수 사용)
select ename
from emp
where instr(ename,'S') > 0;

-- emp 테이블에서 ename 출력 (이름의 2글자만 추출하여 소문자로 변환해서 출력)
select substr(lower(ename),1,2)
from emp;

select ename, lower(substr(ename,1,2)) 소문자, substr(lower(ename),1,2)소문자1
from emp;

-- Replace 대체
select '010-1234-5678' as rep_before, 
    replace('010-1234-5678','-',' ') as rep_after
from dual;
-- emp 테이블에서 s를 소문자 s로 변경하여 출력 (replace 함수 사용)
select ename, replace(ename,'S','s')
from emp;

--
select length('한글'), lengthB('한글')
from dual;

select 'Oracle',length('Oracle'),lengthB('Oracle')
from dual;

select 'Oracle',LPAD('Oracle',10,'#')LPAD1,
                RPAD('Oracle',10,'#')RPAD1,
                LPAD('Oracle',10)LPAD2, length(LPAD('Oracle',10)),
                RPAD('Oracle',10)RPAD2
from dual;

-- emp 테이블에서 사원번호(앞 2자리 - 숫자, 나머지 - *), 사원 이름(앞 2글자 - 그대로, 나머지 - *로 출력)
select RPAD(substr(empno,1,2),length(empno),'*')사원번호, RPAD(substr(ename,1,2),length(ename),'*') 사원이름
    from emp;

select rpad(substr(empno,1,2),length(empno),'*')사원번호,
       rpad(substr(ename,1,2),length(ename),'*')사원이름
from emp;

---p.141
select rpad('971225-',14,'*') as RPAD_JMNO,
       rpad('010-1234-',13,'*') as RPAD_PHONE
from dual;
-----------------
select * from student;
--1. jumin => 751023*******
select name,RPAD(substr(jumin,1,6),length(jumin),'*') as jumin
from student;
--2. tel => 055-381-2158
select name,replace(tel,')','-')as tel
from student;
--3. height 170이상인 학생의 studno, name, grade, height, weight/ 키가 큰 학생순으로 출력, 만약 키가 같다면 studno작은 순으로 출력
select studno, name, grade, height, weight 
from student where height >= 170 order by height desc, studno asc;
--4. 교수 professor 테이블에서 보너스를 받지 못하는 사람 출력 / 교수번호(profno), 이름(name), 월급(pay), 보너스(bonus) 출력
select profno 교수번호, name 이름, pay 월급, bonus 보너스 from professor where bonus is null;
--5. 교수 professor 테이블에서 email중에서 아이디만 출력 (@앞까지만 출력)
select name, substr(email,1,instr(email,'@')-1) 아이디
from professor;

select * from professor;



--2025.01.24
-----------------------------------------
-- concat함수 ename:job 예)SMITH:CLERK
select concat(ename, ':'),
       concat(concat(ename, ':'),job),
       concat(ename,concat(':',job))
from emp;


--p.142 문자열 연결 ||
select ename || ':' || job as 이름_직업
from emp;

--공백제거
select '     orcle    ', length('     orcle    '),
    TRIM('     orcle    '),length(TRIM('     orcle    ')) trim길이,
    LTRIM('     orcle    '),length(LTRIM('     orcle    ')) ltrim길이,
    RTRIM('     orcle    '),length(RTRIM('     orcle    ')) rtrim길이
from dual;

------ 숫자

--round(반올림) ,숫자 (보여지는 숫자 자리)
select 123.567, round(123.567,1), round(123.567,2),
    round(123.567,-1), round(123.567,-2), round(123.567)
from dual;

--trunc(버림)
select 15.793, trunc(15.793,1), trunc(15.793,2),
    trunc(15.793,-1), trunc(15.793)
from dual;

--ceil(가장 가까운 큰 정수), floor(가장 가까운 작은 정수 반환)
select 3.14, ceil(3.14), floor(3.14), trunc(3.14),
            ceil(-3.14), floor(-3.14), trunc(-3.14)
from dual;

-- power(A의B승, A의B제곱)
select power(2,3) from dual;

-- mod(A를 B로 나눈 나머지)
select mod(15,6) from dual;

-- 날짜관련 함수
select sysdate 오늘, sysdate+1 내일, sysdate-1 어제, sysdate+3
from dual;
--3개월 뒤
select sysdate, add_months(sysdate,3), add_months('22/05/01',3)
from dual;

--emp테이블에서 사원번호(empno), 이름(ename), 입사일(hiredate)
--입사 10년 후(입사10년후)날짜 출력

select empno, ename, hiredate,add_months(hiredate,120) 입사10년후
from emp;

select months_between(sysdate, '24/01/24')
from dual;

--emp테이블 이름(ename), 입사일(hiredate), 근무 개월 수 (현재 - 입사일)
--소수 첫째자리까지 표현(trunc 사용)
select ename, hiredate,months_between(sysdate,hiredate)근무개월수,
    trunc(months_between(sysdate,hiredate),1)근무개월수1,
    trunc(months_between(hiredate,sysdate),1)근무개월수1
from emp;

--근무개월 수를 출력하는데 '개월'글자 출력, 소수점 이하는 버림 => 예)529개월
--이름, 근무개월 수 출력
--concat(A,B)함수 사용

select ename, concat(trunc(months_between(sysdate,hiredate)),'개월')근무개월수
from emp;

--|| 사용 (문자열 연결)
select ename, trunc(months_between(sysdate, hiredate))||'개월' 근무개월
from emp;
    
--
select sysdate,next_day(sysdate,'월요일')월요일,
       next_day(sysdate,'토요일')토요일,
       last_day(sysdate)마지막날,
       last_day('24/07/01')
from dual;

--사원번호(empno)가 짝수인 사원의 사원번호(empno), 이름(ename), 직금(job) 출력
select empno, ename, job
from emp
where mod(empno,2)=0
order by empno;

--급여(sal)가 1,500에서 3,000사이의 사원은 그 급여의 15%(0.15)를 회비로 지불
-- 이름(ename), 급여(sal), 회비(반올림) 출력

select ename, sal, round(sal * 0.15,0)회비
from emp
where sal between 1500 and 3000;

---p.157 형 변환 함수
describe emp; --유형확인

--empno(숫자) '500'(문자)=> 숫자 7369+500 = 7869 (500 -> 숫자로 알아서 변환)
select empno, ename, empno+'500'
from emp;

--오류 예시--
-- empno(숫자) 'ABCD'(문자)=> 숫자 7369+ABCD =>오류발생
--select empno, ename, empno+'ABCD' 
--from emp;
--select empno, ename, 'ABCD'+empno
--from emp;

----------
select sysdate from dual;
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')현재날짜시간
from dual;

select to_char(sysdate,'mm')월 from dual;
select to_char(sysdate,'dd')일 from dual;
select to_char(sysdate,'hh')시 from dual;
select to_char(sysdate,'mi')분 from dual;
select to_char(sysdate,'ss')초 from dual;
select to_char(sysdate,'mon')월 from dual;
select to_char(sysdate,'month')월 from dual;
select to_char(sysdate,'day')요일 from dual;
select to_char(sysdate,'DAY')요일 from dual;

--입사일이 1,2,3월인 사원의 번호(empno),이름(ename),입사일(hiredate)출력
select empno,ename,to_char(hiredate,'mm')월 
from emp
where to_char(hiredate,'mm')between '01' and '03';

select sal, to_char(sal,'$999,999')sal_$,
            to_char(sal,'L999,999')sal_L, -- 원 형식 표시 L 
            to_char(sal,'999,999')sal_9, --숫자를 전부 표기할 때 9적용
            to_char(sal,'000,999')sal_0  
from emp;

select 1300-1500 from dual;

select '1300'-'1500' from dual;

select to_number('1300') - to_number('1500')
from dual;

select to_number('1,300','999,999')
from dual;

--오류발생
--select to_number('1,300') - to_number('1,500') from dual;

select to_number('1,300','999,999') - to_number('1,500','999,999')
from dual;

---p.164
-- '20240727' 문자 => 날짜형
select to_date('20240727') as str_date
from dual;

select to_date('20240727','yyyy-mm-dd') as str_date
from dual;

--81/12/03 이후 입사한 사원 출력
--hiredate형식이 date형식이라 문자변환 안해도 적용이 되긴 함.
select * from emp where hiredate > '81/12/03';

select * 
from emp
where hiredate > to_date('81/12/03','rr/mm/dd');

----------
--null
--사번(empno), 이름(ename), 급여(sal), 커미션(comm), 급여+커미션(sal+comm) 출력
select empno, ename, sal, comm, sal+comm 수입,
       nvl(comm, 0), sal+nvl(comm,0) 실제수입
from emp;

--사번(empno), 이름(ename), 급여(sal), 커미션(comm), 급여+커미션(sal+comm) 수입 출력
-- 수입을 천단위로 구분하여 출력

select empno, ename, sal,comm,
    sal*12+nvl(comm,0)연봉,
    to_char(sal+nvl(comm,0), '999,999')수입,
    to_char(sal*12+nvl(comm,0), '999,999')||'만' as 연봉 
from emp;

--comm을 받으면 o, 받지 않으면 x 로 출력
select empno, ename, comm, nvl2(comm,'O','X') comm유무
from emp;

--nvl2 사용하여 연봉 출력(sal*12)
-- empno, ename, sal. comm, 연봉 *(sal*12+comm)
select empno, ename, sal, comm, nvl2(comm,(sal*12+comm),(sal*12))연봉
from emp;

select empno, ename, sal, comm, nvl2(comm,sal*12+comm, sal*12)연봉
from emp;

select empno, ename, sal, comm, sal*12+nvl2(comm,comm,0)연봉
from emp;

--nvl사용
select empno, ename, sal, comm,sal*12+nvl(comm,0)연봉,
        to_char(sal*12+nvl(comm,0), '999,999')연봉1
from emp;

select * from emp;
--empno, ename, mgr 출력 / mgr이 null이면 'CEO'출력

select empno, ename, mgr, nvl(to_char(mgr),'CEO')mgr,
    nvl2(to_char(mgr), to_char(mgr),'CEO'),
    nvl2(mgr,to_char(mgr),'CEO')
from emp;

-empno, ename, mgr 출력 / mgr이 null이면 9999 출력
select empno, ename, mgr, nvl(mgr,9999)
from emp;

----------
--p.170
--job에 따라 급여 다르게 인상
-- MANAGER 1.5 / SALESMAN 1.2 / ANALYST 1.05 / 1.04
select empno, ename, job, sal,
    decode(job,'MANAGER',sal*1.5,
               'SALESMAN', sal*1.2,
               'ANALYST', sal*1.05,
               sal*1.04) 인상급여
from emp;

--case when
select empno, ename, job, sal,
    case job
        when 'MANAGER' then sal*1.5
        when 'SALESMNAN' then sal*1.2
        when 'ANALYST' then sal*1.05
        else sal*1.04
    end 인상급여
from emp;

--------
--comm이 null이면 해당사항 없음, comm = 0이면 수당 없음
--comm이 있으면 수당(예: comm이 50이면 => 수당:50)
--empno, ename, comm, comm_txt 출력 
--decode 사용
select empno, ename, comm, 
    decode(comm, null, '해당사항 없음',
                 0,'수당 없음',
                 '수당:'||to_char(comm)
                 )comm_txt
from emp;
--case when ~ then 사용
select empno, ename, comm,
    case 
        when comm is null then '해당사항 없음'
        when comm = 0 then '수당 없음'
        when comm > 0 then '수당:'||comm
    end as comm_txt
from emp;

----------------
--professor테이블
select * from professor;
-- 1. professor테이블 교수명(name)과 학과번호(deptno), 학과명 출력
--deptno = 101이면 '컴퓨터공학과'
--case
select name, deptno,
    case 
        when deptno = 101 then '컴퓨터공학과'
    end as 학과명
from professor;
--decode
select name, deptno, 
    decode(deptno, 101,'컴퓨터공학과'
                    )학과명
from professor;

-- 2. professor테이블 교수명(name)과 학과번호(deptno), 학과명 출력
--deptno = 101이면 '컴퓨터공학과', 나머지 학과는 기타 출력
--case
select name, deptno,
    case 
        when deptno = 101 then '컴퓨터공학과'
        else '기타'
    end as 학과명
from professor;
--decode
select name, deptno,
    decode(deptno, 101,'컴퓨터공학과','기타')학과명
from professor;

-- 3. professor테이블 교수명(name)과 학과번호(deptno), 학과명 출력
--deptno = 101이면 '컴퓨터공학과' / 102 - '멀티미디어공학과' / 201 - '소프트웨어공학과' / 나머지는 기타 출력
--case
select name, deptno,
    case 
        when deptno = 101 then '컴퓨터공학과'
        when deptno = 102 then '멀티미디어공학과'
        when deptno = 201 then '소프트웨어공학과'
        else '기타'
    end as 학과명
from professor;
-- decode
select name, deptno,
    decode(deptno, 101,'컴퓨터공학과',
                   102,'멀티미디어공학과',
                   201,'소프트웨어공학과','기타')학과명
from professor;

--student테이블
select * from student;

--학생을 3개 팀으로 분류하기 위해 학번(studno)을 3으로 나누어
--나머지가 0이면 A팀, 1이면 B팀, 2이면 C팀
--학생번호(studno),이름(name),학과번호(deptno1),팀이름 출력
--case
select studno, name, deptno1,
    case 
        when mod(studno, 3) = 0 then 'A'
        when mod(studno, 3) = 1 then 'B'
        when mod(studno, 3) = 2 then 'C'
    end as 팀이름
from student;

--decode
select studno, name, deptno1,
    decode(mod(studno,3),0,'A',1,'B',2,'C')팀이름
from student;

---
select * from student;
select jumin from student;
--1.학생테이블에서 jumin 7번째가 1이면 남자, 2이면 여자
-- 학번(studno), 이름(name), 주민(jumin), 성별

select studno, name, jumin,
    case
        when substr(jumin,7,1) ='1' then '남자'
        when substr(jumin,7,1) ='2' then '여자'
    end 성별
from student;


select studno, name, jumin,
    case substr(jumin,7,1) 
        when '1' then '남자'
        when '2' then '여자'
    end 성별
from student;

select studno, name, jumin,
    decode substr(jumin,7,1),'1','남자','2','여자')성별
from student;

--2. tel의 지역번호에서 02서울, 051부산, 052울산, 053대구 / 나머지는 기타로 출력
--이름, 전화번호, 지역 출력

select * from student;
--decode 
--(1)
select name,tel,
    decode(substr(tel,1,instr(tel,')')-1),'02','서울',
                                          '051','부산',
                                          '052','울산',
                                          '053','대구',
                                          '기타') 지역
from student;
--(2)
select name, tel, 
    decode(substr(tel,1,3),
    '02)','서울',
    '051','부산',
    '052','울산',
    '053','대구',
    '기타')지역
from student;
--instr : 문자열 순번 추출
select name,tel,substr(tel,1,3),instr(tel,')'),
 case substr(tel,1,instr(tel,')')-1)
    when '02' then '서울'
    when '051' then '부산'
    when '052' then '울산'
    when '053' then '대구'
    else '기타'
end 지역
from student;
--case decode
select name, tel, 
    case decode( substr(tel,2,1) , '2', substr(tel,1,2), substr(tel,1,3)) 
        when '02' then '서울'
        when '051' then '부산'
        when '052' then '울산'
        when '053' then '대구'
        else '기타'
    end 지역
from student;

--주민번호 가리기
select name, jumin, rpad(substr(jumin,1,7),length(jumin),'*')주민번호,
substr(jumin,1,7)||'-'||substr(jumin,7)주민번호1
from student;















