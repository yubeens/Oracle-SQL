--DML(조작어:data manipulation language):데이터를 추가,수정,삭제==>데이터조작어(insert, update, delete)
--DDL(data definition language):객체를 생성, 변경, 삭제하는 데이터정의어(create,alter,drop)
--DCL

--p.291 11장 트랜잭션
--트랜잭션: 더 이상 분할 할 수 없는 최소 수행단위
--한번에 수행하여 작업을 완료하거나 모두 수행하지 않거나(작업취소)
--ALL or Nothing(commit / rollback)
--TCL

--트랜잭션(ACID)
--A :원자성 (Atomicity)
--C :일관성(Consistency) - 일관적으로 DB상태 유지
--I :격리성(Isolation) - 트랜잭션 수행 시 다른 트랜잭션의 작업이 끼어들지 못하도록 보장하는 것
--D :영속성(Durability) - 성공적으로 수행 된 트랜잭션은 영원히 반영 되는 것


--p.298 읽기일관성
--격리수준
    --Oracle : Read Commited
    --MySQL : Repeatable Commited => 트랜잭션 범위에서 조회한 데이터 내용은 항상 동일

select * from test;
insert into test(no,name) values(3,'홍길동');

update test
set name = '홍길동22'
where no = 3;

commit;


--p.327 13장
-- 데이터 사전 (data dictionary): 데이터베이스를 구성하고 운영하는데 필요한 모든 특수한 테이블로 데이터베이스가 생성되는 시점에 자동 생성
    --USER_ : 현재 데이터베이스에 접속한 사용자가 소유한 객체 정보
    --ALL_ : 사용 가능한 모든 객체 정보
    --DBA_L : 데이터베이스 관리를 위한 정보(SYS, SYSTEM 사용자만 열람 가능)
    --VS_ : 데이터베이스 성능 관련
    
--인덱스
--뷰(view) : 가상의 테이블 (물리적으로 존재하진 않음 / 편의성, 보안상)

select * from dictionary;
--현재 접속한 계정(scott)이 가지고 있는 모든 테이블 조회

select table_name from user_tables;
--scott계정이 가지고 있는 모든 객체 정보 조회

select owner, table_name from all_tables;

--select * from dba_tables;
--관리자 권한 오류발생


--p.336 인덱스
--생성
create index idx_emp_sal
on emp(sal);

--삭제
drop index idx_emp_sal;

--뷰(view)
    --p.341 뷰(view)
    create view vw_emp20
    as (select empno, ename, job, deptno
    from emp
    where deptno > 20);
    
    select * from vw_emp20; --가상 테이블
    select * from user_views; --데이터 사전

    create or replace view vw_emp20 --or replace => 없으면 만들고 있으면 대체하라
    as (select empno, ename, job, deptno
    from emp
    where deptno > 20);

    --emp테이블 전체 내용을 v_emp1 뷰 생성
    create or replace view v_emp1
    as (select * from emp);
    
    select * from v_emp1;
    select * from user_views;
    
    --v_emp1 (3000, '홍길동', sysdate) 추가
    insert into v_emp1(empno, ename, hiredate)
    values(3000, '홍길동', sysdate);
    
    select * from v_emp1;
    select * from emp;
    commit;
    
    --emp테이블에서 3000번 삭제
    delete from emp where empno = 3000;
    commit;
    select * from emp;
    select * from v_emp1;
    
    --v_emp1테이블에서 3000번 삭제
    --다시 추가
    insert into v_emp1(empno, ename, hiredate)
    values(3000, '홍길동', sysdate);
    commit;
    
    delete from v_emp1 where empno = 3000;
    commit;
    
    select * from emp;
    select * from v_emp1;
    
    --뷰에서 추가나 삭제를 하면 물리적인 테이블에도 영향을 받는다
    
    --뷰 v_emp1 삭제
    drop view v_emp1;
    
    --emp테이블 전체 내용을 v_emp1뷰 생성
    create or replace view v_emp1
    as (select * from emp)
    with read only; --읽기권한만 준다 (업데이트,수정,삭제 불가) / 뷰를 만들 때 안전한 방법
    
    select * from v_emp1;
    
    --v_emp1 (3000, '홍길동', sysdate) 추가
    --오류발생(읽기전용 =>with read only 이므로 select 만 가능)
    --insert into v_emp1(empno, ename, hiredate)
    --values(3000,'홍길동',sysdate);
    
---------------------------------------------

