--p125~126연습문제
--1.Emp 테이블에서 사원이름(ename)이 S로 끝나는 사원의 정보 출력
select * from emp;
select  *
from emp
where ename like '%S';

--2. Emp 테이블에서 30번 부서 중 직책(job)이 SALESMAN 인 
--사원번호(empno), 이름(ename) , 직책(job), 급여(sal), 부서번호(deptno)
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN';

--3.20번, 30번 부서에 근무하면서 급여가 2000 초과하는 사원의
-- 사원번호(empno), 이름(ename) , 직책(job), 급여(sal), 부서번호(deptno)
--1) 집합연산자 사용(UNION)
select empno, ename, job, sal,deptno
from emp
where deptno = 20 and sal > =2000
UNION
select empno, ename, job, sal,deptno
from emp
where deptno = 30 and sal > =2000;

--2) 집합연산자 미사용
select empno, ename, job, sal,deptno
from emp
where deptno in (20,30) and sal > =2000;
--4.급여가 2000이상 3000 이하 범위 이외  not between a and b 사용하지 않기
select *
from emp
where sal <2000 or sal>3000;

select *
from emp
where sal NOT BETWEEN 2000 and 3000;

--5.사원이름에 E 가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가
--아닌 사원이름, 사원번호, 급여, 부서번호 출력
select ename, empno, sal, deptno
from emp
where ename like '%E%'
    and deptno = 30 
    and sal NOT  between 2000 and 3000;

--6. 추가수당(comm) 존재 하지 않고 상급자(mgr) 있고 job 이 MANAGER CLERK 중에서 
--사원이름의 두번 째 글자 L 아닌 정보 출력
select *
from emp
where comm is null 
    and mgr is not null
    and job in ('MANAGER','CLERK')
    and ename NOT like '_L%';
---------------------
select *  from emp;
--1. 문자열 연결(concat함수) 
select concat(ename, job)
from emp;

--concat함수 ename:job 예) SMITH:CLERK
select concat(ename, ':'),
       concat(concat(ename, ':'),job),
       concat(ename,concat(':', job))
from emp;

-- p142 문자열 연결 ||
select ename || ':' || job as  이름_직업
from emp;
--공백제거
select '    oracle   ', length('    oracle   '),
  TRIM('    oracle   '),length(TRIM('    oracle   ')) trim길이,
  LTRIM('    oracle   '),length(LTRIM('    oracle   ')) LTRIM길이,
  RTRIM('    oracle   '),length(RTRIM('    oracle   ')) RTRIM길이
from dual;

------ 숫자
-- round(반올림)
select 123.567, round(123.567,1), round(123.567,2),
     round(123.567, -1), round(123.567),round(123.567, 0)
from dual;
--trunc(버림)
select 15.793 , trunc(15.793,1),trunc(15.793,2),
       trunc(15.793,-1),trunc(15.793)
from dual;
-- ceil , floor 가장 가까운 큰 정수, 가장 가까운 작은 정수 반환
select 3.14 , ceil(3.14), floor(3.14),trunc(3.14),
             ceil(-3.14), floor(-3.14),trunc(-3.14)
from dual;
select power(2,3) from dual;
--나머지
select mod(15,6) from dual;

---날짜관련 함수
select sysdate 오늘, sysdate+1 내일,sysdate -1  어제, sysdate+3
from dual;
--3개월 뒤
select sysdate, add_months(sysdate,3),add_months('22/05/01',3)
from dual;
--emp 테이블에서 사원번호(empno), 이름(ename), 입사일(hiredate), 
-- 입사 10년 후(입사10년후) 날짜 출력
select empno, ename, hiredate,add_months(hiredate,120) 입사10년후
from emp;

select months_between(sysdate, '24/01/24')
from dual;
-- emp 테이블 이름(ename),입사일(hiredate), 근무개월수 (현재-입사일)
-- 소수 첫째자리까지 표현(trunc 사용)
select ename, hiredate,months_between(sysdate,hiredate)근무개월수,
     trunc(months_between(sysdate,hiredate),1) 근무개월수1,
     trunc(months_between(hiredate,sysdate),1) 근무개월수1
