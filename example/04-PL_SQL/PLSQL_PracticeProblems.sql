-- ======================
-- FUNCTIONS & PROCEDURES
-- ======================

-- 1. -- Write a PL/SQL function that given a score, returns a letter grade 
-- (A >= 90, B >= 80, C >= 70, D >= 60, F < 60)

CREATE OR REPLACE FUNCTION GradeMessage(score Test.Score%type)  
RETURN Test.ID%TYPE AS
    grade CHAR(1);
BEGIN
    -- one way...
    IF (score >= 90) THEN    
        grade := 'A';
    ELSIF (score >= 80) THEN    
        grade := 'B';
    ELSIF (score >= 70) THEN    
        grade := 'C';
    ELSIF (score >= 60) THEN    
        grade := 'D';
    ELSIF (score <  60) THEN    
        grade := 'F';
    ELSE                        
        grade := 'X';
    END IF;
/* alternative
    CASE (grade)
        WHEN 'A' THEN gradeResult := 'Excellent!';
        WHEN 'B' THEN gradeResult := 'Very good';
        WHEN 'C' THEN gradeResult := 'Satisfactory';
        WHEN 'D' THEN gradeResult := 'Borderline';
        WHEN 'F' THEN gradeResult := 'Failed';
        ELSE gradeResult := 'Invalid grade...?';
    END CASE; 
*/    
    --DBMS_OUTPUT.PUT_LINE(grade);
    RETURN grade;
END;
/



-- 2. Write a PL/SQL procedure that prints the Student ID, Name, and Major for a given student ID. 

-- QUERY
SELECT Exam, GradeMessage(Score)
FROM Test;

-- FUNCTION
DECLARE
    targetID student.ID%TYPE := '2804';
    targetName student.Name%TYPE;
    targetMajor student.Major%TYPE;
BEGIN
    SELECT Name, Major INTO targetName, targetMajor
    FROM Student
    WHERE ID = targetID;

    DBMS_OUTPUT.PUT_LINE('ID: ' || targetID || ', Name: ' || targetName || ', Major: ' || targetMajor)
END;
/

-- PROCEDURE
CREATE OR REPLACE PROCEDURE StudentData(targetID student.ID %TYPE)
AS
    targetName student.Name%TYPE;
    targetMajor student.Major%TYPE;
BEGIN
    SELECT Name, Major INTO targetName, targetMajor
    FROM Student
    WHERE ID = targetID;

    DBMS_OUTPUT.PUT_LINE('ID: ' || targetID || ', Name: ' || targetName || ', Major: ' || targetMajor);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Student ID' || targetID || ' does not exist.');
END;
/

call StudentData('1716');



-- 3. Write a PL/SQL block that prints the all students and their score for a given test (e.g., Midterm, Final).

CREATE OR REPLACE PROCEDURE StudentData2 (targetExam Test.Exam%type)
AS
    --DECLARE     
    CURSOR studentCur IS (SELECT S.ID, S.Name, S.Major, T.Exam, T.Score  
                          FROM Student S, Test T 
                          WHERE S.ID = T.ID
                          AND T.Exam = targetExam);
    studentInfo studentCur%rowtype;
BEGIN
    FOR studentInfo IN studentCur LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || studentInfo.ID);
        DBMS_OUTPUT.PUT_LINE('    Name: ' || studentInfo.Name || '  Major: ' || studentInfo.Major);
        DBMS_OUTPUT.PUT_LINE('    Exam: ' || studentInfo.Exam || ' Score: ' || studentInfo.Score);
    END LOOP;    
END;

call StudentData2('Final');


-- ======================
-- TRIGGERS
-- ======================

-- 4. EXAMPLE

-- DATA

DROP TABLE WORKER;
CREATE TABLE Worker(
  W_Name VARCHAR(20),
  W_JobTitle VARCHAR(20),
  W_Salary NUMBER
);
INSERT INTO Worker VALUES ('Bob', 'Baker', 45000);
INSERT INTO Worker VALUES ('Carl', 'Chef', 52000);
INSERT INTO Worker VALUES ('Dan', 'Dishwasher', 34000);
INSERT INTO Worker VALUES ('Hank', 'Host', 42000);
INSERT INTO Worker VALUES ('Megan', 'Manager', 60000);
INSERT INTO Worker VALUES ('Sally', 'Server', 44000);
commit;

