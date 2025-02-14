--���������� ����� �����տ� c## 
--c##�� ������ �ʰ� ����� ���� �����ϱ� ���� session ����

alter session set "_oracle_script" = true;

--1.����� ���� : test_user // ��� : 1234
create user test_user IDENTIFIED by 1234;

--2.test_user => ���ӱ���(create session)�ο�
grant create session to test_user; 
grant unlimited tablespace to test_user; --test table

--3.��� ����: abcd
alter user test_user identified by abcd;

--4.test_user ����
drop user test_user; --���� : ���� ���ӵǾ� �־� �Ұ�
drop user test_user; -- ���� ���� �� ����
--����(����) �Ұ�
drop user test_user cascade; --�����ִ� ������ ������ �����Ǿ��ִ� �� ���� ����

-------------------
--p.412 ��(role)
--connect �� : create session ����
--resource �� : ���̺�, ������ �� ��ü ���� ����

--1.����� ����
create user test_user identified by abcd; 

--2.���� �ο�
grant connect, resource, unlimited tablespace to test_user;

--3.���� ���� => test_user�� connect�� ���Ѹ� ���� 
revoke connect from test_user;

--test_user ����
drop user test_user;

--------------------------
--p.416 15�� ��������
--1.prev_hw �輺����(��� orcl)���� �����ϵ��� ���� => �����ڰ������� �۾�
create user PREV_HW identified by orcl;
grant connect, resource, unlimited tablespace to PREV_HW;

--2.scott�������� �����ؼ� PREV_HW�� emp, dept, salgrade���̺��� select ���� �ο�
--grant select on emp to PREV_HW;
--grant select on dept to PREV_HW;
--grant select on salgrade to PREV_HW;

--2.scott�������� �����ؼ� PREV_HW�� emp, dept, salgrade���̺��� select ���� �ο�
--grant select on emp to PREV_HW;
--grant select on dept to PREV_HW;
--grant select on salgrade to PREV_HW;

--3.2���� �ο��� ���� ���
--revoke select on emp from PREV_HW;
--revoke select on dept from PREV_HW;
--revoke select on salgrade from PREV_HW;

--4.PREV_HW ����
drop user prev_hw cascade;