from emp;
--근무개월 수를 출력하는데 '개월' 글자 출력 , 소수점 이하는 버림 ==>예)529개월
--이름, 근무개월수 출력
--concat(A,B)함수 사용
select ename, trunc(months_between(sysdate, hiredate)) 근무개월수,
     concat(trunc(months_between(sysdate, hiredate)),'개월')  근무개월수1
from emp;
--  || 사용
select ename , trunc(months_between(sysdate, hiredate))||'개월' 근무개월
from emp;
---
select sysdate,next_day(sysdate,'월요일') 월요일, 
       next_day(sysdate,'토요일') 토요일,
       last_day(sysdate) 마지막날,
       last_day('24/07/01')
from dual;
--사원번호(empno)가 짝수인 사원의 사원번호(empno), 이름(ename) ,직급(job) 출력
select empno, ename, job
from emp
where mod(empno,2)=0;
-- 급여(sal)가 1500에서 3000사이의 사원은 그 급여의 15%(0.15)를 회비로 지불
-- 이름(ename), 급여(sal), 회비(반올림), 출력
select ename, sal, round(sal*0.15)  회비
from emp
where sal >=1500 and sal<=3000;

select ename, sal, round(sal*0.15)  회비
from emp
where sal BETWEEN 1500 and 3000;

---p157 형변환함수
describe emp;
 -- empno(숫자)+ '500'(문자)==> 숫자 7369+500 = 7869(500 ->숫자)
select empno, ename, empno+'500'  
from emp;
-- empno(숫자)+ 'ABCD'(문자)==> 숫자 7369+ABCD ==> 오류발생
--select empno, ename, empno+'ABCD'  
--from emp;

--select empno, ename, 'ABCD'+empno
--from emp;
----------
select sysdate from dual;
select  to_char(sysdate, 'YYYY/MM/DD  HH24:MI:SS')    현재날짜시간
from dual;

select to_char(sysdate,'MM')월 from dual;
select to_char(sysdate,'DD')일 from dual;
select to_char(sysdate,'HH')시 from dual;
select to_char(sysdate,'MI')분 from dual;
select to_char(sysdate,'SS')초 from dual;
select to_char(sysdate,'MON') 월 from dual;
select to_char(sysdate,'MONTH') 월 from dual;
select to_char(sysdate,'day')  요일 from dual;
select to_char(sysdate,'DAY')  요일 from dual;
--입사일이 1,2,3 월인 사원의 번호(empno), 이름(ename), 입사일(hiredate) 출력
select empno,ename, hiredate, to_char(hiredate, 'MM')
from emp
where  to_char(hiredate, 'MM') in (1,2,3);

select empno,ename, hiredate, to_char(hiredate, 'MM')
from emp
where  to_char(hiredate, 'MM') between 1 and 3;

select empno,ename, hiredate, to_char(hiredate, 'MM')
from emp
where  to_char(hiredate, 'MM') between '01' and '03';

select sal, to_char(sal,'$999,999') sal_$,
            to_char(sal,'L999,999') sal_L,
            to_char(sal,'999,999') sal_9,
            to_char(sal,'000,999') sal_0
from emp;

select 1300-1500 from dual;
--오류발생
--select '1300'-'1500' from dual;
select to_number('1300')-to_number('1500') from dual;
select to_number('1,300','999,999')
from dual;
--오류발생
--select to_number('1,300')-to_number('1,500') from dual;
select to_number('1,300','999,999')-to_number('1,500','999,999')
from dual;

---p164
--  '20240727'  문자 ===> 날짜형
select to_date('20240727') as str_date
from dual;
select to_date('20240727','YYYY-MM-DD') as str_date
from dual;
--81/12/03 이후 입사한 사원 출력
select * from emp;
select *
from emp
where hiredate > '81/12/03';

