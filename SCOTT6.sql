--외래키
--부서: dept_fk(부서번호,부서명,지역)
create table dept_fk(
    deptno number(5) constraint dept_fk_deptno_pk primary key ,
    dname varchar2(20),
    loc varchar2(50)
);

--사원: emp_fk(사원번호, 사원이름, 직책, 부서번호)
create table emp_fk(
    empno number(2) constraint emp_fk_empno_pk primary key,
    ename varchar2(20),
    job varchar2(20),
    deptno number(5)
);

--데이터 추가
insert into dept_fk values(10,'영업','부산');
insert into dept_fk values(20,'영업2','부산2');

insert into emp_fk values(1,'홍길동','사원',10);

commit;

select * from dept_fk;
select * from emp_fk;

insert into emp_fk values(2,'이순신','사원',30);
------------
create table dept_fk1(
    deptno number(5) constraint dept_fk1_deptno_pk1 primary key ,
    dname varchar2(20),
    loc varchar2(50)
);

create table emp_fk1(
    empno number(2) constraint emp_fk1_empno_pk1 primary key,
    ename varchar2(20),
    job varchar2(20),
    deptno number(5) constraint emp_fk1_deptno_fk
    references dept_fk1(deptno)
);

--데이터 추가
insert into dept_fk1 values(10,'영업','부산');
insert into dept_fk1 values(20,'영업2','부산2');
select * from dept_fk1;

insert into emp_fk1 values(1,'홍길동','사원',10);
select * from emp_fk1;

commit;

--무결성 제약조건(SCOTT.EMP_FK1_DEPTNO_FK)이 위배 
--dept_fk1에 30번 부서가 없기 때문에 오류(부모키가 없음)
insert into emp_fk1 values(2,'이순신','사원',30);
--성공 : null가능
insert into emp_fk1 values(2,'이순신','사원', null); 

insert into emp_fk1 values(3,'강감찬','팀장', 10); 
commit;
select * from emp_fk1;

--1번 사원 삭제
delete from emp_fk1 where empno=1;

--20번 부서 삭제
delete from dept_fk1 where deptno=20;
select * from emp_fk1;

--10번 부서 삭제 
--(오류:무결성 제약조건(SCOTT.EMP_FK1_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다) 
delete from dept_fk1 where deptno=10;

--2번 사원의 부서번호를 30으로 수정
--(오류:dept_fk1테이블에 30번 부서가 없음)
update emp_fk1
set deptno = 30
where empno =2;

--외래키 제약조건을 삭제
alter table emp_fk1
drop constraint emp_fk1_deptno_fk;

insert into emp_fk1 values(4,'aaa','팀장',30); --성공(외래키 제약조건 삭제)
select * from emp_fk1;
delete from emp_fk1 where empno=4;
commit;

--외래키 제약조건을 추가
alter table emp_fk1
add constraint emp_fk1_deptno_fk1 foreign key(deptno)
references dept_fk1(deptno);

select * from dept_fk1;

--10번 부서 삭제
--(오류: 무결성 제약조건(SCOTT.EMP_FK1_DEPTNO_FK1)이 위배되었습니다- 자식 레코드가 발견되었습니다)
delete from dept_fk1 where deptno=10;

--외래키 제약조건 삭제
alter table emp_fk1
drop constraint emp_fk1_deptno_fk1;

--외래키 제약조건 추가
alter table emp_fk1
add constraint emp_fk1_deptno_fk1 foreign key(deptno)
references dept_fk1(deptno)
on delete cascade; --삭제 시 부모가 삭제되면 자식도 삭제

--10번 부서 삭제
delete from dept_fk1 where deptno =10; --성공
select * from emp_fk1; --10번 부서 소속사원도 삭제

--툴에서 외래키 제약조건 설정

drop table dept_fk;
drop table dept_fk1;
drop table emp_fk1;
drop table emp_fk;

---------------------
--check
create table table_check(
    login_id varchar2(20) constraint tb_check_loginID primary key,
    login_pwd varchar2(20)
    constraint tb_check_loginPWD check (length(login_pwd)>5),
    tel varchar2(20)
);

--테이블 추가
--오류: 체크 제약조건(SCOTT.TB_CHECK_LOGINPWD)이 위배되었습니다
insert into table_check(login_ID, login_pwd, tel)
values('aa','1234','010-1111-2222');

--성공
insert into table_check(login_ID, login_pwd, tel)
values('aa','123456','010-1111-2222');

commit;

---------------------
--Member(userid, username, tel)
--기본키 userid 제약조건 pk_member
create table member(
    userid varchar2(20) constraint pk_member primary key,
    username varchar2(20),
    tel varchar2(20)
);
--Board(num, title, name, content, regdate(오늘날짜 디폴트값))
--기본키 : num(시퀀스명: board_seq) / 제약조건 pk_board)
--외래키 : userid / 제약조건 fk_board
create table board(
    num number(3) constraint pk_board primary key,
    title varchar2(20),
    content varchar2(200),
    regdate date default sysdate,
    userid varchar2(20) constraint fk_board
    references member(userid)
);

create sequence board_seq
increment by 1
start with 1
minvalue 1
nocache
nocycle;

--comments(cnum, msg, regdate(오늘날짜 디폴트값))
----기본키 : cnum(시퀀스명: comments_seq) / 제약조건 pk_comments)
--외래키 : userid / 제약조건 fk_comments
create table comments(
    cnum number(3) constraint pk_comments primary key,
    msg varchar2(100),
    regdate date default sysdate,
    userid varchar2(20) constraint fk_member --member
    references member(userid),
    bnum number(3) constraint fk_comments_board --board
    references board(num)   
);

