--1. 본인의 학과 평균 점수보다 높은 점수를 받은 학생의 정보 출력

SELECT * 
FROM STUDENT;

SELECT * 
FROM ENROL;

SELECT * FROM SUBJECT;

SELECT AVG(ENR_GRADE), STU_DEPT
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY STU_DEPT;

SELECT S.STU_NO, AVG(ENR_GRADE), STU_DEPT
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY S.STU_NO, STU_DEPT
;



SELECT AVG(ENR_GRADE), STU_DEPT
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY STU_DEPT;

SELECT *
FROM (
    SELECT S.STU_NO, AVG(ENR_GRADE) AS AVG_GRADE, STU_DEPT
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    GROUP BY S.STU_NO, STU_DEPT) T1
INNER JOIN (
    SELECT AVG(ENR_GRADE)AS DEPT_AVG, STU_DEPT
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    GROUP BY STU_DEPT
) T2
ON T1.STU_DEPT = T2.STU_DEPT
;

SELECT * 
FROM (
    SELECT *
    FROM (
    SELECT S.STU_NAME, AVG(ENR_GRADE) AS AVG_GRADE, STU_DEPT
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    GROUP BY S.STU_NAME, STU_DEPT) T1
INNER JOIN (
    SELECT AVG(ENR_GRADE)AS DEPT_AVG, STU_DEPT
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    GROUP BY STU_DEPT
) T2
ON T1.STU_DEPT = T2.STU_DEPT)
WHERE AVG_GRADE > DEPT_AVG;

SELECT STU_NAME, AVG(ENR_GRADE)
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY STU_NAME;

-- 1

SELECT STU_NAME, S.STU_DEPT, AVG(ENR_GRADE), AVG_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN (
    SELECT STU_DEPT, AVG(ENR_GRADE) AS AVG_GRADE
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    GROUP BY STU_DEPT
) T ON S.STU_DEPT = T.STU_DEPT
GROUP BY STU_NAME, S.STU_DEPT, AVG_GRADE
HAVING AVG(ENR_GRADE) > AVG_GRADE;

-- 2
SELECT *
FROM (
    SELECT STU_NAME, STU_DEPT, AVG(ENR_GRADE) AS STU_AVG
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    GROUP BY STU_NAME, STU_DEPT
) S
INNER JOIN (
    SELECT STU_DEPT, AVG(ENR_GRADE) AS DEPT_AVG
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    GROUP BY STU_DEPT
) T ON S.STU_DEPT = T.STU_DEPT AND STU_AVG > DEPT_AVG;

SELECT * FROM STUDENT;
SELECT * FROM ENROL;

SELECT ENR_GRADE, STU_NAME, STU_DEPT
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO;

SELECT AVG(ENR_GRADE), STU_DEPT
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY STU_DEPT;

SELECT STU_DEPT, AVG(ENR_GRADE) AS DEPT_AVG
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY STU_DEPT;

SELECT STU_NAME, STU_DEPT, ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO;

SELECT STU_NAME, S.STU_DEPT, ENR_GRADE, DEPT_AVG
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN (
    SELECT STU_DEPT, AVG(ENR_GRADE) AS DEPT_AVG
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    GROUP BY STU_DEPT
) T ON S.STU_DEPT = T.STU_DEPT;


SELECT STU_NAME, S.STU_DEPT, DEPT_AVG
FROM STUDENT S
INNER JOIN TEMP T ON S.STU_DEPT = T.STU_DEPT;



SELECT STU_NAME, S.STU_DEPT, ENR_GRADE, DEPT_AVG
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN TEMP T ON S.STU_DEPT = T.STU_DEPT
WHERE ENR_GRADE > DEPT_AVG;

SELECT STU_NAME, S.STU_DEPT, AVG(ENR_GRADE), DEPT_AVG
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN (
    SELECT STU_DEPT, AVG(ENR_GRADE) AS DEPT_AVG
    FROM STUDENT S
    INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
    
)
;

CREATE TABLE BOARD (
    BOARDNO     NUMBER       NOT NULL,  -- 게시글번호 (Primary Key)
    TITLE       VARCHAR2(50) NOT NULL,  -- 제목
    CONTENTS    VARCHAR2(1000) NOT NULL, -- 내용
    USERID      VARCHAR2(30) NOT NULL,  -- 작성자 (Foreign Key)
    KIND        CHAR(1)     NOT NULL,   -- 게시판 종류 (1 : 공지사항, 2 : 자유게시판, 3 : 문의게시판, 4 : 신고게시판)
    FAVORITE       NUMBER      NOT NULL,   -- 좋아요 수
    CNT         NUMBER       NOT NULL,   -- 조회수
    SUBTITLE    CHAR(1)     NOT NULL,    -- 말머리 (1 : 잡담, 2 : 일상, 3 : 후기, 4 : 정보)
    DELETEYN    CHAR(1)     NOT NULL,    -- 삭제여부 (Y : 삭제상태, N : 미삭제)
    CDATETIME   DATE         NOT NULL,   -- 작성일
    UDATETIME   DATE         NOT NULL   -- 수정일
);
COMMIT;

CREATE TABLE MEMBER (
    USERID      VARCHAR2(30) NOT NULL,    -- 아이디 (Primary Key)
    PASSWORD    VARCHAR2(30) NOT NULL,    -- 비밀번호
    USERNAME    VARCHAR2(30) NOT NULL,    -- 이름
    ADDRESS     VARCHAR2(200) NOT NULL,   -- 주소
    PHONE       VARCHAR2(30) NOT NULL,    -- 핸드폰번호 (하이픈 없이)
    EMAIL       VARCHAR2(30) NOT NULL,    -- 이메일
    BIRTH       VARCHAR2(30) NOT NULL,    -- 생년월일
    GENDER      CHAR(1)     NOT NULL,     -- 성별 (M : 남자, F : 여자, N : 선택하지 않음)
    STATUS      CHAR(1)     NOT NULL,     -- 사용자 상태 (A : 관리자, S : 판매자, C : 구매자)
    POINT       NUMBER      NOT NULL,     -- 포인트
    NICKNAME    VARCHAR2(30) NOT NULL,    -- 닉네임
    GRADE       CHAR(1)     NOT NULL,     -- 등급 (1 : 실버, 2 : 골드, 3 : 플래티넘, 4 : VIP, 5 : VVIP)
    PUSHYN      CHAR(1)     NOT NULL,     -- 푸시 알림 동의 여부 (Y : 동의, N : 비동의)
    CDATETIME   DATE        NOT NULL    -- 가입일
    
);

COMMIT;

SELECT * FROM MEMBER;
SELECT * FROM BOARD;