desc emp;

select *
from emp
where hiredate > to_date('81/12/03');

select *
from emp
where hiredate > to_date('81/12/03','RR/MM/DD');
----------------
-- null
--사번(empno), 이름(enam),급여(sal), 커미션(comm), 급여+커미션(sal+comm) 출력
select empno, ename, sal, comm, sal+comm 수입, 
     nvl(comm, 0), sal+nvl(comm,0) 실제수입
from emp;

--사번(empno), 이름(enam),급여(sal), 커미션(comm), 급여+커미션(sal+comm) 수입
-- 수입을 천단위로 구분하여 출력
select empno, ename, sal, comm,
       sal*12+nvl(comm,0) 연봉, 
       to_char(sal*12+nvl(comm,0), '999,999') 연봉1
from emp;
--comm  을 받으면 O  , 받지 않으면  X 로 출력
select empno, ename, comm , nvl2(comm,'O','X') comm유무
from emp;
--nvl2 사용하여  연봉 출력(sal*12+comm)
-- empno, ename, sal, comm, 연봉(sal*12+comm)
select empno, ename, sal, comm,nvl2(comm,sal*12+comm, sal*12) 연봉,
   to_char(nvl2(comm,sal*12+comm, sal*12),'999,999')연봉1
from emp;

select empno, ename, sal, comm,nvl2(comm,sal*12+comm, sal*12) 연봉
from emp;

select empno, ename, sal, comm,
    nvl2(sal*12+comm,sal*12+comm, sal*12) 연봉
from emp;

select empno, ename, sal, comm, sal*12+nvl2(comm,comm,0) 연봉
from emp;


--nvl 사용
select empno, ename, sal, comm,sal*12+nvl(comm,0) 연봉,
   to_char(sal*12+nvl(comm,0),'999,999')연봉1
from emp;

select * from emp;
--empno, ename, mgr 출력 / mgr이 null 이면 'CEO' 출력
select empno, ename, mgr, nvl(to_char(mgr),'CEO'),
 nvl2(to_char(mgr),to_char(mgr),'CEO'),
 nvl2(mgr,to_char(mgr),'CEO')
from emp;
--empno, ename, mgr 출력 / mgr이 null 이면 9999 출력
select empno, ename, mgr, nvl(mgr, 9999)
from emp; 
-------------
--p170
--job에 따라 급여 다르게  인상
-- MANAGER 1.5  /SALESMAN 1.2 / ANALST 1.05  / 1.04
--decode
select empno, ename, job,sal,
  decode(job, 'MANAGER', sal*1.5,
              'SALESMAN',sal*1.2,
              'ANALST', sal*1.05,
              sal*1.04) 인상급여
from emp;
-- case when  ~~~ then ~~end
select empno, ename, job,sal,
   case job
       when 'MANAGER' then sal*1.5
       when 'SALESMAN' then sal*1.2
       when 'ANALST' then sal*1.05
       else sal*1.04
   end as 인상급여    
from emp;

select empno, ename, job,sal,
   case 
       when job = 'MANAGER' then sal*1.5
       when job ='SALESMAN' then sal*1.2
       when job = 'ANALST' then sal*1.05
       else sal*1.04
   end  인상급여    
from emp;
----
-- comm 이 null 이면  해당사항 없음, comm= 0 이면 수당없음
-- comm  이 있으면 수당(예: comm 이 50 이면   수당:50)
-- empno, ename, comm, comm_txt 출력
-- decode 사용
select empno, ename, comm,
    decode(comm, null ,'해당사항 없음',
                0 , '수당없음',
                '수당 :' ||comm
    ) comm_txt
from emp;

select empno, ename, comm,
    decode(comm, null ,'해당사항 없음',
                0 , '수당없음',
                concat('수당 :',comm)
    ) comm_txt
