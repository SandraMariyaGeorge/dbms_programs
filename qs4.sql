-- Create a BEFORE INSERT trigger on an EMPLOYEES table to ensure that the SALARY value
-- is above a certain minimum threshold. If the salary is below the threshold, raise an error.

-- SQL> SELECT * FROM EMPLOY;

-- EMPLOYEE_ID FIRST_NAME                                         LAST_NAME                                              SALARY DEPARTMENT_ID
-- ----------- -------------------------------------------------- -------------------------------------------------- ---------- -------------
--         101 Alice                                              Johnson                                                 50000             1
--         102 Bob                                                Smith                                                   60000             2
--         103 Carol                                              Williams                                                70000             3
--         104 David                                              Brown                                                   80000             4
--         105 Eve                                                Davis                                                   75000             3
--         106 Frank                                              Miller                                                  45000             2
--         107 Grace                                              Wilson                                                  55000             1
--         108 Henry                                              Moore                                                   72000             3

-- 8 rows selected.

CREATE OR REPLACE TRIGGER SALARY_CHECK
BEFORE INSERT ON EMPLOY
FOR EACH ROW
DECLARE
    MIN_SALARY NUMBER := 50000;
BEGIN
    IF :NEW.SALARY < MIN_SALARY THEN
        RAISE_APPLICATION_ERROR(-20001, 'SALARY SHOULD BE GREATER THAN ' || MIN_SALARY);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR !! ' || SQLERRM);
        RAISE;
END;