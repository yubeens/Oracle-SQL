--1.ACCOUNTING(dname) 부서 소속 사원의 이름과 입사일 출력
select * from dept;
select * from emp;

select empno, hiredate,dname,e.deptno
from emp e, dept d
where e.deptno = d.deptno and dname = 'ACCOUNTING';
---SQL-99 표준문법
select empno, hiredate
from emp e join dept d 
            on e.deptno = d.deptno
where dname = 'ACCOUNTING';
--2. 0보다 많은 comm 을 받는 사원이름과 부서명 출력
select * from emp;
select ename, dname,comm
from emp e, dept d
where e.deptno=d.deptno and comm > 0;

select ename, dname,comm
from emp e, dept d
where e.deptno = d.deptno
and comm is not null and comm <> 0;
-- join ~ on
select ename, dname
from emp e join dept d
      on e.deptno = d.deptno
where comm > 0; 

select ename, dname, comm
from emp e join dept d 
on e.deptno = d.deptno
where comm is not null and comm <> 0;
--3. 누구의 매니저는 누구입니다.
-- 예) SMITH 의 매니저는  FORD 입니다.
select e.ename 사원, m.ename 상사
from emp e, emp m
where e.mgr = m.empno
order by e.ename;
---
 --예) SMITH 의 매니저는  FORD 입니다.
select e.ename||' 의 매니저는 '|| m.ename ||'입니다.' 사원_상사
from emp e, emp m
where e.mgr = m.empno
order by e.ename;
--jon~on
select e.ename || '의 매니저는 ' || m.ename || ' 입니다' 사원_매니저
from emp e join emp m 
           on e.mgr = m.empno
order by e.ename; 
-------------
select * from emp;
select * from dept;
--1.뉴욕(NEW YORK)에서 근무하는 사원의 이름(ename), 급여(sal) 출력
select e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and d.loc = 'NEW YORK';
--join~on
select e.ename 사원이름, e.sal 급여,d.loc 근무지역
from emp e join dept d
            on e.deptno = d.deptno
where d.loc = 'NEW YORK';  
--2. 매니저(mgr)가 KING 인 사원들의 이름과 직급을 출력
-- KING 의  empno
select empno from emp where ename = 'KING';  -- 7839
select ename, job
from emp
where mgr = 7839;

select ename, job
from emp
where mgr = (select empno
            from emp
            where ename ='KING');
 --self join
 select e.ename, e.job
 from emp e, emp m
 where e.mgr = m.empno and m.ename = 'KING';
 --3.SMITH 동료(SMITH 와 같은 부서)  의 이름 출력
select deptno from emp where ename = 'SMITH';
select ename
from emp
where deptno = 20;

select ename
from emp
where deptno = (select deptno from emp where ename = 'SMITH')
and ename <> 'SMITH';

--self join
select f.ename
from emp e, emp f
where e.deptno = f.deptno
and e.ename = 'SMITH' and f.ename <> 'SMITH';

--join~on
select f.ename
from emp e inner join emp f
           on e.deptno = f.deptno
where  e.ename = 'SMITH' and f.ename <> 'SMITH';  

----p229
select * from emp;--12  출력
-- 사원번호, 사원이름, 상사(mgr) 상사사원번호, 상사이름
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename  -- 11개 출력
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;

--외부조인(outer join)
--모든 사원에 대해 사원번호, 사원이름, 상사(mgr) 상사사원번호, 상사이름
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename  -- 11개 출력
from emp e1, emp e2
where e1.mgr = e2.empno(+)
order by e1.empno;

--join~on
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1 left outer join emp e2   --왼쪽이 사원테이블
            on e1.mgr =e2.empno
order by e1.empno;   

select e.empno, e.ename, e.mgr, m.empno, m.ename
from emp m right outer join emp e    -- 오른쪽 사원테이블
            on e.mgr =m.empno
order by e.empno; 
------
--사원이름(ename), 부서번호(deptno), 부서명(dname)
select * from emp;
select * from dept;

