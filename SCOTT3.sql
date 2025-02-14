--1.ACCOUNTING(dname) 부서 소속 사원의 이름과 입사일 출력
select * from dept;
select * from emp;

select empno, hiredate, dname, e.deptno
from emp e, dept d
where e.deptno = d.deptno and dname = 'ACCOUNTING';

--SQL99 표준문법
select empno, hiredate
from emp e join dept d 
            on e.deptno = d.deptno
where dname = 'ACCOUNTING';

--2. 0보다 많은 comm을 받는 사원이름과 부서명 출력
select * from emp;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno and comm > 0;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno
and comm is not null and comm <> 0;

--join ~ on
select ename, dname
from emp e join dept d
        on e.deptno = d. deptno
where comm > 0;

select ename, dname, comm
from emp e join dept d
on e.deptno = d.deptno
where comm is not null and comm <>0;

--3. 누구의 매니저는 누구 입니다.
select e.ename 사원, m.ename 상사
from emp e, emp m
where e.mgr = m.empno
order by e.ename;

--예) SMITH의 매니저는 FORD 입니다.
select e.ename||' 의 매니저는 '|| m.ename ||'입니다.' 사원_상사
from emp e, emp m
where e.mgr = m.empno
order by e.ename;

--join~on
select e.ename||' 의 매니저는 '|| m.ename ||'입니다.' 사원_매니저
from emp e join emp m
            on e.mgr = m.empno
order by e.ename;

-------------------
select * from emp;
select * from dept;

--1. 뉴욕에서 근무하는 사원의 이름(ename), 급여(sal), 출력
select d.loc,e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and d.loc = 'NEW YORK';
    
--join ~ on
select e.ename 사원이름, e.sal 급여, d.loc 근무지역
from emp e join dept d
           on e.deptno = d.deptno
where d.loc = 'NEW YORK';

--2. 매니저(mgr)가 KING인 사원들의 이름과 직급을 출력
select * from emp;
--KING의 empno
select empno from emp where ename = 'KING'; --7839

select ename, job
from emp
where mgr = 7839;

select ename, job
from emp
where mgr = (select empno
            from emp
            where ename = 'KING');

--self join
select e.ename, e.job
from emp e, emp m
where e.mgr = m.empno and m.ename = 'KING';

--3. SMITH 동료(SMITH와 같은 부서)의 이름 출력
select deptno from emp where ename = 'SMITH';

select ename
from emp
where deptno = 20;

select ename
from emp
where deptno = (select deptno 
                from emp 
                where ename = 'SMITH')
and ename <> 'SMITH';

--self join
select f.ename
from emp e, emp f
where e.deptno = f.deptno
and e.ename = 'SMITH' and f.ename <> 'SMITH';

--join ~ on
select f.ename
from emp e join emp f
            on e.deptno = f.deptno
where e.ename = 'SMITH' and f.ename <> 'SMITH';

--p.229
select * from emp; --12개 출력
--사원번호, 사원이름, 상사(mgr) 상사사원번호, 상사이름 출력
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename --11개 출력 (KING은 상사없음 - null은 출력되지 않음.)
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;

--외부조인(outer join)
--모든 사원에 대해 사원번호, 사원이름, 상사, 상사사원번호, 상사이름 출력
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename --11개 출력 (KING은 상사없음 - null은 출력되지 않음.)
from emp e1, emp e2
where e1.mgr = e2.empno(+) --null쪽이 부족한 테이블에 +가 들어감
order by e1.empno;

--join ~ on
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1 left outer join emp e2 --왼쪽이 사원테이블
            on e1. mgr = e2.empno
order by e1.empno;

select e.empno, e.ename, e.mgr, m.empno, m.ename
from emp m right outer join emp e --오른쪽 사원테이블
            on e.mgr = m.empno
order by e.empno;

-------
--사원이름(ename), 부서번호(deptno), 부서명(dname)
select * from emp;
select * from dept;

select ename 사원이름, e.deptno 부서번호, dname 부서명
from emp e, dept d
where e.deptno = d.deptno;

