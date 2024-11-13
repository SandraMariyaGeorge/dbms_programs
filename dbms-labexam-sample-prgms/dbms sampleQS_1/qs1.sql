-- Consider the following tables :
--      FACULTY(FNO, NAME, GENDER, AGE,SALARY,DNUM)
--      DEPARTMENT(DNO, DNAME, DPHONE)
--      COURSE(CNO, CNAME, CREDITS, ODNO)
--      TEACHING(FNO, CNO, SEMESTER)
-- DNUM is a foreign key that identifies the department to which a faculty belongs. ODNO is a
-- foreign key identifying the department that offers a course.FNO and CNO in TEACHING
-- table refers FACULTY and COURSE
    -- (I)Write the SQL Queries for the following;
    -- 1) Find the details of faculties with highest salary
    -- 2) Find the names of faculties teaching in 5th semester
    -- 3) Course numbers and names of 3-credit courses offered by ‘CS’ department.
    -- 4) Names of faculty members teaching maximum3 courses
    -- 5) Names of departments along with number of courses offered by each of them, in the
    -- increasing order of number of courses
-- (II) Implement a PL/SQL program that uses a cursor to retrieve and display the details of
-- faculties who earn more than the average salary.

-- 1) Find the details of faculties with highest salary
SELECT * 
FROM FACULTY 
WHERE SALARY=(SELECT MAX(SALARY) FROM FACULTY);

-- 2) Find the names of faculties teaching in 5th semester
SELECT F.NAME 
FROM FACULTY F JOIN TEACHING T ON T.FNO=F.FNO 
WHERE T.SEMESTER='5';

-- 3) Course numbers and names of 3-credit courses offered by ‘CS’ department.
SELECT C.CNO,C.CNAME
FROM COURSE C JOIN DEPARTMENT D ON C.ODNO=D.DNO
WHERE C.CREDITS=3 AND D.DNAME='CS';

-- 4) Names of faculty members teaching maximum3 courses 
SELECT F.NAME 
FROM FACULTY F JOIN TEACHING T ON T.FNO=F.FNO 
GROUP BY F.NAME
HAVING COUNT(T.CNO)=3;

-- 5) Names of departments along with number of courses offered by each of them, in the increasing order of number of courses
SELECT D.DNAME,COUNT(C.CNO) AS COURSE_COUNT
FROM DEPARTMENT D JOIN COURSE C ON D.DNO=C.ODNO
GROUP BY D.DNAME
ORDER BY COURSE_COUNT;

-- (II) Implement a PL/SQL program that uses a cursor to retrieve and display the details of
-- faculties who earn more than the average salary.

DECLARE
   CURSOR high_salary_faculty IS
      SELECT FNO, NAME, SALARY, DNUM
      FROM FACULTY
      WHERE SALARY > (SELECT AVG(SALARY) FROM FACULTY);
   faculty_record high_salary_faculty%ROWTYPE;
BEGIN
   OPEN high_salary_faculty;
   LOOP
      FETCH high_salary_faculty INTO faculty_record;
      EXIT WHEN high_salary_faculty%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('FNO: ' || faculty_record.FNO || ', Name: ' ||
       faculty_record.NAME || ', Salary: ' || 
       faculty_record.SALARY || ', Department: ' || faculty_record.DNUM);
   END LOOP;
   CLOSE high_salary_faculty;
END;
-- Creating DEPARTMENT table
-- CREATE TABLE DEPARTMENT (
--     DNO INT PRIMARY KEY,
--     DNAME VARCHAR(50),
--     DPHONE VARCHAR(15)
-- );

-- Creating FACULTY table
-- CREATE TABLE FACULTY (
--     FNO INT PRIMARY KEY,
--     NAME VARCHAR(50),
--     GENDER CHAR(1),
--     AGE INT,
--     SALARY DECIMAL(10, 2),
--     DNUM INT,
--     FOREIGN KEY (DNUM) REFERENCES DEPARTMENT(DNO)
-- );

-- Creating COURSE table
-- CREATE TABLE COURSE (
--     CNO INT PRIMARY KEY,
--     CNAME VARCHAR(50),
--     CREDITS INT,
--     ODNO INT,
--     FOREIGN KEY (ODNO) REFERENCES DEPARTMENT(DNO)
-- );

-- Creating TEACHING table
-- CREATE TABLE TEACHING (
--     FNO INT,
--     CNO INT,
--     SEMESTER VARCHAR(10),
--     PRIMARY KEY (FNO, CNO, SEMESTER),
--     FOREIGN KEY (FNO) REFERENCES FACULTY(FNO),
--     FOREIGN KEY (CNO) REFERENCES COURSE(CNO)
-- );