from emp;
-- case when ~ then 사용
select empno, ename, comm,
case 
    when comm is null then '해당 사항 없음'
    when comm = 0 then '수당없음'
    when comm > 0 then '수당:'||comm
end comm_txt
from emp;
-----
--professor  테이블
 select * from professor;
--1. professor  테이블 교수명(name)과 학과번호(deptno), 학과명 출력
-- deptno = 101 면 '컴퓨터공학과'

--case
select name, deptno,
  case 
    when deptno= 101  then '컴퓨터공학과'
  end  학과명
from professor;

--decode
select name, deptno, decode(deptno, 101, '컴퓨터 공학과') 학과명
from professor;

--2. professor  테이블 교수명(name)과 학과번호(deptno), 학과명 출력
-- deptno = 101 면 '컴퓨터공학과' 나머지 학과는 기타  출력
--case
select name, deptno,
  case 
    when deptno= 101  then '컴퓨터공학과'
    else '기타'
  end  학과명
from professor;

--decode
select name, deptno,
   decode(deptno , 101, '컴퓨터공학과','기타') 학과명
from professor;

-- 3. professor  테이블 교수명(name)과 학과번호(deptno), 학과명 출력
-- deptno = 101 면 '컴퓨터공학과' / 102면 멀티미디어공학과
-- 201면 소프트웨어공학과 / 나머지 학과는 기타  출력
--case
select name, deptno,
    case deptno
        when 101 then '컴퓨터공학과'
        when 102 then '멀티미디어공학과'
        when 201 then '소프트웨어공학과'
        else '기타'
    end  학과명
from professor;

--decode
select name, deptno,
  decode(deptno, 101, '컴퓨터공학과',
                 102, '멀티미디어공학과',
                 201,'소프트웨어 공학',
                 '기타')학과명
from professor;
----student 테이블
select * from student;
-- 학생을 3개 팀으로 분류하기 위해 학번(studno)을 3으로 나누어
-- 나머지가 0 이면 A팀, 1 이면 B팀, 2이면 C팀
--학생번호(studno),이름(name), 학과번호(deptno1), 팀이름  출력
--case
select studno, name, deptno1,
    case mod(studno,3)
      when  0  then 'A팀'
      when  1  then 'B팀'
      when  2  then 'C팀'
    end 팀이름
from student
order by 팀이름;

--decode
select studno, name, deptno1,
  decode(mod(studno,3), 0 , 'A', 1,'B',2,'C')팀이름
from  student; 

---
select * from student;
select jumin from student;
--1. 학생테이블에서 jumin 7 번째가 1이면  남자, 2이면  여자
-- 학번(studno), 이름(name),주민(jumin), 성별
select studno, name, jumin,
 case substr(jumin,7,1) 
   when '1' then '남자'
   when '2' then '여자'
 end 성별
from student;

select studno, name, jumin,
 case  
   when substr(jumin,7,1) = '1' then '남자'
   when substr(jumin,7,1) = '2' then '여자'
 end 성별
from student;

select studno, name, jumin,
  decode(substr(jumin,7,1),'1', '남자','2','여자') 성별
from student;
--2.tel의 지역변호에서 02 서울, 051 부산, 052 울산, 053 대구
-- 나머지는 기타로 출력
-- 이름, 전화번호, 지역 출력
select * from student;
--case when
select name, tel,substr(tel,1,3),instr(tel,')'),
 case substr(tel,1,instr(tel,')')-1)
  when '02' then '서울'
  when '051' then '부산'
  when '052' then '울산'
  when '053' then '대구'
  else '기타'
 end  지역 
from student;
--decode
select name, tel, 
    decode(substr(tel,1,instr(tel,')')-1),'02','서울',
                                           '051','부산',
                                           '052','울산',
                                           '053','대구',
                                           '기타') 지역
from student;
select name, jumin,rpad(substr(jumin,1,7),length(jumin),'*')주민번호,
substr(jumin,1,7)||'-'||substr(jumin,7)주민번호1
from student;


















