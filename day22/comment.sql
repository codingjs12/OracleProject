CREATE TABLE BOARD_COMMENT (
    COMMENTNO    NUMBER PRIMARY KEY,                          -- 댓글번호
    BOARDNO      NUMBER NOT NULL,                 -- 게시글번호
    USERID       VARCHAR2(30) NOT NULL,           -- 작성자
    CONTENTS     VARCHAR2(300) NOT NULL,          -- 댓글내용
    P_COMMENTNO  NUMBER,                          -- 부모 댓글번호
    CDATETIME    DATE DEFAULT SYSDATE,            -- 작성일 (기본값: 현재 시간)
    UDATETIME    DATE DEFAULT SYSDATE             -- 수정일 (기본값: 현재 시간)
);
COMMIT;

SELECT * FROM BOARD_COMMENT;

CREATE SEQUENCE COMMENT_SEQ
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 9999
NOCYCLE;

INSERT INTO BOARD_COMMENT VALUES(
COMMENT_SEQ.NEXTVAL, 1, 'user02', 'HTML 꿀잼', NULL, SYSDATE, SYSDATE
);

COMMIT;

SELECT TITLE, B.CONTENTS, USERNAME, COUNT(COMMENTNO)
FROM BOARD B
INNER JOIN MEMBER M ON B.USERID = M.USERID
LEFT JOIN BOARD_COMMENT C ON B.BOARDNO = C.BOARDNO
GROUP BY TITLE, B.CONTENTS, USERNAME
;

SELECT B.BOARDNO, TITLE, NVL(C_CNT, 0) AS C_CNT
FROM BOARD B
INNER JOIN MEMBER M ON B.USERID = M.USERID
LEFT JOIN 
(
    SELECT BOARDNO, COUNT(*) AS C_CNT
    FROM BOARD_COMMENT
    GROUP BY BOARDNO
) T ON B.BOARDNO = T.BOARDNO
ORDER BY BOARDNO
;