--모든 부서의 정보 출력 => 사원이름(ename), 부서번호(deptno), 부서명(dname)
select ename 사원이름, d.deptno 부서번호, dname 부서명
from emp e, dept d
where e.deptno(+) = d.deptno; --null쪽이 부족한 테이블에 +가 들어감

select ename 사원이름, d.deptno 부서번호, dname 부서명
from emp e right outer join dept d
        on e.deptno = d.deptno
order by e.deptno;

select ename 사원이름, d.deptno 부서번호, dname 부서명
from dept d left outer join emp e
        on e.deptno = d.deptno
order by d.deptno;

--p.232
--sal 2000보다 큰 사원번호, 이름, 급여, 상사, 부서번호, 부서명, 지역 출력
select d.deptno, empno, ename, sal, mgr, dname, loc
from emp e, dept d
where e.deptno = d.deptno
and e.sal > 2000
order by deptno, e.empno;

--(sq-l99) 표준
select * from emp;
select * from dept;

--natural join
select deptno, e.empno, e.ename, e.sal, e.mgr, d.dname, d.loc
from emp e natural join dept d --해당 조건이 같다는것을 natural join이 알기에 생략할 수 있음.
where e.sal>2000;

--join ~ using
select deptno, e.empno, e.ename, e.sal, e.mgr, d.dname, d.loc
from emp e join dept d using(deptno) --이용할 칼럼을 ()안에 적어주면 됨.
where e.sal > 2000;

--p240 
--join ~ on : 가장 많이 사용하는 방법
select d.deptno, empno, ename, sal, mgr, dname, loc
from emp e join dept d
            on e.deptno = d.deptno
where e.sal > 2000;

--p.238
--emp, dept 테이블
--급여(sal)가 2000이상이며 직속상관(mgr)이 반드시 있어야 함
--empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc 출력
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and sal >= 2000 and mgr is not null;

--join ~ using
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, deptno, d.dname, d.loc
from emp e join dept d using(deptno) --deptno는 식별자를 지워줘야함.
where sal >= 2000 and mgr is not null;

--natural join
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, deptno, d.dname, d.loc
from emp e natural join dept d
where e.sal >= 2000 and mgr is not null;

--join ~ on
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, d.dname, d.loc
from emp e join dept d
on e.deptno = d.deptno
where e.sal >= 2000 and mgr is not null;

--------------------------
--p.239~240 (8장 연습문제)
--1) 급여(sal)가 2000초과인 사원들의 부서 정보, 사원 정보를 출력
--deptno, dname, empno, ename, sal 
--(sql-99)표준
--join ~ using
select deptno, d.dname, e.empno, e.ename, e.sal
from emp e 
join dept d using(deptno)
where e.sal >=2000
order by deptno;

--join ~ on
select d.deptno, d.dname, e.empno, e.ename, e.sal
from emp e join dept d
on e.deptno = d.deptno
where e.sal >= 2000
order by d.deptno asc;

--(sql-99)이전 방식
select d.deptno, d.dname, e.empno, e.ename, e.sal
from dept d ,emp e
where d.deptno = e.deptno
and e.sal >= 2000
order by e.deptno asc;


--2)각 부서별(부서번호, 부서명) 평균 급여, 최대급여, 최소급여, 사원수를 출력
-- deptno, dname, avg_sal, max_sal, min_sal, cnt
--(sql-99)표준
--join ~ on
select e.deptno, d.dname, 
round((avg(e.sal))) as avg_sal, max(e.sal) as max_sal , min(e.sal) as min_sal, count(e.empno) as cnt
from dept d join emp e on d.deptno = e.deptno
group by e.deptno, d.dname
order by e.deptno;

--natural join
select deptno, d.dname, 
round((avg(e.sal))) as avg_sal, max(e.sal) as max_sal , min(e.sal) as min_sal, count(e.empno) as cnt
from emp e natural join dept d
group by deptno, d.dname
order by deptno;

--(sql-99)이전 방식
select e.deptno, d.dname,
round((avg(e.sal))) as avg_sal, max(e.sal) as max_sal , min(e.sal) as min_sal, count(e.empno) as cnt
from dept d, emp e
where d.deptno = e.deptno
group by e.deptno, d.dname
order by e.deptno;


