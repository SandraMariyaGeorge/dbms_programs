-- Write a PL/SQL program using a cursor to calculate and display the average salary 
-- for each department in a DEPARTMENTS table.
-- Create DEPARTMENTS table
-- CREATE TABLE DEPARTMENTS (
--     department_id NUMBER PRIMARY KEY,
--     department_name VARCHAR2(50)
-- );

-- -- Create EMPLOY table with a foreign key referencing DEPARTMENTS
-- CREATE TABLE EMPLOY (
--     employee_id NUMBER PRIMARY KEY,
--     first_name VARCHAR2(50),
--     last_name VARCHAR2(50),
--     salary NUMBER(10, 2),
--     department_id NUMBER,
--     FOREIGN KEY (department_id) REFERENCES DEPARTMENTS(department_id)
-- );

-- -- Insert sample data into DEPARTMENTS table
-- INSERT INTO DEPARTMENTS (department_id, department_name) VALUES (1, 'Human Resources');
-- INSERT INTO DEPARTMENTS (department_id, department_name) VALUES (2, 'Finance');
-- INSERT INTO DEPARTMENTS (department_id, department_name) VALUES (3, 'Engineering');
-- INSERT INTO DEPARTMENTS (department_id, department_name) VALUES (4, 'Sales');

-- -- Insert sample data into EMPLOY table
-- INSERT INTO EMPLOY (employee_id, first_name, last_name, salary, department_id) VALUES (101, 'Alice', 'Johnson', 50000, 1);
-- INSERT INTO EMPLOY (employee_id, first_name, last_name, salary, department_id) VALUES (102, 'Bob', 'Smith', 60000, 2);
-- INSERT INTO EMPLOY (employee_id, first_name, last_name, salary, department_id) VALUES (103, 'Carol', 'Williams', 70000, 3);
-- INSERT INTO EMPLOY (employee_id, first_name, last_name, salary, department_id) VALUES (104, 'David', 'Brown', 80000, 4);
-- INSERT INTO EMPLOY (employee_id, first_name, last_name, salary, department_id) VALUES (105, 'Eve', 'Davis', 75000, 3);
-- INSERT INTO EMPLOY (employee_id, first_name, last_name, salary, department_id) VALUES (106, 'Frank', 'Miller', 45000, 2);
-- INSERT INTO EMPLOY (employee_id, first_name, last_name, salary, department_id) VALUES (107, 'Grace', 'Wilson', 55000, 1);
-- ``INSERT INTO EMPLOY (employee_id, first_name, last_name, salary, department_id) VALUES (108, 'Henry', 'Moore', 72000, 3);``

DECLARE CURSOR C3 IS 
    SELECT DEPARTMENT_ID,AVG(SALARY) AS AVG_SALARY 
    FROM EMPLOY 
    GROUP BY DEPARTMENT_ID;
BEGIN
    FOR REC IN C3
    LOOP
        DBMS_OUTPUT.PUT_LINE('DEPARTMENT_ID: '||REC.DEPARTMENT_ID||' AVG_SALARY: '||REC.AVG_SALARY);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR !!'||SQLERRM);
END;

-- SQL> @qs3.sql 
--  16  /
-- DEPARTMENT_ID: 1 AVG_SALARY: 52500
-- DEPARTMENT_ID: 2 AVG_SALARY: 52500
-- DEPARTMENT_ID: 3 AVG_SALARY: 72333.33
-- DEPARTMENT_ID: 4 AVG_SALARY: 80000

-- PL/SQL procedure successfully completed.