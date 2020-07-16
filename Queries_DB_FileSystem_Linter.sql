SELECT * from FILE_SYSTEM;
SELECT * from SUBJECTS;
SELECT * from OBJECTS;
SELECT * from AACCESS_RIGHTS;
SELECT * from FFOLDERS;
SELECT * from FFILES;

// UNION
SELECT OBJECTS.o_id, OBJECTS.o_name, OBJECTS.type_name
FROM OBJECTS WHERE OBJECTS.type_name ='Administrator'
UNION
SELECT OBJECTS.o_id, OBJECTS.o_name, OBJECTS.type_name
FROM OBJECTS WHERE OBJECTS.type_name = 'Moderator'
UNION
SELECT OBJECTS.o_id, OBJECTS.o_name, OBJECTS.type_name
FROM OBJECTS WHERE OBJECTS.type_name = 'User';

// INTERSECT
SELECT OBJECTS.o_id, OBJECTS.o_name
FROM OBJECTS WHERE OBJECTS.o_name LIKE '%asha%'
INTERSECT
SELECT OBJECTS.o_id, OBJECTS.o_name
FROM OBJECTS WHERE OBJECTS.o_name LIKE '%Folder%';

// MINUS = EXCEPT
SELECT OBJECTS.o_id, OBJECTS.o_name
FROM OBJECTS WHERE OBJECTS.o_name LIKE '%asha%'
EXCEPT
SELECT OBJECTS.o_id, OBJECTS.o_name
FROM OBJECTS WHERE OBJECTS.o_name LIKE '%Folder%';

// CROSS JOIN
SELECT OBJECTS.o_id, OBJECTS.o_name, SUBJECTS.s_id, SUBJECTS.s_name
FROM OBJECTS 
CROSS JOIN SUBJECTS;

// WHERE
SELECT FILE_SYSTEM.fs_name FROM FILE_SYSTEM
WHERE FILE_SYSTEM.fs_name = 'MyOS';

// SELECT
SELECT FFILES.ffile_name FROM FFILES;

// JOIN
SELECT FFILES.ffile_id, FFILES.ffile_name, OBJECTS.type_name FROM FFILES 
JOIN OBJECTS ON OBJECTS.o_id = FFILES.ffile_id;

// LEFT JOIN
SELECT OBJECTS.o_id, OBJECTS.o_name, FFILES.full_path FROM OBJECTS 
LEFT JOIN FFILES ON FFILES.ffile_id = OBJECTS.o_id;

// RIGHT JOIN
SELECT OBJECTS.o_id, OBJECTS.o_name, FFILES.full_path FROM OBJECTS 
RIGHT JOIN FFILES ON FFILES.ffile_id = OBJECTS.o_id;

// ORDER BY
SELECT * from SUBJECTS ORDER BY SUBJECTS.s_name;

// COUNT
SELECT COUNT(s_id) AS count_of_users_who_can_write FROM AACCESS_RIGHTS
WHERE AACCESS_RIGHTS.ar_name = 'write';

// MIN
SELECT MIN(FFOLDERS.folder_id) FROM FFOLDERS;

// MAX
SELECT MAX(FFOLDERS.folder_id) FROM FFOLDERS;

// SUM
SELECT SUM(FFOLDERS.folder_id) FROM FFOLDERS;

// AVG
SELECT AVG(FFOLDERS.folder_id) FROM FFOLDERS;

// Nested Subquery
SELECT SUBJECTS.s_id, SUBJECTS.s_name, SUBJECTS.type_name FROM SUBJECTS
WHERE SUBJECTS.s_id IN (SELECT AACCESS_RIGHTS.s_id FROM AACCESS_RIGHTS 
WHERE AACCESS_RIGHTS.ar_name = 'read');

//Complex query
SELECT SUBJECTS.s_id, SUBJECTS.s_name, AACCESS_RIGHTS.ar_name, OBJECTS.o_id, OBJECTS.o_name
FROM SUBJECTS
JOIN AACCESS_RIGHTS ON AACCESS_RIGHTS.s_id = SUBJECTS.s_id and AACCESS_RIGHTS.ar_name = 'write'
JOIN OBJECTS ON OBJECTS.o_id = AACCESS_RIGHTS.o_id
WHERE SUBJECTS.s_id > 6;