select ename 사원이름, e.deptno 부서번호, dname 부서명
from emp e, dept d
where e.deptno = d.deptno;
-- 모든 부서의 정보 출력 ==> 사원이름(ename), 부서번호(deptno), 부서명(dname)
select ename 사원이름, d.deptno 부서번호, dname 부서명
from emp e, dept d
where e.deptno(+) = d.deptno
order by d.deptno;

select ename 사원이름, d.deptno 부서번호, dname 부서명
from emp e right outer join dept d
     on e.deptno = d.deptno
order by d.deptno;

select ename 사원이름, d.deptno 부서번호, dname 부서명
from dept d left outer join emp e
     on e.deptno = d.deptno
order by d.deptno;
---p232
--sal 2000보다 큰 사원번호, 이름 ,급여, 상사, 부서번호, 부서명,지역 출력
select d.deptno,empno, ename, sal, mgr, dname, loc
from emp e, dept d
where e.deptno = d.deptno
and e.sal > 2000
order by deptno, e.empno;
---SQL-99 표준
select * from emp;
select * from dept;
--NATURAL JOIN
select deptno,e.empno, e.ename, e.sal, e.mgr, d.dname, d.loc
from emp e natural join dept d
where e.sal > 2000;
--join~using
select deptno, e.empno, e.ename,e.sal, e.mgr, d.dname, d.loc
from emp e join dept d using(deptno)
where e.sal > 2000;
--p240 join~on : 가장 많이 사용하는 방법
select d.deptno, empno, ename, sal, mgr, dname, loc
from emp e join dept d
           on e.deptno = d.deptno
 where e.sal > 2000;
 
 --p238
 --emp, dept 테이블
 --급여(sal)가 2000 이상이며 직속상관(mgr)이 반드시 있어야 함
 --empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc 출력
 select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, 
        d.deptno, d.dname,d.loc
 from emp e, dept d
 where e.deptno = d.deptno 
 and sal >=2000 and e.mgr is not null;
 
 --join~using
 select   e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, 
          deptno, d.dname, d.loc
 from emp e join dept d using(deptno)
 where sal >=2000 and e.mgr is not null;
 -- natural join
 select  e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, 
         deptno, d.dname, d.loc
 from emp e natural join dept d
 where sal >=2000 and e.mgr is not null;
 
 --join~on
 select  e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm,
         d.deptno, d.dname, d.loc
 from emp e join dept d 
            on e.deptno = d.deptno
 where sal >=2000 and e.mgr is not null;           
 
 --8장연습문제(p239~240)
 --1.sal이 2000초과인 사원들의 부서정보, 사원정보
 select d.deptno, d.dname, e.empno, e.ename, e.sal
 from emp e, dept d
 where e.deptno = d.deptno
 and e.sal > 2000
 order by e.deptno asc;
 --natural join
 select  deptno, d.dname, e.empno, e.ename, e.sal
 from emp e natural join dept d
 where e.sal > 2000
 order by deptno asc;
 
 -- join using
  select  deptno, d.dname, e.empno, e.ename, e.sal
 from emp e join dept d USING(deptno)
 where e.sal > 2000
 order by deptno asc;
 
 --join on
 select  d.deptno, d.dname, e.empno, e.ename, e.sal
 from emp e join dept d 
             on e.deptno = d.deptno
 where e.sal > 2000
 order by d.deptno asc;
 --2.각 부서별(부서번호, 부서명) 평균급여, 최대급여, 최소급여, 사원 수 출력
select e.deptno, d.dname, round(avg(sal)), max(sal), min(sal), count(*)
from emp e, dept d
where e.deptno = d.deptno
group by e.deptno, d.dname
order by e.deptno;
---
select deptno, d.dname, round(avg(sal)), max(sal), min(sal), count(*)
from emp e NATURAL join dept d
group by deptno, d.dname
order by deptno;

select deptno, d.dname, round(avg(sal)), max(sal), min(sal), count(*)
from emp e  join dept d using(deptno)
group by deptno, d.dname
order by deptno;