--부서별 최대급여를 받는 사원의 부서번호, 부서명, 급여
--dept, emp테이블 이용
select * from dept;

select deptno,max(sal)
from emp
group by deptno;

select d.deptno, d.dname, e.sal
from dept d, emp e 
where d.deptno = e.deptno
and (d.deptno,e.sal) in (select deptno,max(sal) 
                from emp 
                group by deptno);

--p.344
--인라인뷰(SQL문에서 일회성으로 만들어 사용하는 뷰) => 서브쿼리, with
select d.deptno, d.dname, e.sal
from (select deptno, max(sal) sal
        from emp
        group by deptno) e, dept d
where e.deptno = d.deptno;

select d.deptno, d.dname, e.sal
from (select deptno, max(sal) sal
        from emp
        group by deptno) e join dept d
        on e.deptno = d.deptno;

------
--p.346 rownum (의사컬럼: pseudo column)
select * from emp;
select * from emp where rownum <=3;

select rownum, e.*
from emp e
where rownum <= 3;

--ename으로 내림차순하여 위에서 3개만 출력
select * from emp order by ename desc;

select rownum, e.*
from (select * from emp order by ename desc) e
where rownum <=3;

--ename으로 내림차순하여 위에서 3에서 5사이 출력
select rownum, e.*
from (select * from emp order by ename desc) e;

--(rownum까지 보는 테이블을 만들고 조회해야함.) 
select *
from (select rownum rn, e.*
        from (select * from emp order by ename desc) e
        )
where rn>=3 and rn<=5;

select *
from (select rownum rn, e.*
        from (select * from emp order by ename desc) e
        where rownum <= 5)
where rn>=3;

--ename으로 내림차순하여 위에서 3개 출력
select rownum, e.*
from (select * from emp order by ename)e
where rownum <=3;

--with 사용 (p.259)
--p.347
with e as (select * from emp order by ename)
select rownum, e.*
from e
where rownum <=3;

----------------
--p.348 시퀀스
create SEQUENCE dept_seq
increment by 10
start with 10
maxvalue 90
minvalue 0
nocycle
nocache;

select * from user_sequences;

--테이블 생성 : dept_sequence => dept 구조만
create table dept_sequence
as select * from dept
where 1<>1;

select * from dept_sequence;

--'DATABASE',"SEOUL'값 추가
insert into dept_sequence(dname, loc) values('DATABASE','SEOUL');

insert into dept_sequence(deptno, dname, loc)
values(dept_seq.nextval,'DATABASE1','SEOUL1');

insert into dept_sequence(deptno, dname, loc)
values(dept_seq.nextval,'DATABASE2','SEOUL2');

insert into dept_sequence(deptno, dname, loc)
values(dept_seq.nextval,'DATABASE3','SEOUL3');

select dept_seq.nextval from dual;

insert into dept_sequence(deptno, dname, loc)
values(dept_seq.nextval,'DATABASE4','SEOUL4');

select * from dept_sequence;

select dept_seq.currval from dual;

delete from dept sequence where dname = 'DATABASE';
commit;

select * from dept_sequence;

insert into dept_sequence(deptno, dname, loc)
values(dept_seq.nextval,'DATABASE5','SEOUL5');

--시퀀스 삭제
drop sequence dept_seq;

--테이블 삭제
drop table dept_sequence;

---------------------
--시퀀스 생성: emp_seq
--1로 시작 / 1씩 증가 / 캐쉬 없음, 사이클 없음 / 최소값 1
create sequence emp_seq
increment by 1
start with 1
minvalue 1
nocache
nocycle;

--테이블 생성: emp_tmp(num, name, phone, address)
--                숫자(3) 문자열(20) 문자열(20) 문자열(70)
create table emp_tmp(
            num number(3),
            name varchar2(20),
            phone varchar2(20),
            address varchar2(70)
);

--num: emp_seq 시퀀스로 사용
--name: 홍길동 / phone: 010-1111-2222 / address: 부산 추가
insert into emp_tmp 
values(emp_seq.nextval, '홍길동','010-1111-2222','부산');

--num: emp_seq 시퀀스로 사용
--name: 이순신 / phone: 010-2222-3333 / address: 부산 추가
insert into emp_tmp
values(emp_seq.nextval, '이순신','010-2222-3333','부산');

--num: emp_seq 시퀀스로 사용
--name: 이순신 / phone: 010-2222-3333 / address: 부산 추가
insert into emp_tmp 
values(emp_seq.nextval, '강감찬','010-4444-5555','서울');

