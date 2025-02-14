--CTAS
--1.employees 이용해서 sal_history(empid, hiredate,sal) 테이블  생성
create table sal_history(empid,hiredate,sal)
as select employee_id, hire_date, salary
from employees;

create table sal_history as 
select employee_id as empid,
hire_date as hiredate,
salary as sal
from employees;

select * from sal_history;

--2.employees 구조만 이용해서 sal_history2(empid, hiredate,sal) 테이블  생성
create table sal_history2(empid,hiredate,sal)
as select employee_id, hire_date, salary
from employees
where 1<>1;

create table sal_history2 as
select employee_id as empid,
hire_date as hiredat,
salary as sal
from employees
where 1=0; --데이터 없이 구조만 복사

select * from sal_history2;

--3.employees 구조만 이용해서 sal_history3(id, hire,sal) 테이블  생성
create table sal_history3(id,hire,sal)
as select employee_id, hire_date, salary
from employees
where 1<>1;

select * from sal_history3;

--4. sal_history/ sal_history2 /sal_history3 테이블 삭제
drop table sal_history;
drop table sal_history2;
drop table sal_history3;
--select * from sal_history3; 삭제해서 오류 

--5.employees 구조만 이용해서 sal_history(empid, hiredate,sal) 테이블  생성
create table sal_history(empid, hiredate, sal)
as select employee_id, hire_date, salary
from employees
where 1<>1;

--6.employees 테이블에서 employee_id 가 200보다 큰 데이터를  sal_history 에 데이터 넣기
insert into sal_history
select employee_id, hire_date, salary
from employees
where employee_id > 200;

commit;

select * from sal_history;

--1. member  테이블 생성
-- id 숫자 / name 문자열(20) / address  문자열(50) /  phone 문자열(20)
create table member(
    id number,
    name varchar2(20),
    address varchar2(50),
    phone varchar2(20)
);

select * from member;
describe member;

--2.추가
-- (100, '홍길동' ,'부산','010-1111-2222')
-- (101, '이순신' ,'서울','010-2222-3333')
-- (102, '강감찬' ,'대구','010-4444-5555')
-- (103, '오라클' ,'부산','010-5555-6666')
-- (104, '데이터베이스' ,'서울','010-3434-7777')

insert into member(id, name, address, phone)
values(100, '홍길동' ,'부산','010-1111-2222');
insert into member values(101, '이순신' ,'서울','010-2222-3333');
insert into member values(102, '강감찬' ,'대구','010-4444-5555');
insert into member values(103, '오라클' ,'부산','010-5555-6666');
insert into member values(104, '데이터베이스' ,'서울','010-3434-7777');

commit;

select * from member;

--3. address(지역) 별 member  인원수 출력
select address, count(*)
from member
group by address;

select address 지역, count(*)||'명' 인원수
from member
group by address;

select address 지역, concat(count(*),'명') 인원수
from member
group by address;

select address 지역, concat(count(*),'명') 인원수
from member
group by address
order by address;

--4. 102번 멤버의 전화번호를 010-1212-4444로 수정
update member
set phone = '010-1212-4444'
where id=102;

commit;

select * from member;

--5. 103번 회원 삭제
delete from member where id = 103;

select * from member;

commit;

--6. member 테이블에 email(문자열 30)컬럼 추가
alter table member add(email varchar2(30));

describe member;

--7. member 테이블에 email(문자열 100) 컬럼 변경
alter table member modify(email varchar(100));

describe member;

--8. 102번 멤버의 email을 test@test.com 수정
select * from member where id = 102;

update member 
set email = 'test@test.com'
where id = 102;

commit;

--9. member address 컬럼명을 addr로 변경
alter table member rename column address to addr;

--10. member 테이블 삭제
drop table member;

------
--1.member 테이블 생성
--num 숫자 / name 문자열 / address 문자열
--phone 문자열 / hiredate date 기본값 오늘날짜
--num : 시퀀스 (member_seq / 1로 시작, 1씩 증가, 최소값 1 / 사이클 없음, 캐쉬 없음)

create sequence member_seq
increment by 1
start with 1
minvalue 1
nocache
nocycle;

create table member(
        num number(3),
        name varchar2(20),
        address varchar2(70),
        phone varchar2(20),
         hiredate date default sysdate
);

--2. 추가 => num은 자동 증가
--'홍길동','010-1111-2222','부산'
insert into member(num,name,address,phone)
values(member_seq.nextval,'홍길동','010-1111-2222','부산');
--'이순신','010-2222-3333','부산'
select * from member;

insert into member(num, name, address, phone)
values(member_seq.nextval,'이순신','010-2222-3333','서울');

insert into member
values(member_seq.nextval,'강감찬','010-4444-5555','전남','25/01/01');

commit;

--시퀀스 삭제
drop sequence member_seq;

--테이블 삭제
drop table member;

-- 삭제 select * from member;

------------------------