--p125~126연습문제
--1.Emp 테이블에서 사원이름(ename)이 S로 끝나는 사원의 정보 출력
select * from emp;
select  *
from emp
where ename like '%S';

--2. Emp 테이블에서 30번 부서 중 직책(job)이 SALESMAN 인 
--사원번호(empno), 이름(ename) , 직책(job), 급여(sal), 부서번호(deptno)
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN';

--3.20번, 30번 부서에 근무하면서 급여가 2000 초과하는 사원의
-- 사원번호(empno), 이름(ename) , 직책(job), 급여(sal), 부서번호(deptno)
--1) 집합연산자 사용(UNION)
select empno, ename, job, sal,deptno
from emp
where deptno = 20 and sal > =2000
UNION
select empno, ename, job, sal,deptno
from emp
where deptno = 30 and sal > =2000;

--2) 집합연산자 미사용
select empno, ename, job, sal,deptno
from emp
where deptno in (20,30) and sal > =2000;
--4.급여가 2000이상 3000 이하 범위 이외  not between a and b 사용하지 않기
select *
from emp
where sal <2000 or sal>3000;

select *
from emp
where sal NOT BETWEEN 2000 and 3000;

--5.사원이름에 E 가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가
--아닌 사원이름, 사원번호, 급여, 부서번호 출력
select ename, empno, sal, deptno
from emp
where ename like '%E%'
    and deptno = 30 
    and sal NOT  between 2000 and 3000;

--6. 추가수당(comm) 존재 하지 않고 상급자(mgr) 있고 job 이 MANAGER CLERK 중에서 
--사원이름의 두번 째 글자 L 아닌 정보 출력
select *
from emp
where comm is null 
    and mgr is not null
    and job in ('MANAGER','CLERK')
    and ename NOT like '_L%';
---------------------
select *  from emp;
--1. 문자열 연결(concat함수) 
select concat(ename, job)
from emp;

--concat함수 ename:job 예) SMITH:CLERK
select concat(ename, ':'),
       concat(concat(ename, ':'),job),
       concat(ename,concat(':', job))
from emp;

-- p142 문자열 연결 ||
select ename || ':' || job as  이름_직업
from emp;
--공백제거
select '    oracle   ', length('    oracle   '),
  TRIM('    oracle   '),length(TRIM('    oracle   ')) trim길이,
  LTRIM('    oracle   '),length(LTRIM('    oracle   ')) LTRIM길이,
  RTRIM('    oracle   '),length(RTRIM('    oracle   ')) RTRIM길이
from dual;

------ 숫자
-- round(반올림)
select 123.567, round(123.567,1), round(123.567,2),
     round(123.567, -1), round(123.567),round(123.567, 0)
from dual;
--trunc(버림)
select 15.793 , trunc(15.793,1),trunc(15.793,2),
       trunc(15.793,-1),trunc(15.793)
from dual;
-- ceil , floor 가장 가까운 큰 정수, 가장 가까운 작은 정수 반환
select 3.14 , ceil(3.14), floor(3.14),trunc(3.14),
             ceil(-3.14), floor(-3.14),trunc(-3.14)
from dual;
select power(2,3) from dual;
--나머지
select mod(15,6) from dual;

---날짜관련 함수
select sysdate 오늘, sysdate+1 내일,sysdate -1  어제, sysdate+3
from dual;
--3개월 뒤
select sysdate, add_months(sysdate,3),add_months('22/05/01',3)
from dual;
--emp 테이블에서 사원번호(empno), 이름(ename), 입사일(hiredate), 
-- 입사 10년 후(입사10년후) 날짜 출력
select empno, ename, hiredate,add_months(hiredate,120) 입사10년후
from emp;

select months_between(sysdate, '24/01/24')
from dual;
-- emp 테이블 이름(ename),입사일(hiredate), 근무개월수 (현재-입사일)
-- 소수 첫째자리까지 표현(trunc 사용)
select ename, hiredate,months_between(sysdate,hiredate)근무개월수,
     trunc(months_between(sysdate,hiredate),1) 근무개월수1,
     trunc(months_between(hiredate,sysdate),1) 근무개월수1
