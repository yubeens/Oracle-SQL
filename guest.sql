--15)
ALTER TABLE dept
ADD CONSTRAINT pk_deptno PRIMARY KEY (deptno);

create table student(
    studno NUMBER PRIMARY KEY,
    name VARCHAR2(10) not null UNIQUE,
    deptno CHAR(3),
    grade NUMBER(1) CHECK (grade BETWEEN 1 AND 4),
    profno NUMBER,
    CONSTRAINT fk_deptno FOREIGN KEY (deptno)
    REFERENCES dept(deptno)
);
/
--16)
DESC dept;

ALTER TABLE dept
MODIFY deptno NUMBER;

drop constraint fk_deptno;
select * from user_constraints;

CREATE TABLE professor (
    profno NUMBER PRIMARY KEY,          
    name VARCHAR2(50) NOT NULL,       
    deptno CHAR(3),                       
    position VARCHAR2(20),             
    pay NUMBER,                          
    CONSTRAINT fk_professor_deptno FOREIGN KEY (deptno) 
        REFERENCES dept(deptno)       
);
commit;


insert into dept(deptno, dname) values (101,'�濵�а�');
insert into dept(deptno, dname) values (102,'��ǻ�Ͱ��а�');
insert into dept(deptno, dname) values (103,'�����а�');

select * from dept;

insert into student(studno, name, grade, deptno, profno) values (101,'�����',1,101,1001);

insert into student(studno, name, grade, deptno, profno) values (102,'��ο�',2,101,1003);
insert into student(studno, name, grade, deptno, profno) values (103,'����ȯ',3,101,1001);
insert into student(studno, name, grade, deptno, profno) values (104,'������',4,101,1003);
insert into student(studno, name, grade, deptno, profno) values (105,'������',1,102,1002);
insert into student(studno, name, grade, deptno, profno) values (106,'����',2,102,null);
insert into student(studno, name, grade, deptno, profno) values (107,'������',3,102,1002);
insert into student(studno, name, grade, deptno, profno) values (108,'�����',1,103,1004);
insert into student(studno, name, grade, deptno, profno) values (109,'�ڿ���',2,103,1006);
insert into student(studno, name, grade, deptno, profno) values (110,'������',3,103,null);

select * from student;

commit;





select * from professor;

INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1001, 'ȫ�浿', 101, '������', 450);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1002, '�迬��', 102, '������', 400);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1003, '������', 101, '�α���', 350);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1004, '���±�', 103, '������', 410);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1005, '������', 101, '���Ӱ���', 250);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1006, '�����', 103, '�α���', 350);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1007, '������', 102, '���Ӱ���', 320);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1008, '������', 103, '���Ӱ���', 200);

select * from student;

--------------------------------------

--17)
select * from professor;
select p.name ������, d.dname �а���, p.pay �޿�
from professor p
join dept d on p.deptno = d.deptno
where p.pay = (select max(pay)
                from professor
                where deptno = p.deptno
);

select * from student;
update student set name = '�̱���'
where studno =101;

----------
GRANT SELECT ON guest.student TO scott;

REVOKE SELECT ON guest.student FROM scott;




