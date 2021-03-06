DROP TABLE USERS CASCADE CONSTRAINTS;
DROP SEQUENCE XXX_SEQ;

CREATE TABLE USERS(
    ID NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(30) NOT NULL,
    PASSWORD VARCHAR2(30) NOT NULL, 
    RR_NUM VARCHAR2(15) NOT NULL, 
    PH_NUM VARCHAR2(15) NOT NULL, 
    EMAIL VARCHAR2(40), 
    AGREE_WT CHAR(1) NOT NULL, 
    ADMIN_AT CHAR(1) NOT NULL, 
    JOIN_DATE TIMESTAMP NOT NULL);
    
CREATE SEQUENCE USER_SEQ
START WITH 1 INCREMENT BY 1;

CREATE TABLE MENU(
    ID NUMBER PRIMARY KEY,
    제품코드 VARCHAR2(30) NOT NULL,
    MENU_NAME VARCHAR2(30) NOT NULL,
    전일재고 NUMBER,
    입고량 NUMBER,
    출고량 NUMBER,
    현재고 NUMBER,
    날짜 DATE NOT NULL);
    
CREATE SEQUENCE MENU_SEQ
START WITH 1 INCREMENT BY 1;

INSERT INTO MENU VALUES (MENU_SEQ.nextval, 'B1', '새우버거', 0, 200, 0, 200, '20200501');
INSERT INTO MENU VALUES (MENU_SEQ.nextval, 'P1', '감자튀김(소)', 0, 200, 0, 200, '20200501');
INSERT INTO MENU VALUES (MENU_SEQ.nextval, 'D1', '콜라', 0, 200, 0, 200, '20200501');
INSERT INTO MENU VALUES (MENU_SEQ.nextval, 'C1', '콘샐러드', 0, 50, 0, 50, '20200501');