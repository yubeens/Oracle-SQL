--p.251(다중행 서브쿼리)--in, all, any, exits
-- in : 메인쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있다면 true
-- in() 은 괄호안 조건이랑 똑같은 값들을 출력

-- any,some : 메인쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 true
-- any()는 괄호안 조건들중에 하나라도 만족하면 출력

-- all : 메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 true
-- all() 은 괄호안 조건들을 모두 만족해야 출력

-- exits : 서브쿼리의 결과가 존재하면(즉, 행이 1개 이상일 경우) true

select ename, sal, job
from emp
where job = 'SALESMAN'; -- 1600,1250,1500

select ename, sal
from emp
where sal < any(1600,1250,1500); 

select ename, sal
from emp
where sal < all (select sal
                from emp
                where job = 'SALESMAN'); 
                
select ename, sal
from emp
where sal <  (select min(sal)
                from emp
                where job = 'SALESMAN');
                
--emp 테이블
--30번 부서의 최대급여보다 적은 급여를 받는 사원 출력(any, all 사용)
select sal from emp where deptno=30; --2850,1600,1500,1250,950

select *
from emp
where sal < (select max(sal) from emp where deptno = 30);

select max(sal) from emp where deptno = 30;

select *
from emp
where sal < any (select sal from emp where deptno = 30);

select sal from emp where deptno = 30;


--30번 부서의 최대급여보다 많은 급여를 받는 사원 출력(any, all 사용)
select *
from emp
where sal > all (select sal from emp where deptno = 30);

select * 
from dept
where exists (select deptno from dept where deptno = 20);

select * 
from dept
where exists (select deptno from dept where deptno = 50);

---------
--p.266
--DML(조작어:data manipulation language):데이터를 추가,수정,삭제 ==> 데이터 조작어
--DDL(data definition language):객체를 생성,변경,삭제하는 데이터 정의어
--DCL

--test1
--(no,name,address,tel)테이블 생성 => create table 테이블명 (컬럼 정의)
--숫자(5),문자열(10),문자열(50),문자열(20)
create table test1(
    no number(5),
    name varchar2(10),
    address varchar2(50),
    tel varchar2(20)
);
select * from test1;
select count(*) from test1;
--(no,name)에 (1,'aaa')추가 => insert into 테이블명(컬럼) values(값)
insert into test1(no, name) values(1,'aaa');
--(2, 'bbb', '부산', '010-1111-2222')추가
insert into test1(no, name, address, tel) values(2,'bbb','부산','010-1111-2222');
--(3, 'ccc', '서울', '010-3333-4444')추가
insert into test1(no, name, address, tel) values(3,'ccc','서울','010-3333-4444');
--(4. 'ddd', '대구', '010-4444-5555')추가
insert into test1 values(4, 'ddd', '대구', '010-4444-5555');
--모든 컬럼에 값을 넣을때는 컬럼을 생략할 수 있다.
select * from test1;
--(5, 'eee', '제주')추가
insert into test1(no, name, address) values(5, 'eee', '제주');
commit; --커밋
--(6. 'ffff','010-6666-7777')추가
insert into test1(no, name, tel) values(6, 'ffff', '010-6666-7777');
rollback; --원 상태로 다시 돌림

--test1 테이블 no가 2인 정보출력
select * from test1 where no =2;

--수정 ) no => 2인 사람의 이름을 홍길동 수정
update test1
set name = '홍길동'
where no=2;
commit;

--수정 )no가 4인 name => 이순신 / address => 서울
select * from test1 where no = 4;

update test1
set name = '이순신', address = '서울'
where no = 4;

--삭제 ) test1에서 no1을 삭제
select * from test1;

delete test1 where no = 1;
delete from test1 where no = 2;
commit;
delete from test1;
rollback; --복구

--test 테이블 생성(no, name, hiredate)
--숫자(4), 문자열(20),date
create table test( --create는 커밋 자체를 가지고있어 commit을 따로 안해도 생성됨.
    no number(4) default 0, --기본값을 0 (지정안할 시 null 적용됨)
    name varchar2(20) default 'NONAME',
    hiredate date default sysdate);
    