create sequence comments_seq
increment by 1
start with 1
minvalue 1
nocache
nocycle;

--member추가
insert into member values('a1','홍길동','010-1111-2222');
commit;

select * from member;

--board(num, title, content, regdate, userid)추가
insert into board values(board_seq.nextval, '제목1','내용1', sysdate, 'a1');
select * from board;
commit;

--comments(cnum, msg, redate, userid, bnum)추가
select * from comments;
insert into comments values(comments_seq.nextval, '메세지1', sysdate, 'a1', 1);

insert into comments values(comments_seq.nextval, '댓글1', sysdate, 'a1', 1);
insert into comments values(comments_seq.nextval, '댓글2', sysdate, 'a1', 1);
insert into comments values(comments_seq.nextval, '댓글3', sysdate, 'a1', 1);
insert into comments values(comments_seq.nextval, '댓글4', sysdate, 'a1', 1);

commit;

select * from member;
select * from board;
select * from comments;

--1번 게시글을 쓴 사람의 이름을 출력
select username
from board
    natural join member
where num = 1;

--member 추가
insert into member values('b1','이순신','010-1111-3333');

--board 추가
insert into board values(board_seq.nextval, '제목2','내용2', sysdate, 'b1');

--comments 추가
insert into comments values(comments_seq.nextval, '댓글11', sysdate, 'b1', 3);
insert into comments values(comments_seq.nextval, '댓글22', sysdate, 'b1', 3);
insert into comments values(comments_seq.nextval, '댓글33', sysdate, 'b1', 3);

commit;

select * from member;
select * from board;
select * from comments;

--member별 댓글 수 출력(userid, 댓글 수)
select userid, count(*)댓글수
from comments
group by userid;

--member별 댓글 수와 이름 출력(userid, 댓글 수, username)
select m.username,m.userid, count(*)댓글수
from comments c , member m
where c.userid = m.userid
group by m.userid,username;

--join
select m.username,m.userid, count(*)댓글수
from comments c join member m
on c.userid = m.userid
group by m.userid,username;

select username,userid, count(*)댓글수
from comments c natural join member m
group by userid,username;

select username,userid, count(*)댓글수
from comments c join member m using(userid)
group by userid,username;

--인라인뷰
select m.username,m.userid, 댓글수
from (select userid, count(*)댓글수
        from comments
        group by userid) c, member m
where c.userid = m.userid;

--member테이블 a1삭제
--외래키 제약 조건에서 작업없음(no action)설정되어 자식이 있을 경우 삭제 불가
delete from member where userid='a1';--오류

--board테이블의 제약조건 확인
select * from user_constraints where table_name = 'BOARD';

select * from student;
select * from professor;

--scott student / professor / department
--student 외래키 부여 (student의 deptno => professor의 deptno)
alter table student
add constraint student_fk
foreign key (profno)
references professor(profno);

--professor 외래키 부여 (professor의 deptno => department의 deptno)
alter table professor
add constraint professor_fk
foreign key (deptno)
references department(deptno);

-----------------
--p.394 14장 연습문제
--시퀀스
--1.1
CREATE TABLE dept_const(
        deptno NUMBER(2)
            CONSTRAINT deptconst_deptno_pk
                PRIMARY KEY,
        dname VARCHAR2(14)
            CONSTRAINT deptconst_dname_unq
                UNIQUE,
        loc VARCHAR2(13)
            CONSTRAINT deptconst_loc_nn
                NOT NULL
    );

--1.2
CREATE TABLE emp_const(
    empno NUMBER(4)
        CONSTRAINT empconst_empno_pk
            PRIMARY KEY,
    ename VARCHAR2(10)
        CONSTRAINT empconst_ename_nn
            NOT NULL,
    job VARCHAR2(9),
    tel VARCHAR2(20)
        CONSTRAINT empconst_tel_unq
            UNIQUE,
    hiredate DATE,
    sal NUMBER(7, 2)
        CONSTRAINT empconst_sal_chk
            CHECK(sal BETWEEN 1000 AND 9999),
    comm NUMBER(7, 2),
    deptno NUMBER
        CONSTRAINT empconst_deptno_fk
            REFERENCES dept_const(deptno)
            ON DELETE CASCADE
);

--1.3
select table_name, CONSTRAINT_NAME ,CONSTRAINT_TYPE
from user_constraints
where table_name in('DEPT_CONST','EMP_CONST');

------------------------
--p.396 15장 사용자,권한,롤 관리
--사용자 / 데이터베이스 스키마
--예 : scott - 사용자
--scott이 생성한 테이블, 제약조건, 시퀀스 등 데이터베이스에서 만든 모든 객체를 스키마
--사용자 생성 => 관리자 권한

--------------------------
--p.416 15장 연습문제
--1.prev_hw 계성생성(비번 orcl)접속 가능하도록 생성 => 관리자계정에서 작업
--create user PREV_HW identified by orcl;
--grant connect, resource, unlimited tablespace to PREV_HW;

--2.scott계정으로 접속해서 PREV_HW에 emp, dept, salgrade테이블의 select 권한 부여
grant select on emp to PREV_HW;
grant select on dept to PREV_HW;
grant select on salgrade to PREV_HW;

--3.2번에 부여한 권한 취소
revoke select on emp from PREV_HW;
revoke select on dept from PREV_HW;
revoke select on salgrade from PREV_HW;
 
--4.PREV_HW 삭제 => 관리자 계정에서 작업

