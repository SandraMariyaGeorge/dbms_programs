-- Create a cursor with parameters that retrieves orders from an ORDERS table
-- based on a specified date range. Use this cursor to display the order IDs 
-- and customer names within that date range.(Cursor with Parameters)

-- CREATE TABLE ORDERS(
--      order_id varchar(20),
--      customer_name varchar(20),
--      order_date date, 
--      primary key(order_id));

-- INSERT INTO ORDERS VALUES('&ORDER_ID','&CUSTOMER_NAME','&ORDER_DATE');

-- SELECT * FROM ORDERS;
-- ORDER_ID             CUSTOMER_NAME        ORDER_DAT
-- -------------------- -------------------- ---------
-- 1000                 CHRISTA              17-JAN-08
-- 1001                 ANIE                 20-FEB-16
-- 1002                 JOEL                 29-OCT-99
-- 1003                 GEORGE               28-DEC-03
-- 1004                 CELINE               04-JUL-06
-- 1005                 JOAH                 20-NOV-20

DECLARE CURSOR C2 (START_DATE DATE,END_DATE DATE) IS
    SELECT ORDER_ID,CUSTOMER_NAME,ORDER_DATE FROM ORDERS WHERE ORDER_DATE BETWEEN START_DATE AND END_DATE;
BEGIN
    FOR REC IN C2(TO_DATE('&START_DATE','DD-MON-YYYY'),TO_DATE('&END_DATE','DD-MON-YYYY'))
    LOOP
        DBMS_OUTPUT.PUT_LINE('ORDER ID:'||REC.ORDER_ID||' CUSTOMER NAME:'||REC.CUSTOMER_NAME||' ORDER DATE:'||REC.ORDER_DATE);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR !!'||SQLERRM);
END;

-- SQL> /
-- Enter value for start_date: 10-JUL-2015
-- Enter value for end_date: 20-OCT-2022
-- old   4:     FOR REC IN C2(TO_DATE('&START_DATE','DD-MON-YYYY'),TO_DATE('&END_DATE','DD-MON-YYYY'))
-- new   4:     FOR REC IN C2(TO_DATE('10-JUL-2015','DD-MON-YYYY'),TO_DATE('20-OCT-2022','DD-MON-YYYY'))
-- ORDER ID:1001 CUSTOMER NAME:ANIE ORDER DATE:20-FEB-16
-- ORDER ID:1005 CUSTOMER NAME:JOAH ORDER DATE:20-NOV-20

-- PL/SQL procedure successfully completed.

-- Commit complete.