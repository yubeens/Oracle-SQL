--버전업으로 사용자 계정앞에 c## 
--c##을 붙이지 않고 사용자 계정 생성하기 위해 session 변경

alter session set "_oracle_script" = true;

--1.사용자 생성 : test_user // 비번 : 1234
create user test_user IDENTIFIED by 1234;

--2.test_user => 접속권한(create session)부여
grant create session to test_user; 
grant unlimited tablespace to test_user; --test table

--3.비번 변경: abcd
alter user test_user identified by abcd;

--4.test_user 삭제
drop user test_user; --오류 : 현재 접속되어 있어 불가
drop user test_user; -- 접속 해제 후 삭제
--연결(접속) 불가
drop user test_user cascade; --물려있는 오류가 있으면 연관되어있는 것 까지 삭제

-------------------
--p.412 롤(role)
--connect 롤 : create session 권한
--resource 롤 : 테이블, 시퀀스 등 객체 생성 권한

--1.사용자 생성
create user test_user identified by abcd; 

--2.권한 부여
grant connect, resource, unlimited tablespace to test_user;

--3.권한 삭제 => test_user에 connect롤 권한만 제거 
revoke connect from test_user;

--test_user 삭제
drop user test_user;

--------------------------
--p.416 15장 연습문제
--1.prev_hw 계성생성(비번 orcl)접속 가능하도록 생성 => 관리자계정에서 작업
create user PREV_HW identified by orcl;
grant connect, resource, unlimited tablespace to PREV_HW;

--2.scott계정으로 접속해서 PREV_HW에 emp, dept, salgrade테이블의 select 권한 부여
--grant select on emp to PREV_HW;
--grant select on dept to PREV_HW;
--grant select on salgrade to PREV_HW;

--2.scott계정으로 접속해서 PREV_HW에 emp, dept, salgrade테이블의 select 권한 부여
--grant select on emp to PREV_HW;
--grant select on dept to PREV_HW;
--grant select on salgrade to PREV_HW;

--3.2번에 부여한 권한 취소
--revoke select on emp from PREV_HW;
--revoke select on dept from PREV_HW;
--revoke select on salgrade from PREV_HW;

--4.PREV_HW 삭제
drop user prev_hw cascade;






