--DML(���۾�:data manipulation language):�����͸� �߰�,����,����==>���������۾�(insert, update, delete)
--DDL(data definition language):��ü�� ����, ����, �����ϴ� ���������Ǿ�(create,alter,drop)
--DCL

--p.291 11�� Ʈ�����
--Ʈ�����: �� �̻� ���� �� �� ���� �ּ� �������
--�ѹ��� �����Ͽ� �۾��� �Ϸ��ϰų� ��� �������� �ʰų�(�۾����)
--ALL or Nothing(commit / rollback)
--TCL

--Ʈ�����(ACID)
--A :���ڼ� (Atomicity)
--C :�ϰ���(Consistency) - �ϰ������� DB���� ����
--I :�ݸ���(Isolation) - Ʈ����� ���� �� �ٸ� Ʈ������� �۾��� ������� ���ϵ��� �����ϴ� ��
--D :���Ӽ�(Durability) - ���������� ���� �� Ʈ������� ������ �ݿ� �Ǵ� ��


--p.298 �б��ϰ���
--�ݸ�����
    --Oracle : Read Commited
    --MySQL : Repeatable Commited => Ʈ����� �������� ��ȸ�� ������ ������ �׻� ����

select * from test;
insert into test(no,name) values(3,'ȫ�浿');

update test
set name = 'ȫ�浿22'
where no = 3;

commit;


--p.327 13��
-- ������ ���� (data dictionary): �����ͺ��̽��� �����ϰ� ��ϴµ� �ʿ��� ��� Ư���� ���̺�� �����ͺ��̽��� �����Ǵ� ������ �ڵ� ����
    --USER_ : ���� �����ͺ��̽��� ������ ����ڰ� ������ ��ü ����
    --ALL_ : ��� ������ ��� ��ü ����
    --DBA_L : �����ͺ��̽� ������ ���� ����(SYS, SYSTEM ����ڸ� ���� ����)
    --VS_ : �����ͺ��̽� ���� ����
    
--�ε���
--��(view) : ������ ���̺� (���������� �������� ���� / ���Ǽ�, ���Ȼ�)

select * from dictionary;
--���� ������ ����(scott)�� ������ �ִ� ��� ���̺� ��ȸ

select table_name from user_tables;
--scott������ ������ �ִ� ��� ��ü ���� ��ȸ

select owner, table_name from all_tables;

--select * from dba_tables;
--������ ���� �����߻�


--p.336 �ε���
--����
create index idx_emp_sal
on emp(sal);

--����
drop index idx_emp_sal;

--��(view)
    --p.341 ��(view)
    create view vw_emp20
    as (select empno, ename, job, deptno
    from emp
    where deptno > 20);
    
    select * from vw_emp20; --���� ���̺�
    select * from user_views; --������ ����

    create or replace view vw_emp20 --or replace => ������ ����� ������ ��ü�϶�
    as (select empno, ename, job, deptno
    from emp
    where deptno > 20);

    --emp���̺� ��ü ������ v_emp1 �� ����
    create or replace view v_emp1
    as (select * from emp);
    
    select * from v_emp1;
    select * from user_views;
    
    --v_emp1 (3000, 'ȫ�浿', sysdate) �߰�
    insert into v_emp1(empno, ename, hiredate)
    values(3000, 'ȫ�浿', sysdate);
    
    select * from v_emp1;
    select * from emp;
    commit;
    
    --emp���̺��� 3000�� ����
    delete from emp where empno = 3000;
    commit;
    select * from emp;
    select * from v_emp1;
    
    --v_emp1���̺��� 3000�� ����
    --�ٽ� �߰�
    insert into v_emp1(empno, ename, hiredate)
    values(3000, 'ȫ�浿', sysdate);
    commit;
    
    delete from v_emp1 where empno = 3000;
    commit;
    
    select * from emp;
    select * from v_emp1;
    
    --�信�� �߰��� ������ �ϸ� �������� ���̺��� ������ �޴´�
    
    --�� v_emp1 ����
    drop view v_emp1;
    
    --emp���̺� ��ü ������ v_emp1�� ����
    create or replace view v_emp1
    as (select * from emp)
    with read only; --�б���Ѹ� �ش� (������Ʈ,����,���� �Ұ�) / �並 ���� �� ������ ���
    
    select * from v_emp1;
    
    --v_emp1 (3000, 'ȫ�浿', sysdate) �߰�
    --�����߻�(�б����� =>with read only �̹Ƿ� select �� ����)
    --insert into v_emp1(empno, ename, hiredate)
    --values(3000,'ȫ�浿',sysdate);
    
