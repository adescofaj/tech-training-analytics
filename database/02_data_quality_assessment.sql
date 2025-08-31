-- ===============================================
-- EXPLORING ISSUES ACCROSS THE TABLES
-- ===============================================

USE tech_training_analytics;

-- SECTION 1: INSTRUCTORS TABLE ISSUES
-- Check for name formatting issues
SELECT 
    'Instructor Name Issues' AS issue_category,
    'Case/Spacing Problems' AS issue_type,
    COUNT(*) AS affected_records,
    GROUP_CONCAT(instructor_name SEPARATOR '; ') AS examples
FROM instructors 
WHERE instructor_name != TRIM(instructor_name)  -- trailing/leading spaces
   OR instructor_name REGEXP '^[a-z]';  -- starts with lowercase
   
-- Check for data completeness
SELECT 
    'Instructor Completeness' AS issue_category,
    'Missing Data' AS issue_type,
    COUNT(*) AS affected_records
FROM instructors 
WHERE instructor_name IS NULL 
   OR specialization IS NULL 
   OR years_experience IS NULL 
   OR hourly_rate IS NULL;


-- SECTION 2: STUDENTS TABLE ISSUES  
-- Email format validation
SELECT 
    'Student Email Issues' AS issue_category,
    'Invalid Email Format' AS issue_type,
    COUNT(*) AS affected_records,
    GROUP_CONCAT(CONCAT(student_name, ': ', email) SEPARATOR '; ') AS examples
FROM students 
WHERE email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';

-- Subscription tier case inconsistencies
SELECT 
    'Student Subscription Issues' AS issue_category,
    'Case Inconsistencies' AS issue_type,
    subscription_tier AS problematic_value,
    COUNT(*) AS count
FROM students 
WHERE subscription_tier REGEXP '^[a-z]'  -- starts with lowercase
   OR subscription_tier = UPPER(subscription_tier)  -- all uppercase
GROUP BY subscription_tier;

-- Missing company information
SELECT 
    'Student Company Issues' AS issue_category,
    'Missing Company Data' AS issue_type,
    COUNT(*) AS affected_records,
    GROUP_CONCAT(student_name SEPARATOR '; ') AS examples
FROM students 
WHERE company = '' OR company IS NULL;


-- SECTION 3: COURSES TABLE ISSUES
-- Duration format inconsistencies
SELECT 
    'Course Duration Issues' AS issue_category,
    'Format Inconsistencies' AS issue_type,
    duration_hours AS problematic_value,
    COUNT(*) AS count
FROM courses 
WHERE duration_hours NOT LIKE '%hours'
   AND duration_hours NOT LIKE '%hour'
GROUP BY duration_hours;

-- Difficulty level case issues
SELECT 
    'Course Difficulty Issues' AS issue_category,
    'Case Inconsistencies' AS issue_type,
    difficulty_level AS problematic_value,
    COUNT(*) AS count
FROM courses 
WHERE difficulty_level REGEXP '^[a-z]'  -- starts with lowercase
GROUP BY difficulty_level;

-- Category case issues
SELECT 
    'Course Category Issues' AS issue_category,
    'Case Inconsistencies' AS issue_type,
    category AS problematic_value,
    COUNT(*) AS count
FROM courses 
WHERE category REGEXP '^[a-z]'  -- starts with lowercase
GROUP BY category;


-- SECTION 4: ENROLLMENTS TABLE ISSUES
SELECT 
    'Enrollment Score Issues' AS issue_category,
    'Mixed Score Formats' AS issue_type,
    TRIM(final_score) AS problematic_value,
    COUNT(*) AS count
FROM enrollments 
WHERE final_score = 'null'
   OR final_score = 'N/A'
   OR final_score = '0'
   OR final_score IS NULL
   OR TRIM(final_score) = ''        -- catches '' and '    '
   OR final_score REGEXP '[^0-9.]'  -- catches anything with % or letters
GROUP BY TRIM(final_score);

SELECT 
    'Enrollment Status Issues' AS issue_category,
    'Status Format Problems' AS issue_type,
    completion_status AS problematic_value,
    COUNT(*) AS count
FROM enrollments 
WHERE completion_status IN ('in_progress', 'paid')
   OR completion_status LIKE '%\_%'
GROUP BY completion_status;


-- SECTION 5: LEARNING_SESSIONS TABLE ISSUES

-- Session duration format problems
SELECT 
    'Session Duration Issues' AS issue_category,
    'Format Inconsistencies' AS issue_type,
    session_duration AS problematic_value,
    COUNT(*) AS count
FROM learning_sessions 
WHERE session_duration NOT LIKE '%minutes'
   AND session_duration NOT LIKE '%minute'
GROUP BY session_duration
ORDER BY count DESC;

-- Device type case inconsistencies
SELECT 
    'Device Type Issues' AS issue_category,
    'Case Inconsistencies' AS issue_type,
    device_type AS problematic_value,
    COUNT(*) AS count
FROM learning_sessions 
WHERE device_type REGEXP '^[a-z]'  -- starts with lowercase
GROUP BY device_type;

select * from learning_sessions;


-- ===============================================
-- SIMPLIFIED DATA QUALITY SUMMARY
-- ===============================================

-- Instructor issues
SELECT 
    'Instructors' AS table_name,
    COUNT(*) AS total_records,
    SUM(CASE WHEN instructor_name != TRIM(instructor_name) OR instructor_name REGEXP '^[a-z]' THEN 1 ELSE 0 END) AS messy_records
FROM instructors;

-- Student issues
SELECT 
    'Students' AS table_name,
    COUNT(*) AS total_records,
    SUM(CASE WHEN 
        email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' 
        OR subscription_tier REGEXP '^[a-z]'
        OR subscription_tier = UPPER(subscription_tier)
        OR company = ''
        THEN 1 ELSE 0 END) AS messy_records
FROM students;

-- Course issues
SELECT 
    'Courses' AS table_name,
    COUNT(*) AS total_records,
    SUM(CASE WHEN 
        duration_hours NOT LIKE '%hours' AND duration_hours NOT LIKE '%hour'
        OR difficulty_level REGEXP '^[a-z]'
        OR category REGEXP '^[a-z]'
        THEN 1 ELSE 0 END) AS messy_records
FROM courses;

-- Enrollment issues
SELECT 
    'Enrollments' AS table_name,
    COUNT(*) AS total_records,
    SUM(CASE WHEN 
        final_score IN ('null', 'N/A', '0') 
        OR final_score REGEXP '[^0-9.]'  -- catches % signs
        OR completion_status = 'in_progress'
        THEN 1 ELSE 0 END) AS messy_records
FROM enrollments;

-- Learning session issues
SELECT 
    'Learning Sessions' AS table_name,
    COUNT(*) AS total_records,
    SUM(CASE WHEN 
        session_duration NOT LIKE '%minutes' AND session_duration NOT LIKE '%minute'
        OR device_type REGEXP '^[a-z]'
        THEN 1 ELSE 0 END) AS messy_records
FROM learning_sessions;