SELECT *
FROM EMP;

--LAG 함수
SELECT ENAME, S1, S2, DECODE(S1, S2, NO-1, NO)
FROM(
SELECT ENAME, SAL "S1", LAG(SAL, 1, 0) OVER(ORDER BY SAL DESC) "S2", 
ROWNUM "NO"
FROM
(
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC
));

SELECT ENAME, SAL , LAG(SAL, 1, 0) OVER(ORDER BY SAL DESC)
FROM EMP;

--RANK OVER
SELECT ENAME , SAL, RANK() OVER(ORDER BY SAL DESC)
FROM EMP;

SELECT NAME, HEIGHT, RANK() OVER (ORDER BY HEIGHT DESC)
FROM STUDENT;

--학년별 키 순위를 구하시오.
SELECT NAME, GRADE, HEIGHT, RANK() OVER (PARTITION BY GRADE ORDER BY HEIGHT DESC) 
FROM STUDENT;

--카티션 곱
SELECT *
FROM EMP, DEPT;

--Inner Join(오라클 버전으로)
SELECT E.ENAME, E.DEPTNO, D.DNAME, D.LOC
FROM EMP e, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT *
FROM DEPT D, EMP E --DEPTNO에 숫자를 넣는 이유는 DB는오브젝트를 쓸 수 없어서이다.그래서 번호를 부여하고 그행을 찾아가기에 그행을 그냥 오브젝트라고 보면된다.
WHERE D.DEPTNO = E.DEPTNO;

ROLLBACK;
DELETE FROM DEPT WHERE DEPTNO = 10;

--LEFT OUTER Join
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+); 

--RIGHT OUTER Join
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

--237p
SELECT S.NAME "STU_NAME", P.NAME "PROF_NAME"
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO(+);

--DDL (테이블 삭제 (drop), 수정(alter), 생성(create))
--reply 테이블 만들기
CREATE TABLE REPLY(
    id number,
    content varchar2(200) not null,
    boardId number,
    userId number,
    CONSTRAINT REPLY_PK PRIMARY KEY (id),
    CONSTRAINT REPLY_PK_BOARD_ID FOREIGN KEY (boardId) REFERENCES Board(id),
    CONSTRAINT REPLY_PK_USER_ID FOREIGN KEY (userId) REFERENCES Users(id)
);

CREATE SEQUENCE users_seq
INCREMENT BY 1
START WITH 1;

CREATE SEQUENCE board_seq
INCREMENT BY 1
START WITH 1;

CREATE SEQUENCE reply_seq
INCREMENT BY 1
START WITH 1;

--Users, Board, Reply
--DNL(데이터 조작어)
INSERT INTO USERS(ID, USERNAME, EMAIL) --괄호안 생략가능. 밑에 다 넣을거니까
VALUES(USERS_SEQ.nextval, 'ssar', 'ssar@nate.com');

INSERT INTO USERS(ID, USERNAME, EMAIL)
VALUES(USERS_SEQ.nextval, 'love', 'love@nate.com');

INSERT INTO USERS(ID, USERNAME, EMAIL)
VALUES(USERS_SEQ.nextval, 'cos', 'cos@nate.com');

commit;

select * from users;


INSERT INTO BOARD(ID, TITLE, CONTENT, USERID)
VALUES(BOARD_SEQ.nextval, '오라클 1강', 'DDL이란?', 1);

INSERT INTO BOARD(ID, TITLE, CONTENT, USERID)
VALUES(BOARD_SEQ.nextval, '오라클 2강', 'DML이란?', 1);

INSERT INTO BOARD(ID, TITLE, CONTENT, USERID)
VALUES(BOARD_SEQ.nextval, '오라클 3강', 'DCL이란?', 2);

INSERT INTO BOARD(ID, TITLE, CONTENT, USERID)
VALUES(BOARD_SEQ.nextval, '오라클 4강', 'DQL이란?', 1);

COMMIT;

INSERT INTO REPLY(ID, CONTENT, BOARDID, USERID)
VALUES(REPLY_SEQ.nextval, '재밋어요', 1, 1);

INSERT INTO REPLY(ID, CONTENT, BOARDID, USERID)
VALUES(REPLY_SEQ.nextval, '진짜 재밋어요', 1, 2);

COMMIT;

SELECT * FROM BOARD;
SELECT * FROM REPLY;

--테이블 데이터 밀때
DELETE FROM BOARD;
DELETE FROM USERS;
COMMIT;

--시퀀스 삭제
DROP SEQUENCE BOARD_SEQ;
DROP SEQUENCE USERS_SEQ;

--조인
SELECT *
FROM USERS U, BOARD B
WHERE U.ID = B.USERID;

SELECT *
FROM USERS U, BOARD B
WHERE U.ID = B.USERID(+);

SELECT *
FROM USERS U, REPLY R
WHERE U.ID = R.USERID(+)
AND R.ID IS NULL;

SELECT *
FROM USERS U , REPLY R
WHERE U.ID = R.USERID(+)
MINUS
SELECT *
FROM USERS U , REPLY R
WHERE U.ID = R.USERID;

SELECT *
FROM BOARD B , REPLY R
WHERE B.ID = R.BOARDID;

SELECT B.ID, B.TITLE, B.USERID, COUNT(R.ID) "댓글수"
FROM BOARD B, REPLY R
WHERE B.ID = R.BOARDID(+) 
GROUP BY B.ID, B.TITLE, B.USERID;

