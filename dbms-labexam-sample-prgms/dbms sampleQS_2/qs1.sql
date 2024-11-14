-- Create the following tables and insert  values into the tables : 
-- FACULTY(FNO, NAME, GENDER, AGE,SALARY,DNUM)  
-- DEPARTMENT(DNO, DNAME, DPHONE)  
-- COURSE(CNO, CNAME, CREDITS, ODNO)  
-- Primary keys are underlined. DNUM is a foreign key that identifies the department to which a faculty 
-- belongs. ODNO is a foreign key identifying the department that offers a course. 

-- i. Rename the column Credits to total credits 
-- ii. List name of faculties along with their department names whose names starts with ‘J’ and ‘N’ 
-- as third character 
-- iii. Find the average salary of all  male faculties in CS department 
-- iv. Find the name of departments offering more than two courses. 
-- v. Find the names of  departments offering both DBMS and OS courses 

-- II Write a PL/SQL program to print the five highest paid  faculties  using cursors

-- i. Rename the column Credits to total credits 

ALTER TABLE COURSE RENAME COLUMN CREDITS TO TOTAL_CREDITS;

-- ii. List name of faculties along with their department names whose names starts with ‘J’ and ‘N’ 
-- as third character 

SELECT F.NAME,D.DNAME
FROM FACULTY F JOIN DEPARTMENT D ON F.DNUM=D.DNO
WHERE F.NAME LIKE 'J_n%';

-- iii. Find the average salary of all male faculties in CS department 

SELECT AVG(SALARY)
FROM FACULTY F JOIN DEPARTMENT D ON F.DNUM=D.DNO
WHERE F.GENDER='M' AND D.DNAME='Math';

-- iv. Find the name of departments offering more than two courses. 

SELECT D.DNAME
FROM DEPARTMENT D JOIN COURSE C ON D.DNO=C.DNO
GROUP BY D.DNAME
HAVING COUNT(C.DNO)>2;

-- v. Find the names of  departments offering both DBMS and OS courses 

SELECT D.DNAME
FROM DEPARTMENT D
JOIN COURSE C1 ON D.DNO = C1.DNO
JOIN COURSE C2 ON D.DNO = C2.DNO
WHERE C1.CNAME = 'DBMS' AND C2.CNAME = 'OS';

-- II Write a PL/SQL program to print the five highest paid  faculties  using cursors

DECLARE 
    CURSOR TOPPAIDFACULTY IS 
        SELECT NAME,SALARY
        FROM FACULTY
        ORDER BY SALARY DESC
        FETCH FIRST 5 ROWS ONLY;
    V_NAME FACULTY.NAME%TYPE;
    V_SALARY FACULTY.SALARY%TYPE;
BEGIN
    OPEN TOPPAIDFACULTY;
    LOOP
        FETCH TOPPAIDFACULTY INTO V_NAME,V_SALARY;
        EXIT WHEN TOPPAIDFACULTY%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('NAME :'||V_NAME||' SALARY :'||V_SALARY);
    END LOOP;
    CLOSE TOPPAIDFACULTY;
END;
    