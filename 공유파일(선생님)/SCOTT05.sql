--p251(다중행 서브쿼리)-- in, all, any, exits
select ename, sal, job
from emp
where job = 'SALESMAN';

select ename, sal
from emp
where sal in (1600,1250,1500);

select ename, sal
from emp
where sal < any (1600,1250,1500);

select ename, sal
from emp
where sal < any(select sal
                from emp
                where job = 'SALESMAN');

select ename, sal
from emp
where sal < (select max(sal)
                from emp
                where job = 'SALESMAN');
-----
select ename, sal
from emp
where sal < all(select sal
                from emp
                where job = 'SALESMAN');
                
select ename, sal
from emp
where sal < (select min(sal)
                from emp
                where job = 'SALESMAN');
-- emp테이블
--30번 부서  급여
select sal from emp where deptno=30;--1600,1250,2850,1500,950
--30번 부서의 최대급여보다 적은 급여를 받는 사원 출력(any, all 사용)
select *
from emp
where sal < (select  max(sal) from emp where deptno=30);

select *
from emp
where sal < any(select  sal from emp where deptno=30);

select *
from emp
where sal < all(select  sal from emp where deptno=30);

--30번 부서의 최대급여보다 많은 급여를 받는 사원 출력(any, all 사용)
select *
from emp
where sal > (select max(sal) from emp where deptno=30);

select *
from emp
where sal > all(select  sal from emp where deptno=30);

select * from dept;

select *
from dept
where EXISTS (select deptno
                from dept
                where deptno=20);
                
select *
from dept
where EXISTS (select deptno
                from dept
                where deptno=50);
--------
--p266
--DML(조작어:data manipulation language):데이터를 추가,수정,삭제==>데이터조작어(insert, update, delete)
--DDL(data definition language):객체를 생성, 변경, 삭제하는 데이터정의어(create,alter,drop)
--DCL

-- test1(no, name, address, tel)테이블 생성 ==>create table 테이블명(컬럼 정의)
---   숫자(5),문자열(10),문자열(50),문자열(20)
create table test1(
    no number(5),
    name varchar2(10),
    address varchar2(50),
    tel varchar2(20)
);
select * from test1;
select count(*) from test1;
--(no,name) 에 (1,'aaa') 추가 ==> insert into 테이블명(컬럼) values(값)
insert into test1(no,name) values(1,'aaa');
--(2, 'bbb','부산','010-1111-2222') 추가
insert into test1(no, name,address,tel) values(2, 'bbb','부산','010-1111-2222');
--(3, 'ccc','서울','010-3333-4444') 추가
insert into test1(no, name, address, tel) values(3, 'ccc','서울','010-3333-4444');
--(4, 'ddd','대구','010-4444-5555') 추가
insert into test1 values(4, 'ddd','대구','010-4444-5555');
select * from test1;
--(5, 'eee','제주') 추가  
insert into test1(no, name,address) values(5, 'eee','제주');
commit;
--(6, 'ffff','010-6666-7777') 추가 
insert into test1(no, name,tel) values(6, 'ffff','010-6666-7777');
rollback;   
--test1 테이블 no 가 2인 정보출력
select * from test1 where no=2;
--수정==>no=2 인 사람의 이름을 홍길동 수정
update test1
set name = '홍길동'
where no=2;
commit;
-- no가 4인 name을 이순신  /  address 서울로 수정
select * from test1 where no=4;
update test1
set name ='이순신',address = '서울'
where no=4;
--삭제
--test1에서 no=1 삭제
select * from test1;
delete test1 where no=1;
delete from test1 where no=2;
commit;
delete from test1;
rollback;

-- test 테이블 생성(no, name, hiredate)
                --숫자(4), 문자열(20), date
