-- Consider the tables given below
--     STUDENT (ROLLNO, NAME, AGE, GENDER, ADDRESS, ADVISOR)
--     COURSE (COURSEID, CNAME, TAUGHTBY, CREDITS)
--     PROFESSOR (PROFID, PNAME, PHONE)
--     ENROLLMENT (ROLLNO, COURSEID, GRADE)
-- Primary keys are underlined. ADVISOR& TAUGHTBY are foreign key referring to
-- PROFESSOR table. ROLLNO and COURSEID in ENROLLMENT are also foreign keys
-- referring to the primary keys of STUDENT and COURSE.

-- (I)Write SQL queries for the following;
-- 1. List the no of courses enrolled by each student.
-- 2. List the name of students whose advisor is professor Raju
-- 3. List the name of courses in which more than 5 students enrolled
-- 4. List the name of professors who are not advisors
-- 5. Retrieve the roll no of students in the course ‘DBMS’ in the descending order of
-- grade.
-- (II) Write an SQL trigger to carry out the following actions.
-- On Withdrawal of an amount from the account, Whenever the account balance goes below
-- 1000 , the account has to be removed from bank table and add to table low_bal with attributes
-- account_no and balance.


---- 1. List the no of courses enrolled by each student.
SELECT ROLLNO,COUNT(COURSEID) AS NO_OF_COURSES
FROM ENROLLMENT
GROUP BY ROLLNO

-- 2. List the name of students whose advisor is professor Raju

SELECT NAME
FROM STUDENT S 
JOIN PROFESSOR P ON P.PROFID=S.ADVISOR
WHERE P.PNAME='Raju'
-- SQL> @QS2.SQL
--   5  /
-- NAME
-- --------------------------------------------------
-- Alice
-- Charlie

-- 3. List the name of courses in which more than 5 students enrolled

SELECT C.COURSEID,C.CNAME,COUNT(ROLLNO)
FROM COURS C JOIN ENROLLMENT E ON C.COURSEID=E.COURSEID
GROUP BY C.COURSEID,C.CNAME
HAVING COUNT(ROLLNO)>5

-- SQL> @QS2.SQL
--   5  /
--   COURSEID CNAME                                              COUNT(ROLLNO)
-- ---------- -------------------------------------------------- -------------
--        201 DBMS                                                           6

-- 4. List the name of professors who are not advisors
SELECT PROFID,PNAME 
FROM PROFESSOR
WHERE PROFID NOT IN (SELECT ADVISOR FROM STUDENT)

-- 5. Retrieve the roll no of students in the course ‘DBMS’ in the descending order of
-- grade.

SELECT E.ROLLNO,E.GRADE
FROM ENROLLMENT E JOIN COURS C ON E.COURSEID=C.COURSEID
WHERE C.CNAME='DBMS'
ORDER BY GRADE DESC

-- (II) Write an SQL trigger to carry out the following actions.
-- On Withdrawal of an amount from the account, Whenever the account balance goes below
-- 1000 , the account has to be removed from bank table and add to table low_bal with attributes
-- account_no and balance.

CREATE OR REPLACE TRIGGER CHECK_BALANCE_TRIGGER
AFTER UPDATE OF BALANCE ON BANK
FOR EACH ROW
WHEN (NEW.BALANCE < 1000)
BEGIN
    -- Insert into LOW_BAL table
    INSERT INTO LOW_BAL (ACCOUNT_NO, BALANCE)
    VALUES (:NEW.ACCOUNT_NO, :NEW.BALANCE);

    -- Delete from BANK table
    DELETE FROM BANK WHERE ACCOUNT_NO = :NEW.ACCOUNT_NO;
END;
