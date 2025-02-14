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