--3)모든 부서 정보와 사원 정보를 출력
--deptno, dname, empno, ename, job, sal >> 부서번호, 사원 이름순으로 정렬
--(sql-99)표준
--outer join
--left outer join
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal 
from dept d left outer join emp e 
on d.deptno = e.deptno
order by deptno;

--right outer join
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal 
from emp e right outer join dept d
on d.deptno = e.deptno
order by deptno;

--(sql-99)이전 방식
--(+)
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal 
from dept d, emp e
where d.deptno = e.deptno(+)
order by e.deptno;


--4)모든 부서 정보, 사원 정보, 급여 등급 정보, 직속 상관의 정보 출력
--deptno, dname, empno, ename, mgr, sal, deptno_1, losal, hisal, grade, mgr}_empno, mgr_ename
--부서번호, 사원 번호순으로 정렬
--(sql-99)표준
--join ~ on
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno as deptno_1, g.losal, g.hisal, g.grade,
m.empno as mgr_empno, m.ename as mgr_ename
from emp e right outer join dept d on (e.deptno = d.deptno) 
    left outer join salgrade g on (e.sal between g.losal and g.hisal) 
    left outer join emp m on (e.mgr = m.empno)
order by d.deptno, e.empno; 

--(sql-99)이전방식
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno as deptno_1, 
g.losal, g.hisal, g.grade, m.empno as mgr_empno, m.ename as mgr_ename
from dept d, emp e, salgrade g, emp m
where e.deptno(+) = d.deptno
    and e.sal between g.losal(+) and g.hisal(+)
    and e.mgr = m.empno(+)
order by d.deptno, e.empno;
-----------------------------

--p.242 서브쿼리(SQL 내부에 사용하는 select문)
--WARD라고 하는 사원보다 월급을 많이 받는 사원 이름을 출력
select sal from emp where ename = 'WARD';
select ename from emp where sal > 1250;

select ename
from emp
where sal > (select sal from emp where ename = 'WARD');

--'ALLEN'의 직무(job)와 같은 사람의 이름(ename), 부서명(dname), 급여(sal), 직무(job) 출력
select job from emp where ename = 'ALLEN';

select e.ename, d.dname, e.sal, e.job
from emp e, dept d
where e.deptno = d.deptno
and job = (select job from emp where ename = 'ALLEN')
and ename <> 'ALLEN';

-- 전체 사원의 평균 임금보다 많은 사원의
-- 사원번호(empno), 이름(ename), 부서명(dname), 입사일(hiredate}) 출력
select empno, ename, dname, hiredate, sal
from emp e, dept d
where e.deptno = d.deptno
and sal > (select avg(sal) from emp); 

--'ALLEN'보다 일찍 입사한 사원의 정보
select hiredate from emp where ename = 'ALLEN';
select ename,hiredate from emp;

select * 
from emp
where hiredate < (select hiredate 
                    from emp 
                    where ename = 'ALLEN');
                    
--p.248
--전체 사원의 평균급여보다 작거나 같은 급여를 받는 20번 부서의 사원 및 부서정보를 출력
-- empno, ename, job, sal, deptno, dname, loc
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 20
and e.sal <= (select avg(sal) from emp);

--natural join
select e.empno, e.ename, e.job, e.sal, deptno, d.dname, d.loc
from emp e natural join dept d
where deptno = 20 
and e.sal <= (select avg(sal) from emp);

--join ~ using
select e.empno, e.ename, e.job, e.sal, deptno, d.dname, d.loc
from emp e join dept d using(deptno)
where deptno = 20
and e.sal <= (select avg(sal) from emp);

--join ~ on
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
from emp e join dept d
on d.deptno = e.deptno
where d.deptno = 20
and e.sal <= (select avg(sal) from emp);


-- 각 부서별 최고급여와 동일한 급여를 받는 사원 정보 출력
-- 각 부서 별 최고급여
select deptno, max(sal)
from emp
group by deptno;

--다중행 서브쿼리
select * 
from emp 
where (deptno,sal) in (select deptno, max(sal)
                        from emp
                        group by deptno);
                        
select * 
from emp
where sal in (select max(sal)
                     from emp
                     group by deptno);
                     
select * from emp where sal in (2850,5000,3000);
