commit;

select * from emp_tmp;

--시퀀스 변경
alter sequence emp_seq
increment by 20
cycle;

select emp_seq.nextval from dual;
select emp_seq.nextval from dual;

--시퀀스 삭제
drop sequence emp_seq;

--테이블 삭제
drop table emp_tmp;

---------------------
--p.357 13장 연습문제
--1.1
create sequence empidx_seq
increment by 1
start with 1
minvalue 1
nocache
nocycle;

create table empidx
as select * from emp;

select * from empidx;

--1.2
create index idx_empidx_empno
on empidx(empno);

--1.3
select *
from user_indexes
where table_name = 'idx_empidx_empno';

--2. empidx을 이용해서 급여가 1500초과인 사원들만의 empidx_over15k 뷰 생성
create or replace view empidx_over15k
as (select empno,ename,job,deptno,sal,comm
    from empidx
    where sal>1500);
    
select * from empidx_over15k;

create or replace view empidx_over15k
as (select empno,ename,job,deptno,sal,comm,
    nvl2(comm,'O','X') comm2
    from empidx
    where sal>1500)
with read only;

select * from empidx_over15k;

--3. 
create table deptseq
as select * from dept;

create sequence dept_seq
start with 1
increment by 1
maxvalue 99
minvalue 1
cycle
nocache;

--cycle로 nocucle 변경
alter sequence dept_seq
nocycle; 

--데이터 추가
select * from deptseq;
insert into deptseq values(dept_seq.nextval , 'database','seoul');
insert into deptseq values(dept_seq.nextval , 'database2','seoul2');
insert into deptseq values(dept_seq.nextval , 'database3','seoul3');
commit;

--시퀀스 삭제
drop sequence dept_seq;
drop sequence empidx_seq;

--테이블 삭제
drop table deptseq;

--뷰 삭제
drop view depidx_over15k; 

--인덱스 삭제
drop index idx_empidx_empno;
drop table empidx;

---------------------------
--p.360 14장 제약조건
 --notnull - 빈값을 허락하지 않는
 --unique - 중복되지 않는 값
 --primary key(기본키) => notnull/unique의 제약조건의 특성을 모두 가지는 제약조건 
 --데이터 중복을 허용하지 않고 null도 허용하지 않음
 --foreign key(외래키)
 --check
--p.362 
create table table_notnull(
    login_id varchar(20) not null,
    login_pw varchar(20) not null,
    tel varchar2(20)
);

insert into table_notnull(login_id, login_pw, tel)
values('aa','1111','010-1111-2222');

commit;

select * from table_notnull;

insert into table_notnull(login_id, login_pw, tel)
values('bb','2222','010-1111-3333');

commit;

insert into table_notnull(login_id, login_pw)
values('cc','3333');

commit;

select * from table_notnull;

--오류발생
--insert into table_notnull(login_id,tell) --login pw => not null
--values('dd','010-2222-4444);

---------
create table table_notnull2(
login_id varchar2(20) constraint tbl_nn2_loginID not null,
login_pw varchar2(20) constraint tbl_nn2_loginpw not null,
tel varchar(20)
);

--제약조건 확인
select * from user_constraints;

select * from user_constraints
where table_name = 'TABLE_NOTNULL'; --테이블명은 대문자로

select owner, constraint_name
from user_constraints
where table_name = 'TABLE_NOTNULL2';

select * from table_notnull2;

insert into table_notnull2 values('aa','1111','010-1111-2222');
insert into table_notnull2 values('aa','1111','010-1111-2222');

commit;

select * from table_notnull2;

--제약조건 변경 => tel을 not null
alter table table_notnull2
modify(tel constraint tbl_nn2_tel not null);

--오류발생 - notnull제약조건으로 불가
--insert into tabl_notnull2(logint_id, login_pw)
--values ('cc','3333');

--제약조건 변경 => login_id unique 조건 부여
delete from table_notnull2;

alter table table_notnull2
modify(login_id constraint tbl_nn2_unique_loginID UNIQUE);

insert into table_notnull2 values('aa','1111','010-1111-2222');

--무결성 제약 조건(SCOTT,TBL_NN2_UNIQUE_LOGINID)에 위배 (notnull 중복)
insert into table_notnull2 values('aa','2222','010-1111-3333');

--제약조건 변경 table_notnull2 테이블에서 tel이 가지는 제약조건 삭제
alter table table_notnull2
drop constraint tbl_nn2_tel;

insert into table_notnull2(login_id, login_pw) values('bb','2222');

create table table_unique(
    login_id varchar2(20) constraint tbl_unique_loginID UNIQUE,
    login_pw varchar2(20) not null,
    tel varchar2(20)
);

insert into table_unique(login_id, login_pw,tel)
values('aa','1111','010-1111-2222');

--무결성 제약 조건(SCOTT,TBL_NN2_UNIQUE_LOGINID)에 위배 
insert into table_unique(login_id, login_pw,tel)
values('aa','1111','010-1111-2222'); --aa 중복 오류

insert into table_unique(login_id, login_pw,tel)
values(null,'1111','010-1111-2222'); --성공

commit;

select * from table_unique;

--테이블 삭제
drop table table_notnull;
drop table table_notnull2;
drop table table_unique;

------------------------------
create table table_pk(
    login_id varchar2(20) primary key,
    login_pw varchar2(20) not null,
    tel varchar2(20)
);

insert into table_pk(login_id,login_pw,tel)
values('aa','1111','010-1111-2222');

--무결성 제약 조건(SCOTT,TBL_NN2_UNIQUE_LOGINID)에 위배 
-->login_id : primary key(기본키) = not null / unique
insert into table_pk(login_id,login_pw,tel)
values('aa','1111','010-1111-2222'); --aa가 중복(unique아님)으로 오류

insert into table_pk(login_id,login_pw,tel)
values(null,'1111','010-1111-2222'); --오류발생(null 안됨)

drop table table_pk;

------------------------
--1) 시퀀스 및 테이블 생성
--board(num, title, writer, content, regdate)
--     number                         date(기본값 : sysdate)
--num : 기본키 <- 시퀀스 이용
--시퀀스 생성: board_seq = 1/1/1/ no cycle, no cache

create sequence board_seq
start with 1
increment by 1
minvalue 1
nocycle
nocache;

create table board(
    num number primary key,
    title varchar2(30),
    writer varchar2(30),
    content varchar2(200),
    regdate date default sysdate
);

--2)데이터 추가
--(제목: board1, 작성자: 홍길동, 내용: 1번 게시글)
--(제목: board2, 작성자: 이순신, 내용: 2번 게시글)

insert into board(num,title,writer,content)
values(board_seq.nextval,'board1','홍길동','1번 게시글');

insert into board(num,title,writer,content)
values(board_seq.nextval,'board2','이순신','2번 게시글'); 
--nextval 시퀀스 다음값을 호출
commit;

select * from board;

--무결성 제약 조건(SCOTT,TBL_NN2_UNIQUE_LOGINID)에 위배 
--insert into board(num,title,writer,content)
--values(2, 'board3','강감찬','3번 게시글');

insert into board(num,title,writer,content)
values(board_seq.nextval,'board3','강감찬','3번 게시글'); 

insert into board(num,title,writer,content)
values(board_seq.nextval,'board4','강감찬2','4번 게시글'); 

insert into board(num,title,writer,content)
values(board_seq.nextval,'board5','강감찬3','5번 게시글'); 

insert into board(num,title,writer,content)
values(board_seq.nextval,'board6','강감찬4','6번 게시글'); 

insert into board(num,title,writer,content)
values(board_seq.nextval,'board7','강감찬5','7번 게시글'); 

commit;

select * from board;

--board 테이블에서 num 내림차순 후 위에서 5개 출력
select * from board order by num desc;

select rownum, b.*
from (select * from board order by num desc) b
where rownum <=3;

--board 테이블에서 num 내림차순 후 위에서 3~5개 출력
select rownum, b.*
from (select * from board order by num desc) b;

select * --rownum => rn : 별칭을 써야 칼럼으로 인식한다
from (select rownum rn, b.*
        from (select * from board order by num desc)b
        where rownum <=5) 
where rn >=3;

drop sequence board_seq;

drop table board;
-----

create table table_name(
    col1 varchar2(20) constraint table_name_col1 primary key,
    col2 varchar2(20) not null,
    col3 varchar2(20) 
);

create table table_name2(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20),
    primary key(col1)
);

create table table_name3(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20),
    constraint table_name3_pk primary key(col1) --이름있는 제약조건 만들어짐
);

create table table_name4(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20)
);
alter table table_name4
add constraint table_name4_pk primary key(col1);

--테이블 삭제
drop table table_name;
drop table table_name2;
drop table table_name3;
drop table table_name4;