---------------------------------------------

--�μ��� �ִ�޿��� �޴� ����� �μ���ȣ, �μ���, �޿�
--dept, emp���̺� �̿�
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
--�ζ��κ�(SQL������ ��ȸ������ ����� ����ϴ� ��) => ��������, with
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
--p.346 rownum (�ǻ��÷�: pseudo column)
select * from emp;
select * from emp where rownum <=3;

select rownum, e.*
from emp e
where rownum <= 3;

--ename���� ���������Ͽ� ������ 3���� ���
select * from emp order by ename desc;

select rownum, e.*
from (select * from emp order by ename desc) e
where rownum <=3;

--ename���� ���������Ͽ� ������ 3���� 5���� ���
select rownum, e.*
from (select * from emp order by ename desc) e;

--(rownum���� ���� ���̺��� ����� ��ȸ�ؾ���.) 
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

--ename���� ���������Ͽ� ������ 3�� ���
select rownum, e.*
from (select * from emp order by ename)e
where rownum <=3;

--with ��� (p.259)
--p.347
with e as (select * from emp order by ename)
select rownum, e.*
from e
where rownum <=3;

----------------
--p.348 ������
create SEQUENCE dept_seq
increment by 10
start with 10
maxvalue 90
minvalue 0
nocycle
nocache;

select * from user_sequences;

--���̺� ���� : dept_sequence => dept ������
create table dept_sequence
as select * from dept
where 1<>1;

select * from dept_sequence;

--'DATABASE',"SEOUL'�� �߰�
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

--������ ����
drop sequence dept_seq;

--���̺� ����
drop table dept_sequence;

---------------------
--������ ����: emp_seq
--1�� ���� / 1�� ���� / ĳ�� ����, ����Ŭ ���� / �ּҰ� 1
create sequence emp_seq
increment by 1
start with 1
minvalue 1
nocache
nocycle;

--���̺� ����: emp_tmp(num, name, phone, address)
--                ����(3) ���ڿ�(20) ���ڿ�(20) ���ڿ�(70)
create table emp_tmp(
            num number(3),
            name varchar2(20),
            phone varchar2(20),
            address varchar2(70)
);

--num: emp_seq �������� ���
--name: ȫ�浿 / phone: 010-1111-2222 / address: �λ� �߰�
insert into emp_tmp 
values(emp_seq.nextval, 'ȫ�浿','010-1111-2222','�λ�');

--num: emp_seq �������� ���
--name: �̼��� / phone: 010-2222-3333 / address: �λ� �߰�
insert into emp_tmp
values(emp_seq.nextval, '�̼���','010-2222-3333','�λ�');

--num: emp_seq �������� ���
--name: �̼��� / phone: 010-2222-3333 / address: �λ� �߰�
insert into emp_tmp 
values(emp_seq.nextval, '������','010-4444-5555','����');

commit;

select * from emp_tmp;

--������ ����
alter sequence emp_seq
increment by 20
cycle;

select emp_seq.nextval from dual;
select emp_seq.nextval from dual;

--������ ����
drop sequence emp_seq;

--���̺� ����
drop table emp_tmp;

---------------------
--p.357 13�� ��������
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

--2. empidx�� �̿��ؼ� �޿��� 1500�ʰ��� ����鸸�� empidx_over15k �� ����
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

--cycle�� nocucle ����
alter sequence dept_seq
nocycle; 

--������ �߰�
select * from deptseq;
insert into deptseq values(dept_seq.nextval , 'database','seoul');
insert into deptseq values(dept_seq.nextval , 'database2','seoul2');
insert into deptseq values(dept_seq.nextval , 'database3','seoul3');
commit;

--������ ����
drop sequence dept_seq;
drop sequence empidx_seq;

--���̺� ����
drop table deptseq;

--�� ����
drop view depidx_over15k; 

--�ε��� ����
drop index idx_empidx_empno;
drop table empidx;

---------------------------
--p.360 14�� ��������
 --notnull - ���� ������� �ʴ�
 --unique - �ߺ����� �ʴ� ��
 --primary key(�⺻Ű) => notnull/unique�� ���������� Ư���� ��� ������ �������� 
 --������ �ߺ��� ������� �ʰ� null�� ������� ����
 --foreign key(�ܷ�Ű)
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

--�����߻�
--insert into table_notnull(login_id,tell) --login pw => not null
--values('dd','010-2222-4444);

---------
create table table_notnull2(
login_id varchar2(20) constraint tbl_nn2_loginID not null,
login_pw varchar2(20) constraint tbl_nn2_loginpw not null,
tel varchar(20)
);

--�������� Ȯ��
select * from user_constraints;

select * from user_constraints
where table_name = 'TABLE_NOTNULL'; --���̺���� �빮�ڷ�

select owner, constraint_name
from user_constraints
where table_name = 'TABLE_NOTNULL2';

select * from table_notnull2;

insert into table_notnull2 values('aa','1111','010-1111-2222');
insert into table_notnull2 values('aa','1111','010-1111-2222');

commit;

select * from table_notnull2;

--�������� ���� => tel�� not null
alter table table_notnull2
modify(tel constraint tbl_nn2_tel not null);

--�����߻� - notnull������������ �Ұ�
--insert into tabl_notnull2(logint_id, login_pw)
--values ('cc','3333');

--�������� ���� => login_id unique ���� �ο�
delete from table_notnull2;

alter table table_notnull2
modify(login_id constraint tbl_nn2_unique_loginID UNIQUE);

insert into table_notnull2 values('aa','1111','010-1111-2222');

--���Ἲ ���� ����(SCOTT,TBL_NN2_UNIQUE_LOGINID)�� ���� (notnull �ߺ�)
insert into table_notnull2 values('aa','2222','010-1111-3333');

--�������� ���� table_notnull2 ���̺��� tel�� ������ �������� ����
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

--���Ἲ ���� ����(SCOTT,TBL_NN2_UNIQUE_LOGINID)�� ���� 
insert into table_unique(login_id, login_pw,tel)
values('aa','1111','010-1111-2222'); --aa �ߺ� ����

insert into table_unique(login_id, login_pw,tel)
values(null,'1111','010-1111-2222'); --����

commit;

select * from table_unique;

--���̺� ����
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

--���Ἲ ���� ����(SCOTT,TBL_NN2_UNIQUE_LOGINID)�� ���� 
-->login_id : primary key(�⺻Ű) = not null / unique
insert into table_pk(login_id,login_pw,tel)
values('aa','1111','010-1111-2222'); --aa�� �ߺ�(unique�ƴ�)���� ����

insert into table_pk(login_id,login_pw,tel)
values(null,'1111','010-1111-2222'); --�����߻�(null �ȵ�)

drop table table_pk;

------------------------
--1) ������ �� ���̺� ����
--board(num, title, writer, content, regdate)
--     number                         date(�⺻�� : sysdate)
--num : �⺻Ű <- ������ �̿�
--������ ����: board_seq = 1/1/1/ no cycle, no cache

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

--2)������ �߰�
--(����: board1, �ۼ���: ȫ�浿, ����: 1�� �Խñ�)
--(����: board2, �ۼ���: �̼���, ����: 2�� �Խñ�)

insert into board(num,title,writer,content)
values(board_seq.nextval,'board1','ȫ�浿','1�� �Խñ�');

insert into board(num,title,writer,content)
values(board_seq.nextval,'board2','�̼���','2�� �Խñ�'); 
--nextval ������ �������� ȣ��
commit;

select * from board;

--���Ἲ ���� ����(SCOTT,TBL_NN2_UNIQUE_LOGINID)�� ���� 
--insert into board(num,title,writer,content)
--values(2, 'board3','������','3�� �Խñ�');

insert into board(num,title,writer,content)
values(board_seq.nextval,'board3','������','3�� �Խñ�'); 

insert into board(num,title,writer,content)
values(board_seq.nextval,'board4','������2','4�� �Խñ�'); 

insert into board(num,title,writer,content)
values(board_seq.nextval,'board5','������3','5�� �Խñ�'); 

insert into board(num,title,writer,content)
values(board_seq.nextval,'board6','������4','6�� �Խñ�'); 

insert into board(num,title,writer,content)
values(board_seq.nextval,'board7','������5','7�� �Խñ�'); 

commit;

select * from board;

--board ���̺��� num �������� �� ������ 5�� ���
select * from board order by num desc;

select rownum, b.*
from (select * from board order by num desc) b
where rownum <=3;

--board ���̺��� num �������� �� ������ 3~5�� ���
select rownum, b.*
from (select * from board order by num desc) b;

select * --rownum => rn : ��Ī�� ��� Į������ �ν��Ѵ�
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
    constraint table_name3_pk primary key(col1) --�̸��ִ� �������� �������
);

create table table_name4(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20)
);
alter table table_name4
add constraint table_name4_pk primary key(col1);

--���̺� ����
drop table table_name;
drop table table_name2;
drop table table_name3;
drop table table_name4;

