-- 1. INSERT TRIGGER: Check how many beds a nurse is monitoring.

CREATE TRIGGER AddBed
BEFORE INSERT ON Bed
FOR EACH ROW
DECLARE
    NumBeds INTEGER; 
BEGIN
    SELECT BedsMonitored INTO NumBeds FROM Nurse
    WHERE nurse_id = :NEW.nurse_id;
    -- Nurse is too busy to monitor more beds.
    IF (NumBeds >= 2) THEN
        RAISE_APPLICATION_ERROR(-20011, 'Nurse is too busy.');
    END IF;
EXCEPTION
    -- Nurse not assigned
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010, 'Invalid or NULL Nurse ID.');
END;/



-- 2. DELETE TRIGGER: Removing a bed updates the number of beds a nurse is monitoring. 

CREATE TRIGGER RemoveBed
AFTER DELETE ON Bed
FOR EACH ROW
BEGIN
    UPDATE Nurse SET BedsMonitored = GREATEST(BedsMonitored-1, 0)
    WHERE nurse_id = :OLD.nurse_id;     
END;/



-- 3. UPDATE TRIGGER: Bed assignment of Nurse is changed. 

CREATE TRIGGER UpdateBed
BEFORE UPDATE OF nurse_id ON Bed
FOR EACH ROW
DECLARE
    NewNumBeds INTEGER;
BEGIN
    -- check if new nurse is too busy
    SELECT BedsMonitored INTO NewNumBeds FROM Nurse
        WHERE nurse_id = :NEW.nurse_id;
    IF (NewNumBeds >= 3) THEN
        -- cancel update if new nurse is too busy
        RAISE_APPLICATION_ERROR(-20011, 'Nurse is too busy.');
    ELSE
        -- update old nurse 
        UPDATE Nurse
            SET BedsMonitored = GREATEST(BedsMonitored-1, 0)
            WHERE nurse_id = :OLD.nurse_id;
        -- update new nurse 
        UPDATE Nurse
            SET BedsMonitored = BedsMonitored + 1
            WHERE nurse_id = :NEW.nurse_id;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010, 'Invalid or NULL Nurse ID.');
END;/