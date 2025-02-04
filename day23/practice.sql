--1. 조건을 이용한 SELECT 조회 
-- ex) STUDENT 테이블에서 키가 170이상인 학생 조회
SELECT *
FROM STUDENT
WHERE STU_HEIGHT > 170;


--2. DML 명령어
-- ex) 2-1) STUDENT 테이블에 INSERT 구문을 이용하여 레코드 추가
--		(필수 컬럼 : 학번, 이름, 학과, 키)
INSERT INTO STUDENT (STU_NO, STU_NAME, STU_DEPT, STU_HEIGHT)
VALUES (20224506, '홍길동', '컴퓨터시스템', 188);


--	 2-2) 2-1에서 만든 데이터의 키를 170으로 변경
UPDATE STUDENT SET STU_HEIGHT = 170
WHERE STU_NO = 20224506;

--	 2-3) 2-1에서 만든 데이터를 학번을 조건으로 삭제
DELETE FROM STUDENT
WHERE STU_NO = 20224506;

--3. 내장 함수 (STU)
-- ex) 아이디의 첫 3글자를 *로 표시하세요. <-- 이거보단 조금 많이 복잡한 형태로
SELECT *
FROM STU;

SELECT LPAD(SUBSTR(ID, 4, LENGTH(ID)), LENGTH(ID), '*')
FROM STU;

--4. 그룹 함수 (STUDENT)
-- ex) 평균키가 가장 큰 학과의 평균 키를 구하고 소수점 1번째 자리에서 반올림 하시오.

SELECT *
FROM STUDENT;

SELECT ROUND(MAX(AVG(STU_HEIGHT)), 1)
FROM STUDENT
GROUP BY STU_DEPT;

--5. 조인 - 2문제
-- ex) 5-1) 강종영 교수의 수업을 듣는 학생들의 목록을 출력하시오. (STUDENT, ENROL, SUBJECT)
SELECT S.STU_NO, S.STU_NAME
FROM STUDENT S
INNER JOIN ENROL E ON E.STU_NO = S.STU_NO
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO
WHERE SUB_PROF = '강종영';

SELECT *
FROM ENROL;

SELECT *
FROM SUBJECT;

-- ex) 5-2) 직급(JOB)이 SALESMAN인 사람들의 급여 등급 평균을 구하시오. (EMP, SALGRADE)

SELECT AVG(GRADE)
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE JOB = 'SALESMAN';

SELECT *
FROM SALGRADE;



--6. 셀프조인 (STU, DEPARTMENT)
-- ex) 전공(DEPTNO1)이 공과대학에 속하는 학생의 수를 구하시오.

SELECT COUNT(*)
FROM STU S
INNER JOIN DEPARTMENT D1 ON S.DEPTNO1 = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN DEPARTMENT D3 ON D2.PART = D3.DEPTNO
WHERE D3.DNAME = '공과대학';


--7~8. 아래 예시 수준의 문제. 유형은 상이할 수 있음.
-- ex) 공과대학에서 속한 교수들 중 가장 큰 급여를 가지는 사람과 
--	가장 적은 급여를 가지는 사람의 교수 이름, 소속 학과, 직급, 급여를 출력하시오.

SELECT *
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D2.DEPTNO = D1.PART
INNER JOIN DEPARTMENT D3 ON D3.DEPTNO = D2.PART
WHERE D3.DNAME = '공과대학'
;



-- ex) 자신보다 키가 큰 학생의 수를 구하시오.
 
 