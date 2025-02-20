--예)호텔-->리뷰
--1) HOTEL (hotel_id,name,grade,address)
--hotel_id 기본키 => 시퀀스 : hotel_seq
--(HOTEL 테이블 생성)
CREATE TABLE HOTEL(
    hotel_id NUMBER PRIMARY KEY,
    name VARCHAR2(3),
    grade VARCHAR2(10),
    address VARCHAR2(70)
);
--(HOTEL 시퀀스 생성)
CREATE SEQUENCE hotel_seq 
INCREMENT BY 1
START WITH 1 
MINVALUE 1
NOCACHE
NOCYCLE;

--2) review(num,title, content, regdate)
--num : 기본키 => 시퀀스 : review_seq
--regdate date형 => 오늘날짜를 기본값
--(REVIEW 테이블 생성)
CREATE TABLE REVIEW(
    num NUMBER(3) CONSTRAINT review_pk PRIMARY KEY,
    title VARCHAR2(30),
    content VARCHAR2(200),
    regdate DATE DEFAULT SYSDATE,
    hid NUMBER(3) CONSTRAINT review_fk
    REFERENCES hotel(hotel_id)
);

--(REVIEW 시퀀스 생성)
CREATE SEQUENCE review_seq
INCREMENT BY 1
START WITH 1 
MINVALUE 1
NOCACHE
NOCYCLE;

--3)hotel은 여러개의 review를 가질 수 있다
-- =>외래키 부여
--------------

--employees / departments
--부서는 여러명의 사원을 가진다
alter table employees
add CONSTRAINT departments_fk foreign key(department_id)
references departments(department_id); 

--제약조건 확인
select * from user_constraints;
select constraint_name, constraint_type, table_name
from user_constraints;

--호텔, 리뷰 테이블 삭제
drop table hotel;
drop table review;

select constraint_name, constraint_type, table_name
from user_constraints
where table_name='REVIEW';