create table test(
    no number(4) default 0,
    name varchar2(20)default 'NONAME',
    hiredate date default sysdate
);
-- test 테이블 에 (1, 홍길동) 추가  
insert into test(no, name) values(1, '홍길동');
select * from test;
-- test 에 25/2/6 추가
insert into test(hiredate) values('25/2/6');
-- test테이블에서 번호가 1번인 사람의 이름을 강감찬 으로 수정
update test
set name = '강감찬'
where no=1;
-- test에서 no = 0 을 삭제
delete from test where no=0;
-- test에서 no=2 추가
insert into test(no) values(2);
select * from test;
commit;
-------------
--CRUD(create, select ,update, delete)
--p266(CTAS:create table as select)
select * from dept;
-- dept_temp 테이블생성 dept테이블 그대로
create table dept_temp
as select * from dept;

select * from dept_temp;
desc dept_temp;
--dept_temp 테이블에 50, DATABASE , SEOUL 추가
insert into dept_temp values(50, 'DATABASE' , 'SEOUL');
commit;
--테이블 구조만 복사
create table emp_temp
as select * from emp
where 1<>1;
select * from emp_temp;
--emp_temp : empno, ename, job, mgr, hiredate, sal, comm, deptno
--(2111,'이순신','MANAGER',9999,'07/01/2019',4000,NULL,20) 추가
insert into emp_temp
values(2111,'이순신','MANAGER',9999,
      to_date('07/01/2019','DD/MM/YYYY'),4000,NULL,20);
describe emp_temp;
select * from emp_temp;

insert into emp_temp(empno,ename,job,mgr,hiredate,sal,deptno)
values(2112,'이순신','MANAGER',9999,
      to_date('07/02/2025','DD/MM/YYYY'),4000,20);
                
insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(2113,'이순신3','MANAGER',9999,
      to_date('06/02/2025','DD/MM/YYYY'),4000,null,20); 
insert into emp_temp
values(3111,'강감찬','MANAGER',9999,sysdate,4000,null,20);
select * from emp_temp;
commit;

--p275
--서브쿼리를 이용해서 한 번에 여러 데이터를 추가(values 사용하지 않는다)
--emp테이블에서 급여가 급여등급(salgrade)이 1(700~1200)사원만 emp_temp 테이블에 추가
select * from emp_temp;
select * from salgrade;
select * from emp where sal between 700 and 1200;

insert into emp_temp
select * from emp
where sal between 700 and 1200;

insert into emp_temp(empno, ename,job, mgr, hiredate, sal ,comm, deptno)
select empno, ename,job, mgr, hiredate, sal ,comm, deptno from emp
where sal between 700 and 1200;
delete from emp_temp; --모든 데이터 삭제
commit;
select * from emp_temp;
-- 급여등급(salgrade)이 3인 사원만  emp_temp 추가
--급여등급(salgrade)이 3인 사원 구하기
select empno,ename, job, mgr,hiredate, sal, comm,deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade = 3;
--emp_temp 추가
insert into emp_temp
select empno,ename, job, mgr,hiredate, sal, comm,deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade = 3;

select * from emp_temp;

--dept 테이블을 복사해서  dept_temp2 테이블을 생성하고
-- 40번 부서명을  DATABASE // 지역은  SEOUL 로 수정
create table dept_temp2
as select * from dept;
select * from dept_temp2;

update dept_temp2
set dname = 'DATABASE', loc='SEOUL'
where deptno=40;
commit;
--dept_temp2  테이블에서 부서번호가 40번인 부서명과 지역을 수정
-- dept 테이블의 40번 부서의 내용을 수정하기
select * from dept where deptno=40;

update dept_temp2
set dname='OPERATIONS', loc='BOSTON'
where deptno=40;

select * from dept_temp2;
rollback;

update dept_temp2
set dname=(select dname from dept where deptno=40) ,
  loc=(select loc from dept where deptno=40)
where deptno=40;

update dept_temp2
set (dname, loc) = (select dname, loc from dept where deptno=40)
where deptno=40;
commit;
--p262 9장 연습문제
--1. 전체 사원 중 ALLEN 과 같은 직책(JOB)인 사원들의 사원정보, 부서정보 출력
--job, empno, ename, sal, deptno, dname 출력
select job, empno, ename, sal, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno
and job = (select job from emp where ename='ALLEN');
            
            
select job, empno, ename, sal, e.deptno, dname
from emp e join  dept d  on  e.deptno = d.deptno
where job = (select job from emp where ename='ALLEN');

