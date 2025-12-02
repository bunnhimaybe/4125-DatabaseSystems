--Practice #1

CREATE OR REPLACE FUNCTION GradeMessage(score Test.Score%type)  
RETURN Test.ID%TYPE AS
    grade CHAR(1);
    
BEGIN
    -- one way...
    IF    (score >= 90) THEN    grade := 'A';
    ELSIF (score >= 80) THEN    grade := 'B';
    ELSIF (score >= 70) THEN    grade := 'C';
    ELSIF (score >= 60) THEN    grade := 'D';
    ELSIF (score <  60) THEN    grade := 'F';
    ELSE                        grade := 'Invalid score';
    END IF;
    -- or the other way...
    /*
    CASE (grade)
        WHEN 'A' THEN gradeResult := 'Excellent!';
        WHEN 'B' THEN gradeResult := 'Very good';
        WHEN 'C' THEN gradeResult := 'Satisfactory';
        WHEN 'D' THEN gradeResult := 'Borderline';
        WHEN 'F' THEN gradeResult := 'Failed';
        ELSE gradeResult := 'Invalid grade...?';
    END CASE; */
    
    --DBMS_OUTPUT.PUT_LINE(grade);
    RETURN 'A';
END;
/

SELECT Exam, GradeMessage(Score)
FROM Test;



CREATE OR REPLACE PROCEDURE StudentData (targetID student.ID%type)
AS
    stID student.ID%type;
    stName student.Name%type;
    stMajor student.Major%type;
BEGIN
    SELECT Name, ID, Major INTO stName, stID, stMajor 
    FROM Student 
    WHERE ID = targetID;

    DBMS_OUTPUT.PUT_LINE( 'Query done!' );
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE( 'For ID ' || stID || ':');
    DBMS_OUTPUT.PUT_LINE( 'Name is ' || stName || ', Major is ' || stMajor);
EXCEPTION
    WHEN No_Data_Found THEN
        DBMS_OUTPUT.PUT_LINE('Student #' || targetID || ' does not exist');


END;
/

call StudentData('1131');


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



--Practice #5.
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


--Practice #6.
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