SELECT ID, TITLE, USERID, --SELECT은 행마다 실행된다.
(SELECT COUNT(*) FROM REPLY WHERE BOARDID = B.ID) "댓글수"
FROM BOARD B;

SELECT B.ID, B.TITLE, U.USERNAME, COUNT(R.ID) "댓글수"
FROM BOARD B, USERS U, REPLY R
WHERE B.ID = R.BOARDID(+) AND B.USERID = U.ID
GROUP BY B.ID, B.TITLE, U.USERNAME;

--SELF JOIN
SELECT E1.EMPNO, E1.ENAME, E1.JOB, E1.MGR, E2.ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);

SELECT E1.EMPNO, E1.ENAME, E1.JOB, E1.MGR, E2.ENAME
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO(+);

--ANSI JOIN으로 이너 아우터해보기
--이너조인
SELECT E.EMPNO, E. ENAME, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.EMPNO, E. ENAME, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO; 

--아우터조인
SELECT *
FROM BOARD B, REPLY R
WHERE B.ID = R.BOARDID;

SELECT *
FROM BOARD B LEFT OUTER JOIN REPLY R
ON B.ID = R.BOARDID;

SELECT *
FROM BOARD B RIGHT OUTER JOIN REPLY R
ON B.ID = R.BOARDID;

SELECT *
FROM BOARD B FULL OUTER JOIN REPLY R
ON B.ID = R.BOARDID;

--테이블 복제
CREATE TABLE STUDENT2
AS
SELECT STUDNO, NAME, ID, GRADE, HEIGHT, WEIGHT, DEPTNO1, DEPTNO2, PROFNO
FROM STUDENT;

SELECT * FROM STUDENT2;

--VIEW
CREATE OR REPLACE VIEW STUDENT_VIEW
AS
SELECT STUDNO, NAME, ID, GRADE, HEIGHT, WEIGHT, DEPTNO1, DEPTNO2, PROFNO
FROM STUDENT;

SELECT * 
FROM STUDENT;

SELECT * 
FROM STUDENT_VIEW
ORDER BY STUDNO;

--데이터 삽입

INSERT INTO STUDENT_VIEW(STUDNO, NAME, ID, GRADE, HEIGHT, WEIGHT, DEPTNO1, DEPTNO2, PROFNO)
VALUES(9999, '이원모', 'TIMO', 4, 170, 70, 201, NULL, NULL);

DELETE FROM STUDENT
WHERE STUDNO = 9999;

UPDATE EMP E
SET SAL = (SAL + SAL*0.1)
WHERE EXISTS
        (
            SELECT 1 FROM DEPT D
            WHERE D.LOC='DALLLAS' AND
                  E.DEPTNO = D.DEPTNO
        );
        
SELECT * FROM EMP;

SELECT *
FROM EMP
WHERE SAL IN (SELECT SAL
FROM EMP
WHERE JOB = 'MANAGER');

SELECT *
FROM EMP
WHERE SAL = 2975 OR SAL = 2850 OR SAL = 2450;

SELECT *
FROM EMP
WHERE SAL IN(2975, 2850, 2450);

SELECT ENAME, COMM
FROM EMP
WHERE COMM < (SELECT COMM
              FROM EMP
              WHERE ENAME = 'WARD');

--441p           
SELECT S.NAME, D.DNAME
FROM STUDENT S, DEPARTMENT D
WHERE DEPTNO1 = (SELECT DEPTNO1
                 FROM STUDENT
                 WHERE NAME = '이미경')
        AND S.DEPTNO1 = D.DEPTNO;
        
SELECT P.NAME, P.HIREDATE, D.DNAME
FROM PROFESSOR P, DEPARTMENT D
WHERE HIREDATE < (SELECT HIREDATE
                  FROM PROFESSOR
                  WHERE NAME = '박승곤')
                  AND P.DEPTNO = D.DEPTNO;
                  
SELECT S.NAME, S.WEIGHT
FROM STUDENT S
WHERE WEIGHT > (SELECT AVG(WEIGHT)
                FROM STUDENT
                WHERE DEPTNO1 = 201);

--444p
SELECT * FROM DEPT
WHERE EXISTS (SELECT DEPTNO
              FROM DEPT
              WHERE DEPTNO = &DNO);
              
SELECT * FROM DEPT
WHERE DEPTNO IN(SELECT DEPTNO
              FROM DEPT
              WHERE DEPTNO = &DNO);
              
--446p
--1번
SELECT NAME, POSITION, '$' || TO_CHAR(PAY, '999,999,999') PAY
FROM EMP2
WHERE PAY > (SELECT MIN(PAY)
             FROM EMP2
             WHERE POSITION = '과장');
             
--2번
SELECT NAME, GRADE, WEIGHT
FROM STUDENT
WHERE WEIGHT < (SELECT MIN(WEIGHT)
                FROM STUDENT
                WHERE GRADE = 2);
                
--3번
SELECT D.DNAME, E.NAME, TO_CHAR(PAY, '$999,999,999')SALARY
FROM EMP2 E, DEPT2 D
WHERE PAY <ALL (SELECT AVG(PAY)
                FROM EMP2
                GROUP BY DEPTNO)
                AND D.DCODE = E.DEPTNO;
                
                










