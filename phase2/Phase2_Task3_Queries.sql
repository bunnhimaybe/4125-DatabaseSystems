/* 
 * Nhi Pham 
 * CSCI 4125 Database Systems
 * Phase 2 - (Task 3) Retrieval Queries
 * Fall 2025
 * 
 * Takes a command-line argument to convert data 
 * from a text file into SQL statements. 
*/

-- =======================================
-- Queries 1 - 8 are worth 1 point each.
-- =======================================

-- 1. Find all the "surgery" (for the specialty) physicians.
    -- sort the query output by names (any direction).
SELECT * 
FROM physician
WHERE LOWER(physician_specialty) = 'surgery'
ORDER BY physician_name;

-- 2. Find all physicians with medicine in their specialty name 
    -- (hint: remember the LIKE operator and case sensitivity).
SELECT *
FROM physician
WHERE physician_specialty LIKE '%Medicine%';

-- 3. Find all nurses who do not have a supervisor.
SELECT *
FROM nurse
WHERE nurse_supervisor_id IS NULL;

-- 4. Find the names of all nurses with a salary between $70,000 and $80,000 (inclusive).
SELECT * 
FROM nurse
WHERE nurse_salary BETWEEN 70000 AND 80000;

-- 5. Find the minimum and maximum salaries amongst all nurses. 
    -- Use only one query that returns a single row (ex. 50000, 100000).
SELECT MAX(nurse_salary), MIN(nurse_salary)
FROM nurse;

-- 6. Find the average salary for all nurses.
SELECT AVG(nurse_salary)
FROM nurse;

-- 7. Find the name of the nurse that has the highest salary. 
    -- Do not hardcode any salaries or other values.
    -- You must use SQL without assuming you know the current database snapshot.
SELECT nurse_name
FROM nurse
WHERE nurse_salary = (
                        SELECT MAX(nurse_salary)
                        FROM nurse
);

-- 8. Find the nurses with a salary less than the average overall salary for all nurses + 20% 
    -- (i.e., less than 1.2 * average salary). Do not hardcode any salaries or other values 
    -- you must use SQL without assuming you know the current database snapshot.
SELECT nurse_name, nurse_salary
FROM nurse
WHERE nurse_salary < (
                        SELECT AVG(nurse_salary) * 1.2
                        FROM nurse
);

-- =======================================
-- Queries 9 - 19 are worth 2 points each.
-- =======================================

-- 9. Retrieve the names of all nurses who monitor at least one bed. 
    -- Make sure to remove duplicates.
SELECT DISTINCT n.nurse_name 
FROM nurse n INNER JOIN bed b
ON n.nurse_id = b.nurse_id;

-- 10. For each physician ID, list the total number of hours worked.
SELECT p.physician_id, SUM(c.c_hours)
FROM physician p LEFT OUTER JOIN timecard c
ON p.physician_id = c.physician_id
GROUP BY p.physician_id;

-- 11. Retrieve the names of all nurses who do not monitor any beds.
SELECT DISTINCT *
FROM nurse n LEFT OUTER JOIN bed b
ON n.nurse_id = b.nurse_id
WHERE b.bed_num IS NULL;

-- 12. Find the names of all nurses who are directly supervised by Chris Summa. 
    -- Note: You must use the string "Chris Summa" and not hardcode the nurse ID.
SELECT nurse_name
FROM nurse
WHERE nurse_supervisor_id = (
                                SELECT nurse_id
                                FROM nurse
                                WHERE nurse_name = 'Chris Summa'
);

-- 13. Retrieve the names of all physicians who specialize in dermatology 
    -- and have worked more than 22 hours.
SELECT p.physician_name, p.physician_id, SUM(c.c_hours)
FROM physician p INNER JOIN timecard c
ON p.physician_id = c.physician_id
WHERE p.physician_specialty = 'Dermatology'
GROUP BY p.physician_name, p.physician_id
HAVING SUM(c.c_hours) > 22
ORDER BY p.physician_id;

-- 14. For each physician specialty, list the specialty, 
    -- the number of physicians that have that specialty, 
    -- and the total number of hours worked by those physicians.
SELECT p.physician_specialty, COUNT(p.physician_name) AS Count, SUM(c.c_hours) AS Total_Hours
FROM physician p INNER JOIN timecard c
ON p.physician_id = c.physician_id
GROUP BY p.physician_specialty
ORDER BY p.physician_specialty;

-- 15. Retrieve the names of all nurses 
    -- whose supervisor's supervisor has N01 for their ID.
/* PSEUDOCODE
    for (n1 : nurse) {
        n2 = n1.nurse_supervisor_id;
        if (n2 exists):
            n3 = n2.nurse_supervisor_id;
            if (n3 exists and n3 == 'N01')
                return n1.nurse_name;
    }
*/
SELECT n1.nurse_name
FROM nurse n1
INNER JOIN nurse n2 ON n1.nurse_supervisor_id = n2.nurse_id
INNER JOIN nurse n3 ON n2.nurse_supervisor_id = n3.nurse_id
WHERE n3.nurse_id = 'N01';
/*
SELECT n1.nurse_name
FROM nurse n1
WHERE n1.nurse_supervisor_id IN (
            SELECT n2.nurse_id
            FROM nurse n2
            WHERE n2.nurse_supervisor_id = (
                        SELECT n3.nurse_id
                        FROM nurse n3
                        WHERE n3.nurse_id = 'N01'
            )
);
*/

-- 16. For each physician specialty, find the total number of patients 
    -- whose physician has that specialty.
SELECT phys.physician_specialty, COUNT(ptnt.patient_num) AS patients
FROM physician phys INNER JOIN patient ptnt
ON phys.physician_id = ptnt.physician_id
GROUP BY phys.physician_specialty;

-- 17. Find the patient who is assigned to a bed 
    -- that is monitored by the nurse with the lowest salary.
SELECT p.patient_name, p.patient_num, n.nurse_salary
FROM patient p INNER JOIN bed b ON p.patient_num = b.patient_num
INNER JOIN nurse n ON b.nurse_id = n.nurse_id
WHERE n.nurse_salary = (
                        SELECT MIN(nurse_salary)
                        FROM nurse
);

-- 18. Retrieve the average age of patients assigned to a bed.
SELECT ROUND(AVG(p.patient_age)) AS avg_age
FROM patient P INNER JOIN bed b
ON p.patient_num = b.patient_num;

-- 19. This problem requires (no points if you don't) you to use 
    -- the regular expression function that we discussed in class. 
    -- Find all beds that have a room number that end in an odd number 
    -- (e.g., return 101, but not 102).
SELECT bed_num, bed_room_num
FROM bed
WHERE REGEXP_LIKE(bed_room_num, '.*(1|3|5|7|9)$' );