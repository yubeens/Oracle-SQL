--CTAS
--1.employees �̿��ؼ� sal_history(empid, hiredate,sal) ���̺�  ����
create table sal_history(empid,hiredate,sal)
as select employee_id, hire_date, salary
from employees;

create table sal_history as 
select employee_id as empid,
hire_date as hiredate,
salary as sal
from employees;

select * from sal_history;

--2.employees ������ �̿��ؼ� sal_history2(empid, hiredate,sal) ���̺�  ����
create table sal_history2(empid,hiredate,sal)
as select employee_id, hire_date, salary
from employees
where 1<>1;

create table sal_history2 as
select employee_id as empid,
hire_date as hiredat,
salary as sal
from employees
where 1=0; --������ ���� ������ ����

select * from sal_history2;

--3.employees ������ �̿��ؼ� sal_history3(id, hire,sal) ���̺�  ����
create table sal_history3(id,hire,sal)
as select employee_id, hire_date, salary
from employees
where 1<>1;

select * from sal_history3;

--4. sal_history/ sal_history2 /sal_history3 ���̺� ����
drop table sal_history;
drop table sal_history2;
drop table sal_history3;
--select * from sal_history3; �����ؼ� ���� 

--5.employees ������ �̿��ؼ� sal_history(empid, hiredate,sal) ���̺�  ����
create table sal_history(empid, hiredate, sal)
as select employee_id, hire_date, salary
from employees
where 1<>1;

--6.employees ���̺��� employee_id �� 200���� ū �����͸�  sal_history �� ������ �ֱ�
insert into sal_history
select employee_id, hire_date, salary
from employees
where employee_id > 200;

commit;

select * from sal_history;

--1. member  ���̺� ����
-- id ���� / name ���ڿ�(20) / address  ���ڿ�(50) /  phone ���ڿ�(20)
create table member(
    id number,
    name varchar2(20),
    address varchar2(50),
    phone varchar2(20)
);

select * from member;
describe member;

--2.�߰�
-- (100, 'ȫ�浿' ,'�λ�','010-1111-2222')
-- (101, '�̼���' ,'����','010-2222-3333')
-- (102, '������' ,'�뱸','010-4444-5555')
-- (103, '����Ŭ' ,'�λ�','010-5555-6666')
-- (104, '�����ͺ��̽�' ,'����','010-3434-7777')

insert into member(id, name, address, phone)
values(100, 'ȫ�浿' ,'�λ�','010-1111-2222');
insert into member values(101, '�̼���' ,'����','010-2222-3333');
insert into member values(102, '������' ,'�뱸','010-4444-5555');
insert into member values(103, '����Ŭ' ,'�λ�','010-5555-6666');
insert into member values(104, '�����ͺ��̽�' ,'����','010-3434-7777');

commit;

select * from member;

--3. address(����) �� member  �ο��� ���
select address, count(*)
from member
group by address;

select address ����, count(*)||'��' �ο���
from member
group by address;

select address ����, concat(count(*),'��') �ο���
from member
group by address;

select address ����, concat(count(*),'��') �ο���
from member
group by address
order by address;

--4. 102�� ����� ��ȭ��ȣ�� 010-1212-4444�� ����
update member
set phone = '010-1212-4444'
where id=102;

commit;

select * from member;

--5. 103�� ȸ�� ����
delete from member where id = 103;

select * from member;

commit;

--6. member ���̺� email(���ڿ� 30)�÷� �߰�
alter table member add(email varchar2(30));

describe member;

--7. member ���̺� email(���ڿ� 100) �÷� ����
alter table member modify(email varchar(100));

describe member;

--8. 102�� ����� email�� test@test.com ����
select * from member where id = 102;

update member 
set email = 'test@test.com'
where id = 102;

commit;

--9. member address �÷����� addr�� ����
alter table member rename column address to addr;

--10. member ���̺� ����
drop table member;

------
--1.member ���̺� ����
--num ���� / name ���ڿ� / address ���ڿ�
--phone ���ڿ� / hiredate date �⺻�� ���ó�¥
--num : ������ (member_seq / 1�� ����, 1�� ����, �ּҰ� 1 / ����Ŭ ����, ĳ�� ����)

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

--2. �߰� => num�� �ڵ� ����
--'ȫ�浿','010-1111-2222','�λ�'
insert into member(num,name,address,phone)
values(member_seq.nextval,'ȫ�浿','010-1111-2222','�λ�');
--'�̼���','010-2222-3333','�λ�'
select * from member;

insert into member(num, name, address, phone)
values(member_seq.nextval,'�̼���','010-2222-3333','����');

insert into member
values(member_seq.nextval,'������','010-4444-5555','����','25/01/01');

commit;

--������ ����
drop sequence member_seq;

--���̺� ����
drop table member;

-- ���� select * from member;

------------------------