--test 테이블에 (1,홍길동) 추가
select * from test;

insert into test(no, name) values(1, '홍길동');

--test 테이블에 25/2/6 추가
insert into test(hiredate) values('25/2/6');

--test 테이블에서 번호가 1번인 사람의 이름을 '강감찬'으로 수정
update test
set name = '강감찬'
where no = 1;

--test 테이블에서 no = 0을 삭제
delete from test
where no = 0;

--test 테이블에서 no = 2 추가
insert into test(no) values (2);
select * from test;
commit;

----------
--CRUD(create, select, update, delete)
--p.266(CTAS:)
select * from dep;
--dept_temp 테이블생성 dept 테이블 그대로
create table dept_temp
as select * from dept;

select * from dept_temp;

--dept_temp 테이블에 50, database, seoul 추가
insert into dept_temp(deptno, dname, loc) values(50,'DATABASE','SEOUL');
commit;

--테이블 구조만 복사
create table emp_temp
as select * from emp
where 1<>1;

select * from emp_temp;

--emp_temp 테이블에 empno, ename, job, mgr, hiredate, sal, comm, deptno
--(2111,'이순신','MABAGER',9999,'07/01/2019',4000,NULL,20) 추가     
insert into emp_temp
       values(2111,'이순신','MANAGER',9999,to_date('07/01/2019','DD/MM/YYYY'),4000,NULL,20);
       
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, deptno)
       values(2112,'이순신','MANAGER',9999,to_date('07/02/2019','DD/MM/YYYY'),4000,20);
       
insert into emp_temp
       values(2113,'이순신3','MANAGER',9999,to_date('06/02/2019','DD/MM/YYYY'),4000,null,20);

insert into emp_temp
       values(3111,'강감찬','MANAGER',9999,sysdate,4000,null,20);

commit;

--p.275
--서브쿼리를 이용해서 한 번에 여러 데이터를 추가 (values를 사용하지 않는다.)
--emp 테이블에서 급여가 급여등급(salgrade)이 1(700~1200)사원만 emp_temp 테이블에 추가
select * from emp_temp;
select * from salgrade;
select * from emp where sal between 700 and 1200;

insert into emp_temp --values가 아닌 바로 select =>
select * from emp 
where sal between 700 and 1200;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp 
where sal between 700 and 1200;

delete from emp_temp; --모든 데이터 삭제
commit;
select * from emp_temp;

--급여등급(salgrade)이 3인 사원만 emp_temp 추가
insert into emp_temp
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade = 3;

--dept 테이블을 복사해서 dept_temp2 테이블을 생성하고
--40번 부서명 => DATABASE/ 지역 => SEOUL 수정
--drop table dept_temp2; --테이블 전체 삭제

create table dept_temp2
as select * from dept;

select * from dept_temp2;

update dept_temp2
set dname = 'DATABASE', loc = 'SEOUL'
where deptno = 40;

commit;

--dept_temp2 테이블에서 부서번호가 40번인 부서명과 지역을 수정
--dept 테이블의 40번 부서의 내용을 수정하기
select * from dept where deptno = 40;

update dept_temp2
set dname = 'OPERATIONS', loc = 'BOSTON'
where deptno = 40;

select * from dept_temp2;
rollback;

update dept_temp2
set dname = (select dname from dept where deptno = 40),
    loc = (select dname from dept where deptno = 40)
where deptno = 40;

update dept_temp2
set (dname, loc) = (select dname, loc from dept where deptno = 40)
where deptno = 40;
commit;

--p.262 9장 연습문제
--emp 테이블 
--1) 'ALLEN'과 같은 직책(job)인 사원들의 사원정보, 부서정보 출력
select e.job, e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno 
and job = 'SALESMAN'; 

select e.job, e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno 
and job = (select job from emp where ename = 'ALLEN');

select job, empno, ename, sal, deptno, dname
from emp e natural join dept d
where job = (select job from emp where ename = 'ALLEN');

select job, empno, ename, sal, deptno, dname
from emp e join dept d using(deptno)
where job = (select job from emp where ename = 'ALLEN');

