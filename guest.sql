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


insert into dept(deptno, dname) values (101,'경영학과');
insert into dept(deptno, dname) values (102,'컴퓨터공학과');
insert into dept(deptno, dname) values (103,'영문학과');

select * from dept;

insert into student(studno, name, grade, deptno, profno) values (101,'김기현',1,101,1001);

insert into student(studno, name, grade, deptno, profno) values (102,'김민영',2,101,1003);
insert into student(studno, name, grade, deptno, profno) values (103,'김정환',3,101,1001);
insert into student(studno, name, grade, deptno, profno) values (104,'김준태',4,101,1003);
insert into student(studno, name, grade, deptno, profno) values (105,'김지용',1,102,1002);
insert into student(studno, name, grade, deptno, profno) values (106,'김진',2,102,null);
insert into student(studno, name, grade, deptno, profno) values (107,'김찬권',3,102,1002);
insert into student(studno, name, grade, deptno, profno) values (108,'김옥규',1,103,1004);
insert into student(studno, name, grade, deptno, profno) values (109,'박원영',2,103,1006);
insert into student(studno, name, grade, deptno, profno) values (110,'박의종',3,103,null);

select * from student;

commit;





select * from professor;

INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1001, '홍길동', 101, '정교수', 450);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1002, '김연아', 102, '정교수', 400);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1003, '박지성', 101, '부교수', 350);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1004, '김태근', 103, '정교수', 410);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1005, '서찬수', 101, '전임강사', 250);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1006, '김수현', 103, '부교수', 350);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1007, '정동진', 102, '전임강사', 320);
INSERT INTO professor (profno, name, deptno, position, pay) VALUES (1008, '임진영', 103, '전임강사', 200);

select * from student;

--------------------------------------

--17)
select * from professor;
select p.name 교수명, d.dname 학과명, p.pay 급여
from professor p
join dept d on p.deptno = d.deptno
where p.pay = (select max(pay)
                from professor
                where deptno = p.deptno
);

select * from student;
update student set name = '이기현'
where studno =101;

----------
GRANT SELECT ON guest.student TO scott;

REVOKE SELECT ON guest.student FROM scott;




