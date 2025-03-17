alter session set "_oracle_script" = true;
CREATE USER guest IDENTIFIED BY 1234;

GRANT CONNECT TO guest;      
GRANT RESOURCE TO guest;
GRANT UNLIMITED TABLESPACE TO guest;
GRANT CREATE TABLE TO guest;