from emp;
--근무개월 수를 출력하는데 '개월' 글자 출력 , 소수점 이하는 버림 ==>예)529개월
--이름, 근무개월수 출력
--concat(A,B)함수 사용
select ename, trunc(months_between(sysdate, hiredate)) 근무개월수,
     concat(trunc(months_between(sysdate, hiredate)),'개월')  근무개월수1
from emp;
--  || 사용
select ename , trunc(months_between(sysdate, hiredate))||'개월' 근무개월
from emp;
---
select sysdate,next_day(sysdate,'월요일') 월요일, 
       next_day(sysdate,'토요일') 토요일,
       last_day(sysdate) 마지막날,
       last_day('24/07/01')
from dual;
--사원번호(empno)가 짝수인 사원의 사원번호(empno), 이름(ename) ,직급(job) 출력
select empno, ename, job
from emp
where mod(empno,2)=0;
-- 급여(sal)가 1500에서 3000사이의 사원은 그 급여의 15%(0.15)를 회비로 지불
-- 이름(ename), 급여(sal), 회비(반올림), 출력
select ename, sal, round(sal*0.15)  회비
from emp
where sal >=1500 and sal<=3000;

select ename, sal, round(sal*0.15)  회비
from emp
where sal BETWEEN 1500 and 3000;

---p157 형변환함수
describe emp;
 -- empno(숫자)+ '500'(문자)==> 숫자 7369+500 = 7869(500 ->숫자)
select empno, ename, empno+'500'  
from emp;
-- empno(숫자)+ 'ABCD'(문자)==> 숫자 7369+ABCD ==> 오류발생
--select empno, ename, empno+'ABCD'  
--from emp;

--select empno, ename, 'ABCD'+empno
--from emp;
----------
select sysdate from dual;
select  to_char(sysdate, 'YYYY/MM/DD  HH24:MI:SS')    현재날짜시간
from dual;

select to_char(sysdate,'MM')월 from dual;
select to_char(sysdate,'DD')일 from dual;
select to_char(sysdate,'HH')시 from dual;
select to_char(sysdate,'MI')분 from dual;
select to_char(sysdate,'SS')초 from dual;
select to_char(sysdate,'MON') 월 from dual;
select to_char(sysdate,'MONTH') 월 from dual;
select to_char(sysdate,'day')  요일 from dual;
select to_char(sysdate,'DAY')  요일 from dual;
--입사일이 1,2,3 월인 사원의 번호(empno), 이름(ename), 입사일(hiredate) 출력
select empno,ename, hiredate, to_char(hiredate, 'MM')
from emp
where  to_char(hiredate, 'MM') in (1,2,3);

select empno,ename, hiredate, to_char(hiredate, 'MM')
from emp
where  to_char(hiredate, 'MM') between 1 and 3;

select empno,ename, hiredate, to_char(hiredate, 'MM')
from emp
where  to_char(hiredate, 'MM') between '01' and '03';

select sal, to_char(sal,'$999,999') sal_$,
            to_char(sal,'L999,999') sal_L,
            to_char(sal,'999,999') sal_9,
            to_char(sal,'000,999') sal_0
from emp;

select 1300-1500 from dual;
--오류발생
--select '1300'-'1500' from dual;
select to_number('1300')-to_number('1500') from dual;
select to_number('1,300','999,999')
from dual;
--오류발생
--select to_number('1,300')-to_number('1,500') from dual;
select to_number('1,300','999,999')-to_number('1,500','999,999')
from dual;

---p164
--  '20240727'  문자 ===> 날짜형
select to_date('20240727') as str_date
from dual;
select to_date('20240727','YYYY-MM-DD') as str_date
from dual;
--81/12/03 이후 입사한 사원 출력
select * from emp;
select *
from emp
where hiredate > '81/12/03';