select job, empno, ename, sal, deptno, dname
from emp e NATURAL join  dept d 
where job = (select job from emp where ename='ALLEN');

select job, empno, ename, sal, deptno, dname
from emp e  join  dept d using(deptno)
where job = (select job from emp where ename='ALLEN');
--2.전체 사원의 평균 급여보다 
--높은 급여를 받는 사원들의 사원정보, 부서정보, 급여 등급 정보 출력
select empno,ename, dname, hiredate,loc, sal, grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno and e.sal between s.losal and s.hisal
and sal > (select avg(sal) from emp)
order by empno;

select empno,ename, dname, hiredate,loc, sal, grade
from emp e join  dept d on e.deptno=d.deptno
           join  salgrade s on  e.sal between s.losal and s.hisal
where sal > (select avg(sal) from emp)
order by empno;
--3. 10번 부서에 근무하는 사원 중
-- 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보 부서정보 출력
select empno, ename, job, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno
and e.deptno= 10
and job not  in (select  job from emp where deptno=30);

select empno, ename, job, e.deptno, dname, loc
from emp e join dept d on e.deptno =  d.deptno
where e.deptno= 10 and job not  in (select  job from emp where deptno=30);

select  job from emp where deptno=30;
--4.직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 
--사원정보, 급여등급정보( 사원번호로 오름차순)
-- 다중행 함수를 사용하지 않는 방법
select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > (select max(sal) from emp where job = 'SALESMAN')
order by empno;
--다중행 함수 사용

select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal -- all 은 전부 다 커야 true
and sal > all(select sal from emp where job = 'SALESMAN') 
order by empno;

select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal -- any 은 1250 보다 크면  true
and sal > any(select sal from emp where job = 'SALESMAN')
order by empno;

