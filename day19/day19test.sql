SELECT * FROM PROFESSOR;
SELECT * FROM DEPARTMENT;
SELECT * FROM STU;

SELECT D1.DNAME, D2.DNAME, D3.DNAME
FROM DEPARTMENT D1
INNER JOIN DEPARTMENT D2 ON D1.DEPTNO = D2.PART
INNER JOIN DEPARTMENT D3 ON D2.DEPTNO = D3.PART
WHERE D3.DNAME = '컴퓨터공학과';

-- 컴퓨터공학과의 학과명, 학부명, 대학명을 출력

SELECT D1.DNAME AS 과대, D2.DNAME AS 학부, D3.DNAME AS 학과
FROM DEPARTMENT D1
INNER JOIN DEPARTMENT D2 ON D1.DEPTNO = D2.PART
INNER JOIN DEPARTMENT D3 ON D2.DEPTNO = D3.PART;

-- 학생의 이름, 아이디, 주전공 학과(DEPTNO1), 학부 출력
SELECT s.name, s.id, d1.dname, d2.dname
FROM stu s
INNER JOIN department d1 ON s.deptno1 = d1.deptno
INNER JOIN department d2 ON d1.part = d2.deptno;


