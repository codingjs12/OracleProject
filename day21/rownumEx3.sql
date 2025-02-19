-- EMP, SALGRADE, DEPT
SELECT *
FROM EMP;

SELECT *
FROM SALGRADE;

SELECT * 
FROM DEPT;

-- 1. ALLEN과 같은 JOB, DEPTNO(부서)를 가진 사람을 구하시오.(ENAME, DNAME 출력)
SELECT ENAME, DNAME, JOB
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE ENAME = 'ALLEN';


SELECT ENAME, DNAME, JOB
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'SALESMAN';


SELECT E.ENAME, DNAME
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
INNER JOIN (
    SELECT ENAME, E.DEPTNO, JOB
    FROM EMP E
    INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
    WHERE ENAME = 'ALLEN' 
) T ON E.DEPTNO = T.DEPTNO AND E.JOB = T.JOB
WHERE E.ENAME != 'ALLEN';

-- 2. 자신의 부서 급여등급 평균보다 높은 등급인 사람의 이름, 부서명, 급여등급을 구하시오.
SELECT DNAME, AVG_SAL
FROM (
    SELECT ROUND(AVG(GRADE),2) AS AVG_SAL, DNAME 
    FROM EMP E
    INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
    INNER JOIN SALGRADE S ON SAL BETWEEN S.LOSAL AND S.HISAL
    GROUP BY DNAME
);


SELECT ENAME, D.DNAME, GRADE, AVG_GRADE
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
INNER JOIN SALGRADE S ON SAL BETWEEN S.LOSAL AND S.HISAL
INNER JOIN (
    SELECT DNAME, AVG_GRADE
    FROM (
        SELECT ROUND(AVG(GRADE),2) AS AVG_GRADE, DNAME
        FROM EMP E
        INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
        INNER JOIN SALGRADE S ON SAL BETWEEN S.LOSAL AND S.HISAL
        GROUP BY DNAME
    )
) T ON T.DNAME = D.DNAME
WHERE GRADE > AVG_GRADE
GROUP BY ENAME, D.DNAME, AVG_GRADE, GRADE
ORDER BY GRADE;

SELECT ENAME, DNAME, GRADE, AVG_GRADE
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
INNER JOIN (
    SELECT E.DEPTNO, DNAME, AVG(GRADE) AS AVG_GRADE
    FROM EMP E
    INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
    INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
    GROUP BY E.DEPTNO, DNAME
) T ON E.DEPTNO = T.DEPTNO AND GRADE > T.AVG_GRADE
GROUP BY ENAME, DNAME, AVG_GRADE, GRADE;


-- STUDENT, ENROL, SUBJECT
SELECT * FROM STUDENT;
SELECT * FROM ENROL;
SELECT * FROM SUBJECT;

-- 1. 컴퓨터 정보과의 평균보다 평균이 낮은 학과의 학과명, 점수 출력

SELECT *
FROM (
    SELECT ROWNUM AS NUM, T.*
    FROM (
        SELECT AVG(ENR_GRADE) AS DEPT_AVG, STU_DEPT
        FROM STUDENT S
        INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
        GROUP BY STU_DEPT
    ) T
) WHERE NUM < 3;

-- STU, PROFESSOR, DEPARTMENT
SELECT * 
FROM STU;

SELECT *
FROM PROFESSOR;

SELECT *
FROM DEPARTMENT;

-- 1. 교수 직급(POSITION)별 평균 급여 중 2번째로 높은 평균 급여에 해당하는 
-- 직급의 직급명, 평균 급여를 출력하시오.
SELECT POSITION, AVG_PAY
FROM (
    SELECT ROWNUM AS NUM, T.*
    FROM (
        SELECT ROUND(AVG(PAY),2) AS AVG_PAY, POSITION
        FROM PROFESSOR P
        GROUP BY POSITION
        ORDER BY AVG_PAY
    ) T 
) WHERE NUM = 2;


-- 2. 가장 많은 학생이 있는 학과와 가장 적은 학생이 있는 학과의 학과명, 학생수를 출력하시오.
SELECT DNAME, CNT
FROM (
    SELECT ROWNUM AS NUM, T.*
    FROM (
        SELECT COUNT(*) AS CNT, D1.DNAME
        FROM STU S
        INNER JOIN DEPARTMENT D1
        ON S.DEPTNO1 = D1.DEPTNO
        GROUP BY DNAME
        ORDER BY CNT
    ) T
);


SELECT DNAME, COUNT(*)
FROM STU S
INNER JOIN DEPARTMENT D ON S.DEPTNO1 = D.DEPTNO
GROUP BY DNAME
HAVING COUNT(*) IN (
    SELECT MAX(COUNT(*))
    FROM STU S
    GROUP BY DEPTNO1
    UNION
    SELECT MIN(COUNT(*))
    FROM STU S
    GROUP BY DEPTNO1
);
