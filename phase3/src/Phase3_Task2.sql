-- Nurse(nurse_id, nurse_name, nurse_salary, nurse_supervisor_id)

CREATE OR REPLACE PROCEDURE HospitalReport(report_id Nurse.nurse_id%type)
AS
    report_name Nurse.nurse_name%type;
    supervisee_count INTEGER := 0;
    supervisee_salaries INTEGER := 0;
    supervisee_beds NUMBER := 0; 
    CURSOR Supervisees IS 
        SELECT nurse_id, nurse_name
        FROM Nurse WHERE nurse_supervisor_id = report_id;
BEGIN
    -- nurse exists?
    SELECT nurse_name INTO report_name 
        FROM Nurse WHERE nurse_id = report_id;
    -- supervisee exists? calculate supervisee count and total salaries
    SELECT COUNT(*), SUM(nurse_salary) 
        INTO supervisee_count, supervisee_salaries
        FROM Nurse WHERE nurse_supervisor_id = report_id; 
    IF supervisee_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('This nurse is not a supervisor.');
        RETURN;
    END IF;
    -- print report details
    DBMS_OUTPUT.PUT_LINE('Supervisor report for: ' || report_name);
    DBMS_OUTPUT.PUT_LINE(
        'Nurses supervised: ' || supervisee_count || 
        ' ($' || supervisee_salaries || ')');
    DBMS_OUTPUT.NEW_LINE();
    -- print supervisor report 
    DBMS_OUTPUT.PUT_LINE(
        RPAD('ID', 10, ' ') || 
        RPAD('Name', 25, ' ') || 
        RPAD('# of Beds', 10, ' ') );
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 35, '-'));
    FOR supervisee IN Supervisees LOOP
        -- calculate count of beds monitored by each supervisee 
        SELECT COUNT(*) INTO supervisee_beds
            FROM Bed WHERE nurse_id = supervisee.nurse_id;
        DBMS_OUTPUT.PUT_LINE(
            RPAD(TO_CHAR(supervisee.nurse_id), 10, ' ') || 
            RPAD(supervisee.nurse_name, 25, ' ') || 
            LPAD(TO_CHAR(supervisee_beds), 10, ' ') );
    END LOOP;
EXCEPTION
    -- nurse does not exist
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No nurse found with the given ID!');
        RETURN;
END;
/