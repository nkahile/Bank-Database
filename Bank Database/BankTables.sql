--Table1--
 
    CREATE TABLE Branch(
    ID int,
    Bank_Num int,
    Address varchar(255),
    zip int,
    Phone_Num VARCHAR2(12),
    state char(2),
    city VARCHAR2(100),
    CONSTRAINT branch_pk PRIMARY KEY (ID)
);

--Options for table1----
select * from branch;
DROP TABLE branch;
------------------------------------------------------------------------------------------

INSERT INTO Branch(ID, BANK_NUM, ADDRESS, ZIP, PHONE_NUM, STATE, CITY) 
VALUES (1,4304,'250 W 161st St',46074,'317-896-6513','IN','WESTFIELD');
INSERT INTO Branch(ID, BANK_NUM, ADDRESS, ZIP, PHONE_NUM, STATE, CITY) 
VALUES (2,2307,'320 N Meridian St',46204,'317-261-9777','IN','WESTFIELD');
INSERT INTO Branch(ID, BANK_NUM, ADDRESS, ZIP, PHONE_NUM, STATE, CITY) 
VALUES (3,6323,'251 N Illinois St',46209,'317-383-2200','IN','INDIANAPOLIS');
INSERT INTO Branch(ID, BANK_NUM, ADDRESS, ZIP, PHONE_NUM, STATE, CITY) 
VALUES (4,4309,'107 N Pennsylvania St suite 100 suite',46204,'463-261-9750','IN','INDIANAPOLIS');

--Table2---------------------------------------

    CREATE TABLE Clients(
    ID int,
    FirstName varchar2(255),
    LastName varchar(255),
    SSN varchar2(11),
    Gender varchar(25),
    DOB date,
    Phone_Num VARCHAR2(12),
    Address varchar(255),
    zip int,
    state char(2),
    city VARCHAR2(100),
    PRIMARY KEY (ID)
);

--Options for table2-----------------------
select*from clients;
drop table clients;
-----------------------------------------------------------------------------

INSERT INTO Clients (ID, FirstName, LastName, SSN, Gender, DOB, Phone_Num, Address, zip, state, city) 
VALUES (1,'Nour','Kahile','795-96-9895','Male',(TO_DATE('04/16/1998','mm/dd/yyyy')),'317-985-4295','17175 petersfield Ln',46074,'IN','WESTFIELD');
INSERT INTO Clients (ID, FirstName, LastName, SSN, Gender, DOB, Phone_Num, Address, zip, state, city) 
VALUES (2,'Tom','Baker','465-81-4981','Male',(TO_DATE('08/10/1976','mm/dd/yyyy')),'317-465-4385','2565 burntwood Dr',48074,'IN','CARMEL');
INSERT INTO Clients (ID, FirstName, LastName, SSN, Gender, DOB, Phone_Num, Address, zip, state, city) 
VALUES (3,'Dylan','Coots','854-12-6595','Male',(TO_DATE('01/27/1999','mm/dd/yyyy')),'317-559-1565','2602 amherst St',46074,'IN','INDIANAPOLIS');
INSERT INTO Clients (ID, FirstName, LastName, SSN, Gender, DOB, Phone_Num, Address, zip, state, city) 
VALUES (4,'Patricia','Hanna','955-16-4545','Female',(TO_DATE('07/20/1997','mm/dd/yyyy')),'465-392-4445','1006 Deerfield Rd',46074,'IN','INDIANAPOLIS');
INSERT INTO Clients (ID, FirstName, LastName, SSN, Gender, DOB, Phone_Num, Address, zip, state, city) 
VALUES (5,'jack','sparrow','000-00-0000','Male',(TO_DATE('07/20/1997','mm/dd/yyyy')),'317-464-4186','Pirates of the Caribbean dr',85663,'IN','INDIANAPOLIS');
INSERT INTO Clients (ID, FirstName, LastName, SSN, Gender, DOB, Phone_Num, Address, zip, state, city) 
VALUES (6,'Sumaya','Boyle','893-69-7934','Female',(TO_DATE('04/20/2000','mm/dd/yyyy')),'317-963-1447','2005 springmill Rd',75223,'IN','WESTFIELD');
INSERT INTO Clients (ID, FirstName, LastName, SSN, Gender, DOB, Phone_Num, Address, zip, state, city) 
VALUES (7,'Lamar','Joseph','693-23-5656','male',(TO_DATE('07/08/1993','mm/dd/yyyy')),'317-854-236','56 coachman dr',46032,'IN','CARMEL');

--Table3-----------------------------------------------------------------------------

    CREATE TABLE Employees(
    ID int,
    FirstName varchar2(225),
    LastName varchar2(255),
    PhoneNum varchar2(12),
    CONSTRAINT EM_pk PRIMARY KEY (ID)
);

--Options for Table3-----------------------
drop table employees;
select*from employees;
------------------------

INSERT INTO Employees(ID, FirstName, LastName, PhoneNum) 
VALUES (1,'Lamar','Joseph','317-854-236');
INSERT INTO Employees(ID, FirstName, LastName, PhoneNum) 
VALUES (2,'Mona','Crawford','465-895-9412');
INSERT INTO Employees(ID, FirstName, LastName, PhoneNum) 
VALUES (3,'Maggie','Wells','812-985-8436');
INSERT INTO Employees(ID, FirstName, LastName, PhoneNum) 
VALUES (4,'jack','sparrow','317-464-4186');
INSERT INTO Employees(ID, FirstName, LastName, PhoneNum) 
VALUES (5,'justin','timberlake','317-985-7898');
INSERT INTO Employees(ID, FirstName, LastName, PhoneNum) 
VALUES (6,'britney','spears','465-126-4567');
INSERT INTO Employees(ID, FirstName, LastName, PhoneNum) 
VALUES (7,'Sumaya','Boyle','317-963-1447');

--Table4-------------------------------------------------------------------
    Create table TYPE (
    ID int,
    type1 varchar2(50) unique,
    Rate decimal (4,2),
    PRIMARY KEY (ID)
);
    
--Options for table4-----------------------------------
drop table TYPE;
select*from TYPE;
-----------------------------------

INSERT INTO TYPE(ID,type1,Rate)
values(1,'Savings Account',1.70);
INSERT INTO TYPE(ID,type1,Rate)
values(2,'Checking Account',1.85);
INSERT INTO TYPE(ID,type1,Rate)
values(3,'Money Market Account',1.60);

--table5------------------------------------------------

    Create table ACCOUNTS(
    ID int,
    Account_type int,
    Constraint Account_Type_FK FOREIGN KEY(Account_Type)REFERENCES TYPE(ID),
    Open_Date date,
    Close_Date date,
 PRIMARY KEY (ID)
);

--options for table5-------------------------------------
select*from accounts;
drop table accounts;
---------------------------------------------------------

INSERT INTO ACCOUNTS(ID,Account_type,Open_Date,Close_Date)
values(1,2,(TO_DATE('02/10/2014','mm/dd/yyyy')),(TO_DATE('11/10/2017','mm/dd/yyyy')));
INSERT INTO ACCOUNTS(ID,Account_type,Open_Date,Close_Date)
values(2,1,(TO_DATE('01/10/2010','mm/dd/yyyy')),(TO_DATE('06/10/2019','mm/dd/yyyy')));
INSERT INTO ACCOUNTS(ID,Account_type,Open_Date,Close_Date)
values(3,1,(TO_DATE('04/16/2018','mm/dd/yyyy')),(TO_DATE(NULL)));
INSERT INTO ACCOUNTS(ID,Account_type,Open_Date,Close_Date)
values(4,3,(TO_DATE('04/16/2015','mm/dd/yyyy')),(TO_DATE(NULL)));
INSERT INTO ACCOUNTS(ID,Account_type,Open_Date,Close_Date)
values(5,2,(TO_DATE('02/10/2014','mm/dd/yyyy')),(TO_DATE('11/10/2017','mm/dd/yyyy')));
INSERT INTO ACCOUNTS(ID,Account_type,Open_Date,Close_Date)
values(6,1,(TO_DATE('01/10/2010','mm/dd/yyyy')),(TO_DATE(NULL)));
INSERT INTO ACCOUNTS(ID,Account_type,Open_Date,Close_Date)
values(7,3,(TO_DATE('01/10/2010','mm/dd/yyyy')),(TO_DATE(NULL)));


-----------------------------------------------------------
--table 6--
Create table account_owner(
    account_ID int,
    owner_id int,
    Constraint account_ID_FK FOREIGN KEY(Account_Type)REFERENCES TYPE(ID),
    Constraint owner_ID_FK FOREIGN KEY(Account_Type)REFERENCES TYPE(ID)
);

-------------------------
select * from account_owner;
drop table account_onwer;
------------------------
select * from role_of_employees;
------------------------
INSERT INTO role_of_employees (ID,role)
values(1,'Client Adviser');
INSERT INTO role_of_employees(ID,role)
values(2,'Risk Manager');
INSERT INTO role_of_employees(ID,role)
values(3,'Operations Analyst');
INSERT INTO role_of_employees(ID,role)
values(4,'teller');
INSERT INTO role_of_employees(ID,role)
values(5,'janitor');
------------------------------
--table 7--
CREATE TABLE Info_of_empolyees(
    ID int,
    Employee_id int,
    role varchar(30),
    date_of_employment date,
    date_of_leaving date,
    Branch_num int,
    constraint pk_employees_id primary key(ID)
);
    alter table Info_of_empolyees add Constraint employee_ID_FK FOREIGN KEY(Employee_id)REFERENCES employees(ID);
    
--------------------------------------------------------------
INSERT INTO Info_of_empolyees(ID,Employee_id,role,date_of_employment,date_of_leaving,Branch_num)
values(1,1,'Risk Manager',(TO_DATE('03/11/2012','mm/dd/yyyy')),(TO_DATE('11/10/2017','mm/dd/yyyy')),6323);
INSERT INTO Info_of_empolyees(ID,Employee_id,role,date_of_employment,date_of_leaving,Branch_num)
values(2,2,'teller',(TO_DATE('05/11/2018','mm/dd/yyyy')),NULL,4304);
INSERT INTO Info_of_empolyees(ID,Employee_id,role,date_of_employment,date_of_leaving,Branch_num)
values(3,3,'Operations Analyst',(TO_DATE('03/11/2012','mm/dd/yyyy')),null,6323);
INSERT INTO Info_of_empolyees(ID,Employee_id,role,date_of_employment,date_of_leaving,Branch_num)
values(4,4,'teller',(TO_DATE('09/23/2010','mm/dd/yyyy')),null,4304);
INSERT INTO Info_of_empolyees(ID,Employee_id,role,date_of_employment,date_of_leaving,Branch_num)
values(5,5,'Client Adviser',(TO_DATE('02/01/2016','mm/dd/yyyy')),(TO_DATE('03/16/2019','mm/dd/yyyy')),4309);
INSERT INTO Info_of_empolyees(ID,Employee_id,role,date_of_employment,date_of_leaving,Branch_num)
values(6,6,'Risk Manager',(TO_DATE('03/19/2017','mm/dd/yyyy')),null,4304);
INSERT INTO Info_of_empolyees(ID,Employee_id,role,date_of_employment,date_of_leaving,Branch_num)
values(7,7,'janitor',(TO_DATE('07/26/2012','mm/dd/yyyy')),null,2307);
-------------------------------
--table 8--
create table employee_pay_info(
    info_of_employee_id int,
    Salary int,
    commission_pct decimal(5,2)
);
    alter table employee_pay_info add Constraint employee_pay_FK FOREIGN KEY(info_of_employee_id)REFERENCES Info_of_empolyees(ID);
-----------------------------
INSERT INTO employee_pay_info (info_of_employee_id,Salary,commission_pct)
values(1,null,null);
INSERT INTO employee_pay_info (info_of_employee_id,Salary,commission_pct)
values(2,45000,null);
INSERT INTO employee_pay_info (info_of_employee_id,Salary,commission_pct)
values(3,65000,5.5);
INSERT INTO employee_pay_info (info_of_employee_id,Salary,commission_pct)
values(4,56,3.6);
INSERT INTO employee_pay_info (info_of_employee_id,Salary,commission_pct)
values(5,null,null);
INSERT INTO employee_pay_info (info_of_employee_id,Salary,commission_pct)
values(6,49000,null);
INSERT INTO employee_pay_info (info_of_employee_id,Salary,commission_pct)
values(7,35,null);
----------------------------
select * from employee_pay_info;
drop table employee_pay_info;
select * from Info_of_empolyees;
drop table Info_of_empolyees;
-------------------------------
--table 9--
CREATE TABLE bank_action(
    client_ID int,
    action varchar(50)
);
alter table bank_action add Constraint account_action_FK FOREIGN KEY(client_ID)REFERENCES clients(ID)
select * from bank_action
-------------------
INSERT INTO bank_action (client_ID,action)
values(1,'cash deposit');
INSERT INTO bank_action (client_ID,action)
values(2,'check');
INSERT INTO bank_action (client_ID,action)
values(5,'cash deposit');
INSERT INTO bank_action (client_ID,action)
values(7,'cash withdrawl');
INSERT INTO bank_action (client_ID,action)
values(3,'cash deposit');
INSERT INTO bank_action (client_ID,action)
values(4,'online deposit');
INSERT INTO bank_action (client_ID,action)
values(3,'online withdrawl');
INSERT INTO bank_action (client_ID,action)
values(6,'cash withrawl');
INSERT INTO bank_action (client_ID,action)
values(5,'cash deposit');
INSERT INTO bank_action (client_ID,action)
values(2,'online deposit');
INSERT INTO bank_action (client_ID,action)
values(4,'online deposit');