-- PL/SQL 

CREATE OR REPLACE TRIGGER SalaryGuarantee
BEFORE UPDATE OF W_Salary ON Worker
FOR EACH ROW
WHEN (new.w_salary < old.w_salary)
BEGIN
  :new.w_salary := :old.w_salary;
  DBMS_OUTPUT.PUT_LINE('Rejected change of salary');
  --raise_application_error(-20102, 'Invalid salary update!');
END;
/
UPDATE Worker 
SET W_Salary = 40000
WHERE W_Name = 'Sally';

SELECT * FROM Worker;



-- Practice #5
CREATE OR REPLACE TRIGGER SalaryCap AFTER INSERT OR UPDATE ON WORKER
	DECLARE
		Total INTEGER;
	BEGIN
		SELECT SUM(Salary) INTO Total
		FROM Worker;

		DBMS_OUTPUT.PUT_LINE(Total);

		If (Total > 1000000) THEN
			RAISE_APPLICATION_ERROR(-20001, 'Million Dollar Limit Exceeded');
		END IF;
	END;

INSERT INTO Worker VALUES('P', 2, 900000);

SELECT SUM(Salary) FROM Worker; 



-- PRACTICE DATA

-- DDL
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;

CREATE TABLE DEPARTMENT
(
 DNo  NUMBER(1, 0),
 DName  VARCHAR2(20),
 TotalSalary NUMBER(9, 2),

 PRIMARY KEY (Dno)
);

CREATE TABLE EMPLOYEE
(
 EID  CHAR(3),
 Name  VARCHAR2(20),
 DNo  NUMBER(1, 0) NOT NULL,
 Salary NUMBER(9,2),

 PRIMARY KEY (EID),

 FOREIGN KEY (DNo)
  REFERENCES DEPARTMENT(DNo)
);

-- DML
INSERT INTO DEPARTMENT VALUES
 ('1', 'Accounting', 0);
INSERT INTO DEPARTMENT VALUES
 ('2', 'Marketing', 0);
INSERT INTO EMPLOYEE VALUES
 ('990', 'Clark Kent', '1', 150000);
INSERT INTO EMPLOYEE VALUES
 ('454', 'Bruce Wayne', '1', 120000);
INSERT INTO EMPLOYEE VALUES
 ('197', 'Diana Prince', '1', 90000);
INSERT INTO EMPLOYEE VALUES
 ('660', 'Tony Stark', '2', 180000);
INSERT INTO EMPLOYEE VALUES
 ('823', 'Natasha Romanoff', '2', 125000);
INSERT INTO EMPLOYEE VALUES
 ('123', 'Steve Rogers', '2', '100000');

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

-- Practice #6.
CREATE OR REPLACE TRIGGER AddingEmployee
AFTER INSERT ON EMPLOYEE
	FOR EACH ROW
	BEGIN
	DBMS_OUTPUT.PUT_LINE('Adding new employee');
	UPDATE DEPARTMENT
	SET TotalSalary = TotalSalary + :new.Salary
	WHERE Dno = :new.Dno;
	END;
	/

--Practice #7.
CREATE OR REPLACE TRIGGER RemovingEmployee
AFTER DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('Removing employee');
UPDATE DEPARTMENT
SET TotalSalary = TotalSalary - :old.Salary
WHERE Dno = :old.Dno;
END;
/

DELETE FROM Employee WHERE EID = '990';

SELECT * FROM EMPLOYEE;

SELECT * FROM DEPARTMENT;



--Practice #8.
CREATE OR REPLACE TRIGGER ChangingDepartment
AFTER UPDATE OF Dno ON EMPLOYEE
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('Changing employee department');
UPDATE DEPARTMENT
SET TotalSalary = TotalSalary + :new.Salary
WHERE Dno = :new.Dno;
UPDATE DEPARTMENT
SET TotalSalary = TotalSalary - :old.Salary
WHERE Dno = :old.Dno;
END;










