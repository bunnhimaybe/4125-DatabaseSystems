SELECT 'Bed: ' || COUNT(*) AS Cnt FROM Bed
UNION
SELECT 'Nurse: ' || COUNT(*) AS Cnt FROM Nurse
UNION
SELECT 'Patient: ' || COUNT(*) AS Cnt FROM Patient
UNION
SELECT 'Physician: ' || COUNT(*) AS Cnt FROM Physician
UNION
SELECT 'Timecard: ' || COUNT(*) AS Cnt FROM Timecard;