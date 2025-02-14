--�ܷ�Ű
--�μ�: dept_fk(�μ���ȣ,�μ���,����)
create table dept_fk(
    deptno number(5) constraint dept_fk_deptno_pk primary key ,
    dname varchar2(20),
    loc varchar2(50)
);

--���: emp_fk(�����ȣ, ����̸�, ��å, �μ���ȣ)
create table emp_fk(
    empno number(2) constraint emp_fk_empno_pk primary key,
    ename varchar2(20),
    job varchar2(20),
    deptno number(5)
);

--������ �߰�
insert into dept_fk values(10,'����','�λ�');
insert into dept_fk values(20,'����2','�λ�2');

insert into emp_fk values(1,'ȫ�浿','���',10);

commit;

select * from dept_fk;
select * from emp_fk;

insert into emp_fk values(2,'�̼���','���',30);
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

--������ �߰�
insert into dept_fk1 values(10,'����','�λ�');
insert into dept_fk1 values(20,'����2','�λ�2');
select * from dept_fk1;

insert into emp_fk1 values(1,'ȫ�浿','���',10);
select * from emp_fk1;

commit;

--���Ἲ ��������(SCOTT.EMP_FK1_DEPTNO_FK)�� ���� 
--dept_fk1�� 30�� �μ��� ���� ������ ����(�θ�Ű�� ����)
insert into emp_fk1 values(2,'�̼���','���',30);
--���� : null����
insert into emp_fk1 values(2,'�̼���','���', null); 

insert into emp_fk1 values(3,'������','����', 10); 
commit;
select * from emp_fk1;

--1�� ��� ����
delete from emp_fk1 where empno=1;

--20�� �μ� ����
delete from dept_fk1 where deptno=20;
select * from emp_fk1;

--10�� �μ� ���� 
--(����:���Ἲ ��������(SCOTT.EMP_FK1_DEPTNO_FK)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�) 
delete from dept_fk1 where deptno=10;

--2�� ����� �μ���ȣ�� 30���� ����
--(����:dept_fk1���̺� 30�� �μ��� ����)
update emp_fk1
set deptno = 30
where empno =2;

--�ܷ�Ű ���������� ����
alter table emp_fk1
drop constraint emp_fk1_deptno_fk;

insert into emp_fk1 values(4,'aaa','����',30); --����(�ܷ�Ű �������� ����)
select * from emp_fk1;
delete from emp_fk1 where empno=4;
commit;

--�ܷ�Ű ���������� �߰�
alter table emp_fk1
add constraint emp_fk1_deptno_fk1 foreign key(deptno)
references dept_fk1(deptno);

select * from dept_fk1;

--10�� �μ� ����
--(����: ���Ἲ ��������(SCOTT.EMP_FK1_DEPTNO_FK1)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�)
delete from dept_fk1 where deptno=10;

--�ܷ�Ű �������� ����
alter table emp_fk1
drop constraint emp_fk1_deptno_fk1;

--�ܷ�Ű �������� �߰�
alter table emp_fk1
add constraint emp_fk1_deptno_fk1 foreign key(deptno)
references dept_fk1(deptno)
on delete cascade; --���� �� �θ� �����Ǹ� �ڽĵ� ����

--10�� �μ� ����
delete from dept_fk1 where deptno =10; --����
select * from emp_fk1; --10�� �μ� �Ҽӻ���� ����

--������ �ܷ�Ű �������� ����

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

--���̺� �߰�
--����: üũ ��������(SCOTT.TB_CHECK_LOGINPWD)�� ����Ǿ����ϴ�
insert into table_check(login_ID, login_pwd, tel)
values('aa','1234','010-1111-2222');

--����
insert into table_check(login_ID, login_pwd, tel)
values('aa','123456','010-1111-2222');

commit;

---------------------
--Member(userid, username, tel)
--�⺻Ű userid �������� pk_member
create table member(
    userid varchar2(20) constraint pk_member primary key,
    username varchar2(20),
    tel varchar2(20)
);
--Board(num, title, name, content, regdate(���ó�¥ ����Ʈ��))
--�⺻Ű : num(��������: board_seq) / �������� pk_board)
--�ܷ�Ű : userid / �������� fk_board
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

