--p.239~240 (8장 연습문제)
--1) 급여(sal)가 2000초과인 사원들의 부서 정보, 사원 정보를 출력
--deptno, dname, empno, ename, sal 
--(sql-99)표준
select deptno, d.dname, e.empno, e.ename, e.sal
from emp e 
join dept d using(deptno)
where e.sal >=2000
order by deptno;

--(sql-99)이전 방식
select d.deptno, d.dname, e.empno, e.ename, e.sal
from dept d ,emp e
where d.deptno = e.deptno
and sal >= 2000
order by deptno;


--2)부서별 평균 급여, 최대급여, 최소급여, 사원수를 출력
-- deptno, dname, avg_sal, max_sal, min_sal, cnt
--(sql-99)표준
select d.deptno, d.dname, 
round((avg(e.sal))) as avg_sal, max(e.sal) as max_sal , min(e.sal) as min_sal, count(e.empno) as cnt
from dept d join emp e on d.deptno = e.deptno
group by d.deptno, d.dname
order by d.deptno;

--(sql-99)이전 방식
select d.deptno, d.dname,
round((avg(e.sal))) as avg_sal, max(e.sal) as max_sal , min(e.sal) as min_sal, count(e.empno) as cnt
from dept d, emp e
where d.deptno = e.deptno
group by d.deptno, d.dname
order by d.deptno;


--3)모든 부서 정보와 사원 정보를 출력
--deptno, dname, empno, ename, job, sal >> 부서번호, 사원 이름순으로 정렬
--(sql-99)표준
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal 
from dept d left outer join emp e on d.deptno = e.deptno
order by deptno;

--(sql-99)이전 방식
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal 
from dept d, emp e
where d.deptno = e.deptno(+)
order by deptno;

--4)모든 부서 정보, 사원 정보, 급여 등급 정보, 직속 상관의 정보 출력
--deptno, dname, empno, ename, mgr, sal, deptno_1, losal, hisal, grade, mgr}_empno, mgr_ename
--부서번호, 사원 번호순으로 정렬
--(sql-99)표준
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno as deptno_1, g.losal, g.hisal, g.grade,
m.empno as mgr_empno, m.ename as mgr_ename
from emp e
right outer join dept d on e.deptno = d.deptno
left outer join salgrade g on e.sal between g.losal and g.hisal
left outer join emp m on e.mgr = m.empno
order by d.deptno, e.empno;

--(sql-99)이전방식
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno as deptno_1, g.losal, g.hisal, g.grade,
m.empno as mgr_empno, m.ename as mgr_ename
from dept d, emp e, salgrade g, emp m
where e.deptno(+) = d.deptno
and e.sal between g.losal(+) and g.hisal(+)
and e.mgr = m.empno(+)
order by d.deptno, e.empno;