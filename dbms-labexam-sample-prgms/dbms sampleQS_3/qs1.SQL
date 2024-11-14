-- I. Create the Tables with the given constraints. Primary keys are underlined.  
-- ACC_NO,MEMBERID in ISSUEDTO   table are foreign keys 
-- BOOKS (ACC_NO,ISBN,TITLE, EDITION, YEAR) 
-- MEMBERS(MEMBERID, MEMBERNAME, MEMBERTYPE) 
-- ISSUEDTO (ACC_NO, MEMBERID, DATE OF ISSUE) 
--     a) Write a SQL query  to retrieve Accession Number(s) and Name(s) of third edition 
--     books published in  2018. 
--     b) Write a query to retrieve number of books issued in each date. 
--     c) Write a query to retrieve the names of books, issued in the month of  March 
--     d) Write  a query  to retrieve names and date of issue of books taken by “ARYA’ 
--     e) Write a query to retrieve the names of books , not taken by any member 

--ANSWERS

--a) Write a SQL query  to retrieve Accession Number(s) and Name(s) of third edition 
--books published in  2018. 
SELECT ACC_NO,TITLE
FROM BOOKS
WHERE EDITION=3 AND YEAR='2018';

--b) Write a query to retrieve number of books issued in each date. 
SELECT DATE_OF_ISSUE,COUNT(ACC_NO) AS NO_OF_BOOKS_ISSUED
FROM ISSUEDTO
GROUP BY DATE_OF_ISSUE;

--c) Write a query to retrieve the names of books, issued in the month of  March 
SELECT B.TITLE,I.DATE_OF_ISSUE
FROM BOOKS B JOIN ISSUEDTO I ON B.ACC_NO=I.ACC_NO
WHERE EXTRACT(MONTH FROM I.DATE_OF_ISSUE)=3;

--d) Write a query to retrieve names and date of issue of books taken by “ARYA’ 
SELECT B.TITLE,M.MEMBERNAME,I.DATE_OF_ISSUE
FROM ISSUEDTO I 
JOIN MEMBERS M ON M.MEMBERID=I.MEMBERID
JOIN BOOKS B ON I.ACC_NO=B.ACC_NO
WHERE M.MEMBERNAME='ARYA';

-- e) Write a query to retrieve the names of books , not taken by any member 
SELECT TITLE 
FROM BOOKS
WHERE ACC_NO NOT IN (SELECT ACC_NO FROM ISSUEDTO);

-- II.Create table Employee (eno,ename,deptno,salary)   
-- Write a procedure to calculate the income tax paid as follows. 
--     a) If  salary for a financial year is less than 1 lakh, he needs to pay no tax. 
--     b) If  salary is between 1 lakh and 1.5 lakh, tax is calculated as 10% of amount exceeding 
--     1 lakh 
--     c) If  salary is between 1.5 lakh and 2 lakhs, 20% of the amount exceeding 1 lakh is 
--     taxable.  
--     d) If salary is above 2 lakhs, 30% of the amount exceeding 1 lakh is taxable. 
--     Store the details in a new table ”Tax” having fields eno, deptno, & tax_amount.

CREATE OR REPLACE PROCEDURE CalculateTax IS
    tax NUMBER;

    e_no EMP.ENO%TYPE;
    e_deptno EMP.DEPTNO%TYPE;
    e_salary EMP.SALARY%TYPE;

    CURSOR emp_cursor IS
        SELECT ENO, DEPTNO, SALARY FROM EMP;

BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO e_no, e_deptno, e_salary;
        EXIT WHEN emp_cursor%NOTFOUND; 

        IF e_salary < 100000 THEN
            tax := 0;
        ELSIF e_salary BETWEEN 100000 AND 150000 THEN
            tax := (e_salary - 100000) * 0.10;
        ELSIF e_salary BETWEEN 150000 AND 200000 THEN
            tax := (e_salary - 100000) * 0.20;
        ELSE
            tax := (e_salary - 100000) * 0.30;
        END IF;

        INSERT INTO TAX (ENO, DEPTNO, TAX_AMOUNT) 
        VALUES (e_no, e_deptno, tax);
    END LOOP;

    CLOSE emp_cursor;
END;
/

BEGIN
    CalculateTax;
END;
/
-- SQL> SELECT * FROM EMP;

--        ENO ENAME                                                  DEPTNO     SALARY
-- ---------- -------------------------------------------------- ---------- ----------
--          1 Alice                                                     101      80000
--          2 Bob                                                       102     120000
--          3 Charlie                                                   103     160000       
--          4 David                                                     104     220000       
--          5 Eve                                                       105     250000 

-- SQL> SELECT * FROM TAX;

--        ENO     DEPTNO TAX_AMOUNT
-- ---------- ---------- ----------
--          1        101          0
--          2        102       2000
--          3        103      12000
--          4        104      36000
--          5        105      45000`