select e.deptno, d.dname, round(avg(sal)), max(sal), min(sal), count(*)
from emp e  join dept d on e.deptno = d.deptno
group by e.deptno, d.dname
order by e.deptno;
--3. 모든 부서정보와 사원정보
--부서번호, 부서명, 사원번호,사원이름 ,job,sal
-- + 
select d.deptno, d.dname, e.empno, e.ename,job,sal
from emp e ,dept d
where e.deptno(+) = d.deptno
order by e.deptno;
--outer join
select d.deptno, d.dname, e.empno, e.ename,job,sal
from emp e  right outer join dept d
on e.deptno = d.deptno
order by e.deptno;

select d.deptno, d.dname, e.empno, e.ename,job,sal
from dept d  left outer join emp e
on e.deptno = d.deptno
order by e.deptno;
--4.모든 부서정보, 사원정보, 급여등급정보
--각 사원의 직속 상관의 정보를 부서번호, 사원번호 순으로 정렬
-- deptno, dname, empno, ename,mgr, deptno_1, losal, hisal,
-- grade,mgr_empno, mgr_ename
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.deptno,
       s.losal, s.hisal, s.grade, m.empno mgr_empno, m.ename mgr_ename
from emp e, dept d, salgrade s, emp m
where e.deptno(+) = d.deptno
  and e.sal between s.losal(+) and s.hisal(+)
  and e.mgr = m.empno(+)
order by d.deptno, e.empno;
-----
--join~on
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.deptno,
       s.losal, s.hisal, s.grade, m.empno mgr_empno, m.ename mgr_ename
from emp e right outer join  dept d on (e.deptno = d.deptno)
     left outer join salgrade s on (e.sal between s.losal and s.hisal)
     left outer join emp m on (e.mgr = m.empno)
order by d.deptno, e.empno;
--------------------------
--p242  서브쿼리(SQL 내부에 사용하는  select  문 의미)
--WARD 사원보다 월급을 많이 받는 사원 이름 출력
select sal from emp where ename ='WARD';
select ename from emp where sal > 1250;

select ename
from emp
where sal > (select sal from emp where ename='WARD');
--'ALLEN' 의 직무(job)와 같은 사람의 이름(ename),부서명(dname),급여(sal) 직무(job) 출력
select job from emp where ename = 'ALLEN';

select e.ename, d.dname, e.sal, e.job
from emp e, dept d
where e.deptno = d.deptno
and job = (select job from emp where ename = 'ALLEN')
and ename <> 'ALLEN';

--  전체 사원의 평균 임금보다 많은 사원의
--사원번호(empno), 이름(ename), 부서명(dname), 입사일(hiredate) 출력
select e.empno, e.ename, d.dname, e.hiredate,e.sal
from emp e, dept d
where e.deptno = d.deptno
and e.sal > (select avg(sal) from emp);

--ALLEN 보다 일찍 입사한 사원의 정보
select *
from emp
where hiredate < (select hiredate 
                    from emp 
                    where ename ='ALLEN');

--p248
--전체 사원의 평균급여보다 작거나 같은 급여를 받는 20번 부서의 사원 및 부서정보
-- empno, ename, job, sal, deptno, dname, loc
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.sal  <= (select avg(sal) from emp)
and d.deptno = 20;

--natural join
select e.empno, e.ename, e.job, e.sal, deptno, d.dname, d.loc
from emp e natural join dept d
where  e.sal  <= (select avg(sal) from emp)
and deptno = 20;
--join using
select e.empno, e.ename, e.job, e.sal, deptno, d.dname, d.loc
from emp e  join dept d using(deptno)
where  e.sal  <= (select avg(sal) from emp)
and deptno = 20;
--join on
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
from emp e  join dept d  on e.deptno = d.deptno
where  e.sal  <= (select avg(sal) from emp)
and d.deptno = 20;

---  각 부서별 최고급여와 동일한 급여를 받는 사원 정보 출력
--각 부서별 최고급여
select  deptno, max(sal)
from emp
group by deptno;

select *
from emp
where (deptno, sal) in (select deptno, max(sal)
                        from emp
                        group by deptno);

select *
from emp
where sal in (select  max(sal)
                      from emp
                      group by deptno);
                      
select * from emp where sal in (2850,5000,3000);                    







  