--2) emp테이블에서 전체 사원의 평균급여(sal)보다 높은 급여를 받는 사원들의
--사원정보, 부서정보, 급여 등급 정보를 출력 (급여가 많은 순으로 정렬 / 급여가 같을 경우 사원 번호 기준 오름차순)
select avg(sal) from emp;

select empno, ename, dname, hiredate, loc, sal, grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno 
and e.sal between s.losal and s.hisal
and sal > (select avg(sal) from emp)
order by empno;

select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
join salgrade s on e.sal between s.losal and s.hisal
where e.sal > (select avg(sal) from emp)
order by empno;

--3) 10번 부서에서 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의
--사원정보, 부서정보를 출력
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
from emp e join dept d
on e.deptno = d.deptno
and e.deptno = 10 
and job not in (select job from emp where deptno = 30);

select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 10 
and job not in (select job from emp where deptno = 30);

select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 10
and e.job not in(select distinct job from emp where deptno = 30);

--4) 직책이 'SALESMAN'인 사람들의 최고급여보다 높은 급여를 받는 사원들의
--사원정보, 급여등급정보 출력 (서브쿼리 활용 시 1. 다중행 함수 사용 / 2. 다중행 함수 사용x => 사원번호 기준 오름차순 정렬)
select e.empno, e.ename, e.sal, s.grade
from emp e , salgrade s
where e.sal between s.losal and s.hisal
and sal > (select max(sal) from emp where job = 'SALESMAN')
order by empno;

--1. 다중행 함수 사용
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where e.sal > all(select sal from emp where job = 'SALESMAN') --all은 전부 다 커야 true
order by empno;

select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where e.sal > all(select sal from emp where job = 'SALESMAN') --any는 1250 보다 크면 true
order by empno;

--2. 다중행 함수 사용
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where e.sal > (select max(sal) from emp where job = 'SALESMAN')
order by empno;

--p.287 10장 연습문제
create table chap10hw_emp as select * from emp;
create table chap10hw_dept as select * from dept;
create table chap10hw_salgrade as select * from salgrade;

select * from chap10hw_emp;
select * from chap10hw_dept;
select * from chap10hw_salgrade;

commit;
--1)chap10hw_dept 테이블에 50,60,70,80번 부서를 등록
insert into chap10hw_dept values (50,'ORACLE','BUSAN');
insert into chap10hw_dept values (60,'SQL','ILSAN');
insert into chap10hw_dept values (70,'SELECT','INCHON');
insert into chap10hw_dept values (80,'DML','BUNDANG');


--2)chap10hw_emp 테이블에 다음 8명의 사원 정보를 등록
select * from chap10hw_emp;

insert into chap10hw_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            values (7201,'TEST_USER1','MANAGER',7788,to_date('2016-01-02','YYYY/MM/DD'),4500, null,50);

insert into chap10hw_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            values (7202,'TEST_USER2','CLERK',7201,to_date('2016-02-21','YYYY/MM/DD'),1800,'',50);
            
insert into chap10hw_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            values (7203,'TEST_USER3','ANALYST',7201,to_date('2016-04-11','YYYY/MM/DD'),3400,'',60);
            
insert into chap10hw_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            values (7204,'TEST_USER4','SALESMAN',7201,to_date('2016-05-31','YYYY/MM/DD'),2700,'',60);
            
insert into chap10hw_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            values (7205,'TEST_USER5','CLERK',7201,to_date('2016-07-20','YYYY/MM/DD'),2600,'',70);
 
insert into chap10hw_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            values (7206,'TEST_USER6','CLERK',7201,to_date('2016-09-08','YYYY/MM/DD'),2600,'',70);

insert into chap10hw_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            values (7207,'TEST_USER7','LECTURER',7201,to_date('2016-10-28','YYYY/MM/DD'),2300,'',80);

insert into chap10hw_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
            values (7208,'TEST_USER8','STUDENT',7201,to_date('2018-03-09','YYYY/MM/DD'),1200,'',80);
commit;
select * from chap10hw_emp;

