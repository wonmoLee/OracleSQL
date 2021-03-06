ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;  
CREATE USER COS IDENTIFIED BY BITC5600;

GRANT CREATE SESSION TO COS;
GRANT CREATE TABLESPACE TO COS;
GRANT CREATE TABLE TO COS;
GRANT CREATE SEQUENCE TO COS;
GRANT SELECT, INSERT, DELETE, UPDATE ON COS.PLAYER TO COS;
ALTER USER COS DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;