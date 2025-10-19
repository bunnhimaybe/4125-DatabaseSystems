/*
* Nhi Pham
* CSCI 4125 Fall 2025
* Phase 2 Schema
*/

DROP TABLE Timecard;
DROP TABLE Bed;
DROP TABLE Nurse;
DROP TABLE Patient;
DROP TABLE Physician;

CREATE TABLE Physician (
    physician_id CHAR(3),
    physician_name VARCHAR2(25),
    physician_specialty VARCHAR2(25), 
    CONSTRAINT PK_Physician PRIMARY KEY (physician_id)
);

CREATE TABLE Timecard (
    physician_id CHAR(3),
    c_date DATE,
    c_hours NUMBER,
    CONSTRAINT PK_Timecard PRIMARY KEY (physician_id, c_date),
    CONSTRAINT FK_Timecard 
        FOREIGN KEY (physician_id) REFERENCES Physician(physician_id)
);

CREATE TABLE Patient (
    patient_num CHAR(3),
    patient_name VARCHAR2(25),
    patient_age NUMBER,
    physician_id CHAR(3),
    CONSTRAINT PK_Patient PRIMARY KEY (patient_num),
    CONSTRAINT FK_Patient
        FOREIGN KEY (physician_id) REFERENCES Physician(physician_id)
);

CREATE TABLE Nurse (
    nurse_id CHAR(3),
    nurse_name VARCHAR2(25),
    nurse_salary NUMBER,
    nurse_supervisor_id CHAR(3),
    CONSTRAINT PK_Nurse PRIMARY KEY (nurse_id),
    CONSTRAINT FK_Nurse_Supervisor
        FOREIGN KEY (nurse_supervisor_id) REFERENCES Nurse(nurse_id)
);

CREATE TABLE Bed (
    bed_num NUMBER,
    bed_room_num NUMBER,
    bed_unit VARCHAR2(15), 
    patient_num NUMBER,
    nurse_id NUMBER,
    CONSTRAINT PK_Bed PRIMARY KEY (bed_num),
    CONSTRAINT FK_Bed_Patient 
        FOREIGN KEY (patient_num) REFERENCES Patient(patient_num),
    CONSTRAINT FK_Bed_Nurse
        FOREIGN KEY (nurse_id) REFERENCES Nurse(nurse_id)
);