--3)chap10h2_emp에 속한 사원 중
--50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들은
--70번 부서로 옮기기
select avg(sal) from chap10hw_emp where deptno = 50; --3150
update chap10hw_emp
set deptno = 70
where sal > 3150;

update chap10hw_emp
set deptno = 70
where sal > (select avg(sal) from chap10hw_emp where deptno = 50);

commit;
select * from chap10hw_emp;

--4) chap10hw_emp에 속한 사원 중
--60번 부서의 사원 중에 입사일이 가장 빠른 사원보다 늦게 입사한
--사원의 급여를 10% 인상하고 80번 부서로 옮기기
select min(hiredate) from chap10hw_emp where deptno = 60; --16/05/31

update chap10hw_Emp
set sal = sal*1.1, deptno = 80
where hiredate > '16/05/31';

update chap10hw_emp
set sal = sal*1.1, deptno = 80
where hiredate > (select min(hiredate) from chap10hw_emp where deptno = 60);
commit;
select * from chap10hw_emp;

--5) chap10hw_emp에 속한 사원 중 급여 등급이 5인 사원을 삭제하는 SQL
select * from chap10hw_emp;
select
from chap10hw_emp e, chap10hw_salgrade s
where e.sal between s.losal and s.hisal and grade = 5; --5000,4500,3400
--삭제
delete from chap10hw_emp
where sal in (5000,4500,3400);
rollback;

delete from chap10hw_emp
where sal in(select sal
from chap10hw_emp e, chap10hw_salgrade s
where e.sal between s.losal and s.hisal and grade = 5);

commit;
select * from chap10hw_emp;

--------------------------
--dept_temp2 모든 데이터 삭제
select * from dept_temp2;
delete from dept_temp2;
commit;
--dept_temp2 테이블 삭제
drop table dept_temp2;
--오류발생(테이블 삭제 되어서)
--select * from dept_temp2;
--dept_temp 테이블 삭제
drop table dept_temp;
--emp_temp 테이블 삭제
drop table emp_temp;

--dept 테이블을 이용해서 dept_temp테이블 생성
create table dept_temp
as select * from dept;

select * from dept_temp;

--LOCATION 컬럼 추가
alter table dept_temp add(LOCATION varchar2(30));

--10번 부서의 LOCATION의 값을 뉴욕으로 수정
update dept_temp
set LOCATION = '뉴욕'
where deptno = 10;

select * from dept_temp;

--LOCATION 컬럼 수정 : varchar2(70)
alter table dept_temp modify(LOCATION varchar2(70));
describe dept_temp;

--LOCATION 컬럼 삭제 
alter table dept_temp drop column LOCATION;

--LOC 컬럼명을 LOCATION 변경
alter table dept_temp rename column LOC to LOCATION;

--테이블 이름 변경 dept_temp => dept_temptemp
alter table dept_temp rename to dept_temptemp;
describe dept_temptemp;
rename dept_temptemp to dept_temp;

select * from dept_temp;
describe dept_temp;

--dept_temp 데이터 모두 삭제
delete from dept_temp;
select * from dept_temp;

--취소
rollback; --데이터 원상 복귀
--dept_temp 데이터 모두 삭제 (truncate : DDL이므로 rollback이 적용되지 않음)
truncate table dept_temp;
select * from dept_temp;

--취소
rollback; --rollback 해도 데이터 복구 안됨
select * from dept_temp;

--dept_temp 테이블 삭제
drop table dept_temp;
--오류발생
--select * from dept_temp;

---------------------
select * from test1;
--1.칼럼 추가 : birthday date 형
alter table test1 add (birthday date);
describe test1;
--2.칼럼 명 수정 : tel => phone
alter table test1 rename column tel to phone;
--3. no 컬럼을 삭제
alter table test1 drop column no;
--4. num 컬럼 추가: number(3)
alter table test1 add(num number(3));
--5. address 문자열(50) => 문자열(70) 변경
alter table test1 modify (address varchar2(70));
describe test1;
--6. test1 테이블 이름을 => testtest
alter table test1 rename to testtest;
select * from testtest;

rename testtest to test2;
select * from test2;

--테이블 삭제
drop table test2;
--오류발생
--select * from test2;