--comments(cnum, msg, regdate(���ó�¥ ����Ʈ��))
----�⺻Ű : cnum(��������: comments_seq) / �������� pk_comments)
--�ܷ�Ű : userid / �������� fk_comments
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

--member�߰�
insert into member values('a1','ȫ�浿','010-1111-2222');
commit;

select * from member;

--board(num, title, content, regdate, userid)�߰�
insert into board values(board_seq.nextval, '����1','����1', sysdate, 'a1');
select * from board;
commit;

--comments(cnum, msg, redate, userid, bnum)�߰�
select * from comments;
insert into comments values(comments_seq.nextval, '�޼���1', sysdate, 'a1', 1);

insert into comments values(comments_seq.nextval, '���1', sysdate, 'a1', 1);
insert into comments values(comments_seq.nextval, '���2', sysdate, 'a1', 1);
insert into comments values(comments_seq.nextval, '���3', sysdate, 'a1', 1);
insert into comments values(comments_seq.nextval, '���4', sysdate, 'a1', 1);

commit;

select * from member;
select * from board;
select * from comments;

--1�� �Խñ��� �� ����� �̸��� ���
select username
from board
    natural join member
where num = 1;

--member �߰�
insert into member values('b1','�̼���','010-1111-3333');

--board �߰�
insert into board values(board_seq.nextval, '����2','����2', sysdate, 'b1');

--comments �߰�
insert into comments values(comments_seq.nextval, '���11', sysdate, 'b1', 3);
insert into comments values(comments_seq.nextval, '���22', sysdate, 'b1', 3);
insert into comments values(comments_seq.nextval, '���33', sysdate, 'b1', 3);

commit;

select * from member;
select * from board;
select * from comments;

--member�� ��� �� ���(userid, ��� ��)
select userid, count(*)��ۼ�
from comments
group by userid;

--member�� ��� ���� �̸� ���(userid, ��� ��, username)
select m.username,m.userid, count(*)��ۼ�
from comments c , member m
where c.userid = m.userid
group by m.userid,username;

--join
select m.username,m.userid, count(*)��ۼ�
from comments c join member m
on c.userid = m.userid
group by m.userid,username;

select username,userid, count(*)��ۼ�
from comments c natural join member m
group by userid,username;

select username,userid, count(*)��ۼ�
from comments c join member m using(userid)
group by userid,username;

--�ζ��κ�
select m.username,m.userid, ��ۼ�
from (select userid, count(*)��ۼ�
        from comments
        group by userid) c, member m
where c.userid = m.userid;

--member���̺� a1����
--�ܷ�Ű ���� ���ǿ��� �۾�����(no action)�����Ǿ� �ڽ��� ���� ��� ���� �Ұ�
delete from member where userid='a1';--����

--board���̺��� �������� Ȯ��
select * from user_constraints where table_name = 'BOARD';

select * from student;
select * from professor;

--scott student / professor / department
--student �ܷ�Ű �ο� (student�� deptno => professor�� deptno)
alter table student
add constraint student_fk
foreign key (profno)
references professor(profno);

--professor �ܷ�Ű �ο� (professor�� deptno => department�� deptno)
alter table professor
add constraint professor_fk
foreign key (deptno)
references department(deptno);

-----------------
--p.394 14�� ��������
--������
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
--p.396 15�� �����,����,�� ����
--����� / �����ͺ��̽� ��Ű��
--�� : scott - �����
--scott�� ������ ���̺�, ��������, ������ �� �����ͺ��̽����� ���� ��� ��ü�� ��Ű��
--����� ���� => ������ ����

--------------------------
--p.416 15�� ��������
--1.prev_hw �輺����(��� orcl)���� �����ϵ��� ���� => �����ڰ������� �۾�
--create user PREV_HW identified by orcl;
--grant connect, resource, unlimited tablespace to PREV_HW;

--2.scott�������� �����ؼ� PREV_HW�� emp, dept, salgrade���̺��� select ���� �ο�
grant select on emp to PREV_HW;
grant select on dept to PREV_HW;
grant select on salgrade to PREV_HW;

--3.2���� �ο��� ���� ���
revoke select on emp from PREV_HW;
revoke select on dept from PREV_HW;
revoke select on salgrade from PREV_HW;
 
--4.PREV_HW ���� => ������ �������� �۾�

