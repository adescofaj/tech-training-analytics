-- ===============================================
-- DATA CLEANING
-- ===============================================

USE tech_training_analytics;

-- CLEANING INSTRUCTORS TABLE
-- Fix instructor name case issues
SET SQL_SAFE_UPDATES = 0;

UPDATE instructors 
SET instructor_name = CONCAT(UPPER(LEFT(instructor_name, 1)), LOWER(SUBSTRING(instructor_name, 2)))
WHERE instructor_name REGEXP '^[a-z]';


-- CLEANING STUDENTS TABLE
-- Fix subscription tier case issues
UPDATE students 
SET subscription_tier = 'Individual' 
WHERE subscription_tier = 'individual';

UPDATE students 
SET subscription_tier = 'Corporate' 
WHERE subscription_tier IN ('CORPORATE', 'corporate');

UPDATE students 
SET subscription_tier = 'Enterprise' 
WHERE subscription_tier = 'ENTERPRISE';

-- Fix incomplete emails (add .com where missing)
UPDATE students 
SET email = CONCAT(email, '.com')
WHERE email NOT REGEXP '\\.[a-zA-Z]{2,}$';

UPDATE students 
SET company = 'Not Specified'
WHERE company = '' OR company IS NULL;


-- CLEANING COURSES TABLE
-- Standardize duration format
UPDATE courses 
SET duration_hours = CONCAT(duration_hours, ' hours')
WHERE duration_hours REGEXP '^[0-9]+$';

UPDATE courses 
SET duration_hours = REPLACE(duration_hours, ' hrs', ' hours')
WHERE duration_hours LIKE '% hrs';

-- Fix case issues
UPDATE courses 
SET difficulty_level = 'Beginner'
WHERE difficulty_level = 'beginner';

UPDATE courses 
SET category = 'Security'
WHERE category = 'security';


-- CLEANING ENROLLMENTS TABLE
-- Fix final_score format issues
UPDATE enrollments 
SET final_score = NULL 
WHERE final_score IN ('null', 'N/A', '0');

-- Convert percentage scores to decimal format
UPDATE enrollments 
SET final_score = CAST(REPLACE(final_score, '%', '') AS DECIMAL(5,2))
WHERE final_score LIKE '%';

-- Fix completion_status underscore format
UPDATE enrollments 
SET completion_status = 'In Progress'
WHERE completion_status = 'in_progress';


-- CLEANING LEARNING SESSIONS TABLE
-- Standardize duration to minutes format
UPDATE learning_sessions 
SET session_duration = CONCAT(session_duration, ' minutes')
WHERE session_duration REGEXP '^[0-9]+$';

-- Convert 'mins' to 'minutes'
UPDATE learning_sessions 
SET session_duration = REPLACE(session_duration, ' mins', ' minutes')
WHERE session_duration LIKE '% mins';

-- Convert hours to minutes
UPDATE learning_sessions 
SET session_duration = CONCAT(CAST(REPLACE(session_duration, ' hours', '') AS DECIMAL(3,1)) * 60, ' minutes')
WHERE session_duration LIKE '% hours';

UPDATE learning_sessions 
SET session_duration = CONCAT(CAST(REPLACE(session_duration, ' hour', '') AS DECIMAL(3,1)) * 60, ' minutes')
WHERE session_duration LIKE '% hour';

-- Fix null and empty duration values
UPDATE learning_sessions 
SET session_duration = NULL 
WHERE session_duration IN ('null', '');

-- Fix device type case issues
UPDATE learning_sessions 
SET device_type = 'Mobile'
WHERE device_type = 'mobile';

UPDATE learning_sessions 
SET device_type = 'Tablet'
WHERE device_type = 'tablet';

-- Fix duration values that are just numbers (no units)
UPDATE learning_sessions 
SET session_duration = CONCAT(session_duration, ' minutes')
WHERE session_duration REGEXP '^[0-9]+$' 
  AND session_duration NOT LIKE '% minutes';
  
SELECT 
    'Learning Sessions' AS table_name,
    COUNT(*) AS total_records,
    SUM(CASE WHEN 
        session_duration NOT LIKE '%minutes' AND session_duration NOT LIKE '%minute'
        OR device_type REGEXP '^[a-z]'
        THEN 1 ELSE 0 END) AS messy_records
FROM learning_sessions;



-- ===============================================
-- COMPLETE POST-CLEANING DATA QUALITY ASSESSMENT
-- ===============================================

SELECT 'Instructors' AS table_name, COUNT(*) AS total_records,
    SUM(CASE WHEN instructor_name REGEXP '^[a-z]' THEN 1 ELSE 0 END) AS messy_records
FROM instructors;

SELECT 'Students' AS table_name, COUNT(*) AS total_records,
    SUM(CASE WHEN 
        email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' 
        OR subscription_tier REGEXP '^[a-z]'
        OR subscription_tier = UPPER(subscription_tier)
        OR company = ''
        THEN 1 ELSE 0 END) AS messy_records
FROM students;

SELECT 'Courses' AS table_name, COUNT(*) AS total_records,
    SUM(CASE WHEN 
        duration_hours NOT LIKE '%hours' AND duration_hours NOT LIKE '%hour'
        OR difficulty_level REGEXP '^[a-z]'
        OR category REGEXP '^[a-z]'
        THEN 1 ELSE 0 END) AS messy_records
FROM courses;

SELECT 'Enrollments' AS table_name, COUNT(*) AS total_records,
    SUM(CASE WHEN 
        final_score IN ('null', 'N/A', '0') 
        OR final_score REGEXP '[^0-9.]'
        OR completion_status = 'in_progress'
        THEN 1 ELSE 0 END) AS messy_records
FROM enrollments;