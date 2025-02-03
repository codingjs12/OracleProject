SELECT *
FROM STU;

-- STU
-- 1. 본인보다 높은 학년인 사람의 학생 수 구하기

SELECT STUNO, NAME, GRADE
FROM STU;

SELECT S1.STUNO, S1.NAME, S1.GRADE, COUNT(S2.GRADE) AS 높은학년수
FROM STU S1
LEFT JOIN STU S2 ON S1.GRADE < S2.GRADE
GROUP BY S1.STUNO, S1.NAME, S1.GRADE
ORDER BY GRADE;

-- STU
-- 2. 학생들의 성별(남,여) 인원수를 구하시오.
SELECT COUNT(*) AS 남자
FROM STU
WHERE SUBSTR(JUMIN, 7, 1) = 1;

SELECT COUNT(*) AS 여자
FROM STU
WHERE SUBSTR(JUMIN, 7, 1) = 2;

SELECT
    COUNT(DECODE(SUBSTR(JUMIN, 7, 1), 1, '남자')) AS 남자,
    COUNT(DECODE(SUBSTR(JUMIN, 7, 1), 2, '여자')) AS 여자
FROM STU;

-- STUDENT, ENROL, SUBJECT
-- 3. 학생 이름, 학과, 과목명, 점수 출력
-- 시험을 안본 학생들은 점수를 0점, 과목명을 '없음' 으로 출력

SELECT *
FROM STUDENT;

SELECT *
FROM ENROL;

SELECT *
FROM SUBJECT;

SELECT STU_NAME, STU_DEPT, NVL(SUB_NAME, '시험안봄'), NVL(ENR_GRADE, 0)
FROM STUDENT S
LEFT JOIN ENROL E ON S.STU_NO = E.STU_NO
LEFT JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO;