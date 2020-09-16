--NOUR KAHILE--                                                    			--------------------Final Project---------------------
    
                                                
--First code block--
DECLARE
    CURSOR employee_basic_info IS
    SELECT clients.FirstName,clients.lastname,clients.phone_num
        FROM Clients
        INNER JOIN employees                            -->this block of code will retrive the employee's first name, last name, and phone number
    ON Clients.FirstName = employees.firstname
    and Clients.LastName = employees.lastname
    and clients.phone_num = employees.phonenum;
BEGIN
    FOR r_product IN employee_basic_info
  LOOP
    dbms_output.put_line('First Name: ' || r_product.FirstName);
    dbms_output.put_line('Last Name: ' || r_product.LastName);
    dbms_output.put_line('Phone Number: ' || r_product.phone_num);
    dbms_output.put_line('*************************'); 
    END LOOP;
END; 
/
---------------------------
create table employees_random_passwords(
    id int,                                                 -->This table will hold random employees passwords
    Password varchar(225)
);
----------------------------
drop table employees_random_passwords;        
select * from employees_random_passwords;
---------------------------- 
--Second code Block--
--will will insert into employees_random_passwords random passwords--
DECLARE
    employee_id int;
    CURSOR employee_cur IS
    SELECT ID
    FROM employees;
BEGIN
    OPEN employee_cur; 
    LOOP
        FETCH employee_cur INTO employee_id;
        EXIT WHEN employee_cur%NOTFOUND;
        INSERT INTO employees_random_passwords(ID,Password)
        VALUES (employee_id,DBMS_RANDOM.string('X',DBMS_RANDOM.value(8,20)));

    END LOOP;
    CLOSE employee_cur;
END; 
/
---------------------------------------------
CREATE TABLE Account_LOG(
    ID int,
    Accounts_type_id int,
    Open_date date,                                     -->This table will hold values once (account_after_deletion) fires
    date_of_account_deletion DATE,
    MOD_USER VARCHAR2(10),
    constraint ACCOUNT_LOG_PK primary key(ID)
);
-----------------------------------------------
select * from Account_LOG;
drop table Account_LOG;
DROP TRIGGER account_after_deletion; 
----------------------------------------------
--Third code Block
--Trigger#1--
CREATE OR REPLACE TRIGGER account_after_deletion
AFTER DELETE
    ON accounts
    FOR EACH ROW                                        -->the trigger that will fire when we delete any account from accounts--
    DECLARE
          v_username varchar2(10);
     BEGIN
         SELECT user INTO v_username
          FROM dual;
 
     INSERT INTO Account_LOG(id,Accounts_type_id,open_Date,date_of_account_deletion,MOD_USER)
        VALUES (:old.id,:old.Account_type,:old.Open_Date,sysdate,v_username);
END;
/
-------------------------------------
DELETE FROM accounts WHERE id = 7;      -->to test the trigger
--------------------------------------
CREATE TABLE action_LOG(
    clients_id int,
    action_made varchar(50),                             -->This table will hold the clientS action values wether it's deposit or check..etc
    action_date date,
    constraint Action_LOG_PK primary key(clients_id)
);
---------------------------------
drop table action_log;
select * from action_log;
---------------------------------
drop trigger action_after_insert;
--Trigger#2--
CREATE OR REPLACE TRIGGER action_after_insert               -->Trigger will fire and insert into the action_LOG table
AFTER INSERT
    ON bank_action
    FOR EACH ROW                                            
     BEGIN
     INSERT INTO action_log(clients_id,action_made,action_date)
        VALUES (:new.client_id,:new.action,sysdate);
END;
/
-----------------------------------
--Fourth code block
CREATE OR REPLACE FUNCTION totalClients
RETURN number IS 
   total_clients number(2) := 0; 
BEGIN 
   SELECT count(*) into total_clients             -->First function, will counts the total clients
   FROM clients; 
    
   RETURN total_clients; 
END; 
/ 

-------------------------------------
select totalClients() as total_clients from dual;   --> to test the first Function
-------------------------------------
CREATE OR REPLACE FUNCTION last_first_name(empid number)
  RETURN VARCHAR2 IS
  lastname  employees.lastName%TYPE;
  firstname employees.firstName%TYPE;                   -->Second function, will give you info on employees by entering the ID number
  begin
  SELECT lastName,firstName INTO lastname, firstname FROM employees
  where id = empid;
  RETURN ( 'Employee: ' || empid || ' - ' || UPPER(lastname) 
                                 || ', ' || UPPER(firstname));
