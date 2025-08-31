USE tech_training_platform;

-- ===============================================
-- PHASE 4: SIMPLE BUSINESS ANALYTICS QUERIES
-- Tech Training Platform - Easy-to-Understand Insights
-- ===============================================

-- QUERY 1: BASIC PLATFORM OVERVIEW
-- Simple count of everything in the database
SELECT 
    COUNT(*) AS total_students FROM students;

SELECT 
    COUNT(*) AS total_instructors FROM instructors;

SELECT 
    COUNT(*) AS total_courses FROM courses;

SELECT 
    COUNT(*) AS total_enrollments FROM enrollments;

SELECT 
    COUNT(*) AS learning_sessions FROM learning_sessions;


-- QUERY 2: WHICH INSTRUCTORS ARE MOST POPULAR?
-- Shows which instructors have the most students
SELECT 
    i.instructor_name,
    i.specialization,
    COUNT(e.enrollment_id) AS total_enrollments
FROM instructors i
JOIN courses c ON i.instructor_id = c.instructor_id
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY i.instructor_id, i.instructor_name, i.specialization
ORDER BY total_enrollments DESC;


-- QUERY 3: WHAT'S OUR COMPLETION RATE?
-- Simple percentage of completed vs total enrollments
SELECT 
    COUNT(*) AS total_enrollments,
    COUNT(CASE WHEN completion_status = 'Completed' THEN 1 END) AS completed_courses,
    COUNT(CASE WHEN completion_status = 'Dropped' THEN 1 END) AS dropped_courses,
    COUNT(CASE WHEN completion_status = 'In Progress' THEN 1 END) AS in_progress_courses
FROM enrollments;


-- QUERY 4: WHICH COURSES MAKE THE MOST MONEY?
-- Revenue by course (simple multiplication)
SELECT 
    c.course_name,
    c.course_price,
    COUNT(e.enrollment_id) AS total_enrollments,
    COUNT(CASE WHEN e.payment_status = 'Paid' THEN 1 END) AS paid_enrollments,
    (c.course_price * COUNT(CASE WHEN e.payment_status = 'Paid' THEN 1 END)) AS total_revenue
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name, c.course_price
ORDER BY total_revenue DESC;


-- QUERY 5: HOW MANY STUDENTS BY SUBSCRIPTION TYPE?
-- Simple count by subscription tier
SELECT 
    subscription_tier,
    COUNT(*) AS number_of_students
FROM students
GROUP BY subscription_tier
ORDER BY number_of_students DESC;


-- QUERY 6: AVERAGE STUDENT SCORES
-- What are typical final scores?
SELECT 
    AVG(CAST(final_score AS DECIMAL(5,2))) AS average_final_score,
    MIN(CAST(final_score AS DECIMAL(5,2))) AS lowest_score,
    MAX(CAST(final_score AS DECIMAL(5,2))) AS highest_score
FROM enrollments 
WHERE final_score IS NOT NULL;


-- QUERY 7: WHICH DEVICE DO STUDENTS PREFER?
-- Simple count of learning sessions by device
SELECT 
    device_type,
    COUNT(*) AS number_of_sessions
FROM learning_sessions
GROUP BY device_type
ORDER BY number_of_sessions DESC;


-- QUERY 8: BUSIEST LEARNING DAYS (FIXED)
-- Which days do students learn most?
SELECT 
    CASE DAYOFWEEK(session_date)
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_of_week,
    COUNT(*) AS total_sessions
FROM learning_sessions
GROUP BY 
    CASE DAYOFWEEK(session_date)
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END
ORDER BY total_sessions DESC;


-- QUERY 9: COURSE DIFFICULTY BREAKDOWN
-- How many courses by difficulty level?
SELECT 
    difficulty_level,
    COUNT(*) AS number_of_courses,
    AVG(course_price) AS average_price
FROM courses
GROUP BY difficulty_level
ORDER BY average_price DESC;


-- QUERY 10: TOP COMPANIES TRAINING THEIR EMPLOYEES
-- Which companies send the most students?
SELECT 
    company,
    COUNT(*) AS number_of_employees
FROM students
WHERE company NOT IN ('Not Specified', 'Freelancer')
GROUP BY company
ORDER BY number_of_employees DESC;


-- QUERY 11: MONTHLY ENROLLMENT TRENDS
-- Are we growing each month?
SELECT 
    DATE_FORMAT(enrollment_date, '%Y-%m') AS month,
    COUNT(*) AS new_enrollments
FROM enrollments
GROUP BY DATE_FORMAT(enrollment_date, '%Y-%m')
ORDER BY month;


-- QUERY 12: SESSION RATINGS
-- How satisfied are students? (1-5 rating scale)
SELECT 
    session_rating,
    COUNT(*) AS number_of_sessions
FROM learning_sessions
WHERE session_rating IS NOT NULL
GROUP BY session_rating
ORDER BY session_rating DESC;


