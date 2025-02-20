--��)ȣ��-->����
--1) HOTEL (hotel_id,name,grade,address)
--hotel_id �⺻Ű => ������ : hotel_seq
--(HOTEL ���̺� ����)
CREATE TABLE HOTEL(
    hotel_id NUMBER PRIMARY KEY,
    name VARCHAR2(3),
    grade VARCHAR2(10),
    address VARCHAR2(70)
);
--(HOTEL ������ ����)
CREATE SEQUENCE hotel_seq 
INCREMENT BY 1
START WITH 1 
MINVALUE 1
NOCACHE
NOCYCLE;

--2) review(num,title, content, regdate)
--num : �⺻Ű => ������ : review_seq
--regdate date�� => ���ó�¥�� �⺻��
--(REVIEW ���̺� ����)
CREATE TABLE REVIEW(
    num NUMBER(3) CONSTRAINT review_pk PRIMARY KEY,
    title VARCHAR2(30),
    content VARCHAR2(200),
    regdate DATE DEFAULT SYSDATE,
    hid NUMBER(3) CONSTRAINT review_fk
    REFERENCES hotel(hotel_id)
);

--(REVIEW ������ ����)
CREATE SEQUENCE review_seq
INCREMENT BY 1
START WITH 1 
MINVALUE 1
NOCACHE
NOCYCLE;

--3)hotel�� �������� review�� ���� �� �ִ�
-- =>�ܷ�Ű �ο�
--------------

--employees / departments
--�μ��� �������� ����� ������
alter table employees
add CONSTRAINT departments_fk foreign key(department_id)
references departments(department_id); 

--�������� Ȯ��
select * from user_constraints;
select constraint_name, constraint_type, table_name
from user_constraints;

--ȣ��, ���� ���̺� ����
drop table hotel;
drop table review;

select constraint_name, constraint_type, table_name
from user_constraints
where table_name='REVIEW';