desc emp;

select *
from emp
where hiredate > to_date('81/12/03');

select *
from emp
where hiredate > to_date('81/12/03','RR/MM/DD');
----------------
-- null
--사번(empno), 이름(enam),급여(sal), 커미션(comm), 급여+커미션(sal+comm) 출력
select empno, ename, sal, comm, sal+comm 수입, 
     nvl(comm, 0), sal+nvl(comm,0) 실제수입
from emp;

--사번(empno), 이름(enam),급여(sal), 커미션(comm), 급여+커미션(sal+comm) 수입
-- 수입을 천단위로 구분하여 출력
select empno, ename, sal, comm,
       sal*12+nvl(comm,0) 연봉, 
       to_char(sal*12+nvl(comm,0), '999,999') 연봉1
from emp;
--comm  을 받으면 O  , 받지 않으면  X 로 출력
select empno, ename, comm , nvl2(comm,'O','X') comm유무
from emp;
--nvl2 사용하여  연봉 출력(sal*12+comm)
-- empno, ename, sal, comm, 연봉(sal*12+comm)
select empno, ename, sal, comm,nvl2(comm,sal*12+comm, sal*12) 연봉,
   to_char(nvl2(comm,sal*12+comm, sal*12),'999,999')연봉1
from emp;

select empno, ename, sal, comm,nvl2(comm,sal*12+comm, sal*12) 연봉
from emp;

select empno, ename, sal, comm,
    nvl2(sal*12+comm,sal*12+comm, sal*12) 연봉
from emp;

select empno, ename, sal, comm, sal*12+nvl2(comm,comm,0) 연봉
from emp;


--nvl 사용
select empno, ename, sal, comm,sal*12+nvl(comm,0) 연봉,
   to_char(sal*12+nvl(comm,0),'999,999')연봉1
from emp;

select * from emp;
--empno, ename, mgr 출력 / mgr이 null 이면 'CEO' 출력
select empno, ename, mgr, nvl(to_char(mgr),'CEO'),
 nvl2(to_char(mgr),to_char(mgr),'CEO'),
 nvl2(mgr,to_char(mgr),'CEO')
from emp;
--empno, ename, mgr 출력 / mgr이 null 이면 9999 출력
select empno, ename, mgr, nvl(mgr, 9999)
from emp; 
-------------
--p170
--job에 따라 급여 다르게  인상
-- MANAGER 1.5  /SALESMAN 1.2 / ANALST 1.05  / 1.04
--decode
select empno, ename, job,sal,
  decode(job, 'MANAGER', sal*1.5,
              'SALESMAN',sal*1.2,
              'ANALST', sal*1.05,
              sal*1.04) 인상급여
from emp;
-- case when  ~~~ then ~~end
select empno, ename, job,sal,
   case job
       when 'MANAGER' then sal*1.5
       when 'SALESMAN' then sal*1.2
       when 'ANALST' then sal*1.05
       else sal*1.04
   end as 인상급여    
from emp;

select empno, ename, job,sal,
   case 
       when job = 'MANAGER' then sal*1.5
       when job ='SALESMAN' then sal*1.2
       when job = 'ANALST' then sal*1.05
       else sal*1.04
   end  인상급여    
from emp;
----
-- comm 이 null 이면  해당사항 없음, comm= 0 이면 수당없음
-- comm  이 있으면 수당(예: comm 이 50 이면   수당:50)
-- empno, ename, comm, comm_txt 출력
-- decode 사용
select empno, ename, comm,
    decode(comm, null ,'해당사항 없음',
                0 , '수당없음',
                '수당 :' ||comm
    ) comm_txt
from emp;

select empno, ename, comm,
    decode(comm, null ,'해당사항 없음',
                0 , '수당없음',
                concat('수당 :',comm)
    ) comm_txt