--p287  10장 연습문제
create table CHAP10HW_EMP  as select * from emp;
create table CHAP10HW_DEPT  as select * from dept;
create table CHAP10HW_salgrade  as select * from salgrade;
--1.
select * from CHAP10HW_DEPT;
insert into CHAP10HW_DEPT(deptno, dname, loc) values(50, 'ORACLE','BUSAN');
insert into CHAP10HW_DEPT(deptno, dname, loc) values(60, 'SQL','BUSAN');
insert into CHAP10HW_DEPT(deptno, dname, loc) values(70, 'SELECT','INCHEON');
insert into CHAP10HW_DEPT(deptno, dname, loc) values(80, 'DML','BUNDANG');
commit;
--2.
INSERT INTO CHAP10HW_EMP
VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016-01-02', 'YYYY-MM-DD'), 4500, NULL, 50);
INSERT INTO CHAP10HW_EMP
VALUES(7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016-02-21', 'YYYY-MM-DD'), 1800, NULL, 50);
INSERT INTO CHAP10HW_EMP
VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016-04-11', 'YYYY-MM-DD'), 3400, NULL, 60);
INSERT INTO CHAP10HW_EMP
VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016-05-31', 'YYYY-MM-DD'), 2700, 300, 60);
INSERT INTO CHAP10HW_EMP
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016-07-20', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016-09-08', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016-10-28', 'YYYY-MM-DD'), 2300, NULL, 80);
 
INSERT INTO CHAP10HW_EMP
VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2018-03-09', 'YYYY-MM-DD'), 1200, NULL, 80);
commit;
select * from CHAP10HW_EMP;
--3. CHAP10HW_EMP 에 속한 사원 중 
-- 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을
-- 70번 부서로 옮기기
select avg(sal) from CHAP10HW_EMP where deptno = 50;  --3150
update CHAP10HW_EMP
set deptno = 70
where sal > 3150;

update CHAP10HW_EMP
set deptno = 70
where sal > (select avg(sal) from CHAP10HW_EMP where deptno = 50);
commit;
select * from CHAP10HW_EMP;
--4. CHAP10HW_EMP 에 속한 사원 중
--60번 부서의 사원 중에 입사일이 가장 빠른 사원보다 늦게 입사한 
-- 사원의 급여를 10% 인상하고 80번 부서로  옮기기
select min(hiredate) from CHAP10HW_EMP where deptno = 60; --16/05/31

update CHAP10HW_EMP
set sal = sal*1.1, deptno = 80
where hiredate > '16/05/31';

update CHAP10HW_EMP
set sal = sal*1.1, deptno = 80
where hiredate > (select min(hiredate) from CHAP10HW_EMP where deptno = 60);
commit;
select * from CHAP10HW_EMP;

--5. CHAP10HW_EMP에 속한 사원 중 급여 등급이 5인 사원을 삭제한는 SQL
select * from CHAP10HW_EMP;
select *
from CHAP10HW_EMP e,  CHAP10HW_SALGRADE s
where e.sal between s.losal and s.hisal and grade = 5;  -- 5000,4500,3400
-- 삭제
delete from CHAP10HW_EMP
where sal in (5000,4500,3400);
rollback;

delete from CHAP10HW_EMP
where sal in (select sal
            from CHAP10HW_EMP e,  CHAP10HW_SALGRADE s
            where  e.sal between s.losal and s.hisal and grade = 5);
commit;
select * from CHAP10HW_EMP;
---------------------------------
--dept_temp2 모든 데이터 삭제
select * from dept_temp2;
delete from dept_temp2;
commit;
----dept_temp2 테이블 삭제
drop table  dept_temp2;
-- 오류발생(테이블 삭제 되어서)
--select * from dept_temp2
--dept_temp 테이블 삭제
drop table dept_temp;
--emp_temp 테이블 삭제
drop table emp_temp;

--- dept 테이블을 이용해서  dept_temp 테이블 생성
create table dept_temp
as select * from dept;

select * from dept_temp;
--LOCATION   컬럼 추가
alter table dept_temp add(LOCATION varchar2(30));
--10번 부서의 LOCATION 을 뉴욕으로 수정
update dept_temp
set LOCATION = '뉴욕'
where deptno = 10;
-- LOCATION   컬럼 수정 : varchar2(70)
alter table dept_temp modify(LOCATION  varchar2(70));
describe dept_temp;
-- LOCATION   컬럼 삭제
alter table dept_temp drop column LOCATION;
-- LOC 컬럼명을 LOCATION 변경
alter table dept_temp rename column LOC to LOCATION;
describe dept_temp;
--테이블 이름 변경 dept_temp ==> dept_temptemp
alter table dept_temp rename to dept_temptemp;
describe dept_temptemp;
rename dept_temptemp to dept_temp;

-- dept_temp 데이터 모두 삭제
delete from dept_temp;
select * from dept_temp;
--취소
rollback; --데이터 원상 복귀
-- dept_temp 데이터 모두 삭제(truncate :DDL이므로 rollback 적용되지 않아 복구 안됨)
truncate table dept_temp;
select * from dept_temp;
--취소
rollback; --  rollback   해도 데이터 복구 안됨
select * from dept_temp;
-- dept_temp 테이블삭제
drop table dept_temp;
--오류 발생
--select * from dept_temp;
----------------
select * from test1;
--1.컬럼 추가 :  birthday date 형 
alter table test1 add (birthday date) ;
describe test1;
--2.컬럼 명 수정 : tel => phone 
alter table test1 rename column tel to phone;
--3 no 컬럼을 삭제
alter table test1 drop column no;

--4. num 컬럼 추가 : number(3)
alter table test1 add(num number(3));
--5. address 문자열(50)==> 문자열(70) 변경
alter table test1 modify (address varchar2(70));
describe test1;
--6. test1 테이블 이름을 ==> testtest
alter table test1 rename to testtest;
select * from testtest;
rename testtest to test2;
select * from test2;
--테이블 삭제
drop table test2;
---오류발생(테이블 삭제)
--select * from test2;