-- QUERY 13: MOST EXPENSIVE VS CHEAPEST COURSES
-- Price comparison
SELECT 'Most Expensive' AS price_category, course_name, course_price
FROM courses
WHERE course_price = (SELECT MAX(course_price) FROM courses)

UNION ALL

SELECT 'Cheapest' AS price_category, course_name, course_price
FROM courses
WHERE course_price = (SELECT MIN(course_price) FROM courses);


-- QUERY 14: INSTRUCTOR HOURLY RATES
-- What do we pay our instructors?
SELECT 
    instructor_name,
    specialization,
    hourly_rate
FROM instructors
ORDER BY hourly_rate DESC;


-- QUERY 15: SIMPLE REVENUE CALCULATION
-- Total money earned
SELECT 
    SUM(c.course_price) AS total_possible_revenue,
    SUM(CASE WHEN e.payment_status = 'Paid' THEN c.course_price ELSE 0 END) AS actual_revenue_earned,
    COUNT(*) AS total_enrollments,
    COUNT(CASE WHEN e.payment_status = 'Paid' THEN 1 END) AS paid_enrollments
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id;











-- EXECUTIVE SUMMARY QUERY

--QUERY 16
-- Key business metrics for leadership dashboard
SELECT 
    'Executive Dashboard' AS report_type,
    COUNT(DISTINCT s.student_id) AS total_active_students,
    COUNT(DISTINCT i.instructor_id) AS total_instructors,
    COUNT(DISTINCT c.course_id) AS total_courses,
    COUNT(DISTINCT e.enrollment_id) AS total_enrollments,
    ROUND(SUM(c.course_price * CASE WHEN e.payment_status = 'Paid' THEN 1 ELSE 0 END), 2) AS total_revenue,
    ROUND(AVG(CASE 
        WHEN e.completion_status = 'Completed' 
        THEN CAST(e.final_score AS DECIMAL(5,2)) 
        ELSE NULL 
    END), 2) AS average_completion_score,
    ROUND(
        COUNT(CASE WHEN e.completion_status = 'Completed' THEN 1 END) * 100.0 / 
        COUNT(CASE WHEN e.completion_status IN ('Completed', 'Dropped') THEN 1 END), 2
    ) AS completion_rate_percent
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
LEFT JOIN instructors i ON c.instructor_id = i.instructor_id;


-- QUERY 17
-- Analyzes how device preferences impact learning outcomes
SELECT 
    ls.device_type,
    COUNT(DISTINCT ls.student_id) AS unique_students,
    COUNT(ls.session_id) AS total_sessions,
    ROUND(AVG(CAST(REPLACE(ls.session_duration, ' minutes', '') AS DECIMAL(5,2))), 2) AS avg_session_minutes,
    ROUND(AVG(ls.lessons_completed), 2) AS avg_lessons_per_session,
    ROUND(AVG(ls.quiz_score), 2) AS avg_quiz_score,
    ROUND(AVG(ls.session_rating), 2) AS avg_session_rating,
    COUNT(CASE WHEN e.completion_status = 'Completed' THEN 1 END) AS completed_courses,
    ROUND(
        COUNT(CASE WHEN e.completion_status = 'Completed' THEN 1 END) * 100.0 / 
        NULLIF(COUNT(CASE WHEN e.completion_status IN ('Completed', 'Dropped') THEN 1 END), 0), 2
    ) AS completion_rate_percent
FROM learning_sessions ls
JOIN enrollments e ON ls.student_id = e.student_id AND ls.course_id = e.course_id
WHERE ls.session_duration IS NOT NULL
GROUP BY ls.device_type
ORDER BY avg_session_rating DESC, completion_rate_percent DESC;


-- QUERY 18
-- Tracks business growth over time
SELECT 
    DATE_FORMAT(e.enrollment_date, '%Y-%m') AS enrollment_month,
    COUNT(DISTINCT e.enrollment_id) AS new_enrollments,
    COUNT(CASE WHEN e.payment_status = 'Paid' THEN 1 END) AS paid_enrollments,
    ROUND(SUM(c.course_price * CASE WHEN e.payment_status = 'Paid' THEN 1 ELSE 0 END), 2) AS monthly_revenue,
    ROUND(AVG(c.course_price), 2) AS avg_course_price,
    COUNT(CASE WHEN e.completion_status = 'Completed' THEN 1 END) AS completed_courses,
    ROUND(
        COUNT(CASE WHEN e.completion_status = 'Completed' THEN 1 END) * 100.0 / 
        NULLIF(COUNT(CASE WHEN e.completion_status IN ('Completed', 'Dropped') THEN 1 END), 0), 2
    ) AS monthly_completion_rate
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY DATE_FORMAT(e.enrollment_date, '%Y-%m')
ORDER BY enrollment_month;