from emp;
-- case when ~ then 사용
select empno, ename, comm,
case 
    when comm is null then '해당 사항 없음'
    when comm = 0 then '수당없음'
    when comm > 0 then '수당:'||comm
end comm_txt
from emp;
-----
--professor  테이블
 select * from professor;
--1. professor  테이블 교수명(name)과 학과번호(deptno), 학과명 출력
-- deptno = 101 면 '컴퓨터공학과'

--case
select name, deptno,
  case 
    when deptno= 101  then '컴퓨터공학과'
  end  학과명
from professor;

--decode
select name, deptno, decode(deptno, 101, '컴퓨터 공학과') 학과명
from professor;

--2. professor  테이블 교수명(name)과 학과번호(deptno), 학과명 출력
-- deptno = 101 면 '컴퓨터공학과' 나머지 학과는 기타  출력
--case
select name, deptno,
  case 
    when deptno= 101  then '컴퓨터공학과'
    else '기타'
  end  학과명
from professor;

--decode
select name, deptno,
   decode(deptno , 101, '컴퓨터공학과','기타') 학과명
from professor;

-- 3. professor  테이블 교수명(name)과 학과번호(deptno), 학과명 출력
-- deptno = 101 면 '컴퓨터공학과' / 102면 멀티미디어공학과
-- 201면 소프트웨어공학과 / 나머지 학과는 기타  출력
--case
select name, deptno,
    case deptno
        when 101 then '컴퓨터공학과'
        when 102 then '멀티미디어공학과'
        when 201 then '소프트웨어공학과'
        else '기타'
    end  학과명
from professor;

--decode
select name, deptno,
  decode(deptno, 101, '컴퓨터공학과',
                 102, '멀티미디어공학과',
                 201,'소프트웨어 공학',
                 '기타')학과명
from professor;
----student 테이블
select * from student;
-- 학생을 3개 팀으로 분류하기 위해 학번(studno)을 3으로 나누어
-- 나머지가 0 이면 A팀, 1 이면 B팀, 2이면 C팀
--학생번호(studno),이름(name), 학과번호(deptno1), 팀이름  출력
--case
select studno, name, deptno1,
    case mod(studno,3)
      when  0  then 'A팀'
      when  1  then 'B팀'
      when  2  then 'C팀'
    end 팀이름
from student
order by 팀이름;

--decode
select studno, name, deptno1,
  decode(mod(studno,3), 0 , 'A', 1,'B',2,'C')팀이름
from  student; 

---
select * from student;
select jumin from student;
--1. 학생테이블에서 jumin 7 번째가 1이면  남자, 2이면  여자
-- 학번(studno), 이름(name),주민(jumin), 성별
select studno, name, jumin,
 case substr(jumin,7,1) 
   when '1' then '남자'
   when '2' then '여자'
 end 성별
from student;

select studno, name, jumin,
 case  
   when substr(jumin,7,1) = '1' then '남자'
   when substr(jumin,7,1) = '2' then '여자'
 end 성별
from student;

select studno, name, jumin,
  decode(substr(jumin,7,1),'1', '남자','2','여자') 성별
from student;
--2.tel의 지역변호에서 02 서울, 051 부산, 052 울산, 053 대구
-- 나머지는 기타로 출력
-- 이름, 전화번호, 지역 출력
select * from student;
--case when
select name, tel,substr(tel,1,3),instr(tel,')'),
 case substr(tel,1,instr(tel,')')-1)
  when '02' then '서울'
  when '051' then '부산'
  when '052' then '울산'
  when '053' then '대구'
  else '기타'
 end  지역 
from student;
--decode
select name, tel, 
    decode(substr(tel,1,instr(tel,')')-1),'02','서울',
                                           '051','부산',
                                           '052','울산',
                                           '053','대구',
                                           '기타') 지역
from student;
select name, jumin,rpad(substr(jumin,1,7),length(jumin),'*')주민번호,
substr(jumin,1,7)||'-'||substr(jumin,7)주민번호1
from student;


















