-- VIEW
SELECT * FROM V_EMP;

SELECT *
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO;

CREATE OR REPLACE VIEW V_EMP
AS
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP;

CREATE OR REPLACE VIEW V_ENR
AS
SELECT STU_NAME, STU_DEPT, ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO;

SELECT * FROM V_ENR;




