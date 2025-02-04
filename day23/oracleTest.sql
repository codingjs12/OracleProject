--1. 조건을 이용한 SELECT 조회 
-- STUDENT 테이블에서 컴퓨터정보 학과(STU_DEPT) 학생들을 모두 출력하시오.
-- 난이도 : 하

SELECT *
FROM STUDENT
WHERE STU_DEPT = '컴퓨터정보';

--2. DML 명령어
--     2-1) EMP 테이블에 INSERT 구문을 이용하여 레코드 추가
--		(필수 컬럼 : EMPNO, ENAME, MGR, SAL) 
--          - 데이터는 임의의 값을 넣으면 되나, MGR의 경우 EMPNO와 MGR의 관계를 고려하여 값을 넣을 것.
INSERT INTO EMP (EMPNO, ENAME, MGR, SAL)
VALUES (1234, '홍길동', 7698, 3000);
--	 2-2) 2-1에서 만든 데이터의 SAL을 2000으로 변경
UPDATE EMP SET SAL = 2000
WHERE EMPNO = 1234;
--	 2-3) 2-1에서 만든 데이터를 EMPNO를 조건으로 삭제
DELETE FROM EMP WHERE EMPNO = 1234;
-- 난이도 : 하
	 
-- 3. 내장 함수 (PROFESSOR)
-- PROFESSOR 테이블의 EMAIL 컬럼을 아래 이미지와 같이 변환하여 출력하시오.
SELECT LPAD(SUBSTR(EMAIL, INSTR(EMAIL, '.'), 4), LENGTH(EMAIL), '*'), EMAIL
FROM PROFESSOR;

-- 함수를 포함한 어떠한 기능을 가져다 써도 상관없이 결과만 도출되면 됨.
-- 난이도 : 상

-- 4. 그룹 함수 (STUDENT)
-- STUDENT테이블에서 컴퓨터정보 학과(STU_DEPT) 학생들의 수를 구하시오.

SELECT STU_DEPT, COUNT(*)
FROM STUDENT
WHERE STU_DEPT = '컴퓨터정보'
GROUP BY STU_DEPT;



-- 난이도 : 하

-- 5. 조인 - 2문제
-- 5-1) 컴퓨터정보 학과에 속한 교수의 수업을 듣는 학생들의 목록을 출력하시오. (STUDENT, ENROL, SUBJECT)

SELECT *
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON E.SUB_NO = SUB.SUB_NO
WHERE SUB_DEPT = '컴퓨터정보';


-- 5-2) EMP 테이블에 속한 사람들의 사번(EMPNO), 이름(ENAME), 급여등급을 출력하시오. (EMP, SALGRADE)
-- 난이도 : 중

SELECT EMPNO, ENAME, GRADE
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 6. 셀프조인 
-- 부하직원(본인을 MGR로 가지고 있는 사원)이 가장 많은 사원의 사번, 이름, 부하직원 수를 출력하시오.
-- (EMP)
-- 난이도 : 중

SELECT *
FROM (
    SELECT E1.EMPNO, E1.ENAME, COUNT(*) AS 부하직원
    FROM EMP E1
    INNER JOIN EMP E2 ON E1.EMPNO = E2.MGR
    GROUP BY E1.ENAME, E1.EMPNO
    ORDER BY 부하직원 DESC
) WHERE ROWNUM = 1;

-- 7. 2개의 수업을 들은 학생들의 평균점수와 1개의 수업을 들은 학생들의 평균점수를 구하시오.
-- (수업 개수, 평균 점수 출력)
-- (STUDENT, ENROL)
-- 난이도 : 중
SELECT STU_NAME, AVG(ENR_GRADE)AS 평균점수, COUNT(*) AS 수업개수
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY STU_NAME;

-- 8. 본인 학과에서 본인보다 몸무게가 큰 학생의 수를 출력하시오. ( 학번, 이름, 학과, 큰 학생 수 출력 )
-- (STUDENT)
-- 난이도 : 중

SELECT S1.STU_NAME, S1.STU_WEIGHT, S1.STU_DEPT, COUNT(S2.STU_NAME) AS 큰학생수
FROM STUDENT S1
LEFT JOIN STUDENT S2 ON S1.STU_DEPT = S2.STU_DEPT AND S1.STU_WEIGHT < S2.STU_WEIGHT
GROUP BY S1.STU_NAME, S1.STU_WEIGHT, S1.STU_DEPT;