END last_first_name; 
/
--------------------------------------
SELECT last_first_name(4) FROM DUAL;    -->To test the second function
--------------------------------------
--Fourth code block
--Procedure#1
CREATE OR REPLACE PROCEDURE award_bonus (emp_id IN NUMBER, bonus_rate IN NUMBER)
  AS
   emp_comm    employee_pay_info.commission_pct%TYPE;
   emp_sal    employee_pay_info.salary%TYPE;
   salary_missing  EXCEPTION;
BEGIN -->This procedure check the salary and comission percentage in the employee_pay_info table,
--if the employee takes comission the there will be no bouns,
--if they don't take comission it will calculate bouns for them
   SELECT salary, commission_pct INTO emp_sal, emp_comm FROM employee_pay_info
    WHERE info_of_employee_id = emp_id;
   IF emp_sal IS NULL THEN
     RAISE salary_missing;
   ELSE 
     IF emp_comm IS NULL THEN
       DBMS_OUTPUT.PUT_LINE('Employee ' || emp_id || ' receives a bonus: ' 
                            || TO_CHAR(emp_sal * bonus_rate) );
     ELSE
       DBMS_OUTPUT.PUT_LINE('Employee ' || emp_id 
                            || ' receives a commission. No bonus allowed.');
     END IF;
   END IF;
EXCEPTION 
   WHEN salary_missing THEN
      DBMS_OUTPUT.PUT_LINE('Employee ' || emp_id || 
                           ' does not have a value for salary. No update.');
   WHEN OTHERS THEN
      NULL;
END award_bonus;
/

BEGIN
  award_bonus(4, 0.05);
END;
/

-------------------------------------------------------------------
--Fifth code block--
--Procedure#2
CREATE OR REPLACE PROCEDURE create_log_table 
  AUTHID CURRENT_USER AS 
  tabname       VARCHAR2(30);
  temptabname   VARCHAR2(30);
BEGIN
                                    -->This procedure will make it easier for the user to creat log tables
  tabname := 'Nour_bank_table';

  SELECT TABLE_NAME INTO temptabname FROM USER_TABLES 
    WHERE TABLE_NAME = UPPER(tabname);

  EXCEPTION
    WHEN NO_DATA_FOUND THEN 
      BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE ' || tabname 
                         || '(ID int, Bank VARCHAR2(50))' ;
        DBMS_OUTPUT.PUT_LINE(tabname || ' has been created');
      END;

END create_log_table;
/
--------------------------
BEGIN 
  create_log_table;    -->Excute to create the table
END;
/
-----------------------------
select * from Nour_bank_table;
drop table Nour_bank_table;
drop procedure create_log_table;
-----------------------------
--sixth code block--
--Creating a package--
CREATE OR REPLACE PACKAGE e_package AS 
        --adds an employee
   PROCEDURE addEmployee(
      e_id  employees.id%type, 
      e_firstName employees.firstName%type,      -->Declaring the package
      e_LastName  employees.lastName%type,       
      phoneNumber  employees.phoneNum%type); 
   
   -- Removes an employee
   PROCEDURE delEmployee(e_id  Employees.id%TYPE); 
END e_package; 
/
--------------------------------
CREATE OR REPLACE PACKAGE BODY e_package AS 
   PROCEDURE addEmployee(
      e_id  employees.id%type, 
      e_firstName employees.firstName%type, 
      e_LastName  employees.lastName%type, 
      phoneNumber  employees.phoneNum%type)
   IS
   BEGIN 
      INSERT INTO employees(id,firstName,lastName,phonenum) 
         VALUES(e_id, e_firstName, e_lastName, phoneNumber);  -->The package will store two procedures one to delete employee and one to add employee
   END addEmployee; 
   
   PROCEDURE delEmployee(e_id   employees.id%type) IS 
   BEGIN 
      DELETE FROM employees 
      WHERE id = e_id; 
   END delEmployee;  
   
END e_package; 
/
-----------------------------------
-->to test the package to add<--- 
BEGIN 
   e_package.addEmployee(8, 'nour','kahile','317-985-4295'); 
END; 
/ 
------------------------------------
-->to test the package to delete<--
BEGIN 
   e_package.delEmployee(8); 
END; 
/
-----------------------------------
--seventh block
CREATE OR REPLACE TYPE customer AS OBJECT 
(code number(5), 
 name varchar2(30), 
 account_id int (30)
 member procedure display 
); 
/
------------------------------------