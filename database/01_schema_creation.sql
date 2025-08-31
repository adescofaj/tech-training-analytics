-- ===============================================
-- TECH TRAINING PLATFORM DATABASE SCHEMA
-- ===============================================

DROP DATABASE IF exists tech_training_analytics;
CREATE DATABASE tech_training_analytics;
USE tech_training_analytics;


-- TABLE 1: INSTRUCTORS
DROP TABLE IF EXISTS instructors;
CREATE TABLE instructors (
    instructor_id INTEGER PRIMARY KEY,
    instructor_name VARCHAR(100),
    specialization VARCHAR(50),
    years_experience INTEGER,
    hire_date DATE,
    hourly_rate DECIMAL(6,2)
)CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

INSERT INTO instructors (instructor_id, instructor_name, specialization, years_experience, hire_date, hourly_rate)
VALUES
    (1, 'Sarah Chen', 'Python Development', 5, '2022-03-15', 85.00),
    (2, 'mike rodriguez', 'JavaScript', 7, '2021-08-22', 90.00),
    (3, 'Emily Johnson', 'Data Science', 4, '2023-01-10', 95.00),
    (4, 'David Kim', 'Cloud Computing', 6, '2022-11-05', 88.00),
    (5, 'Lisa Thompson ', 'Cybersecurity', 8, '2020-12-01', 92.00),
    (7, 'Maria Santos', 'React/Frontend', 6, '2021-11-12', 87.00),
    (8, 'Robert Chang', 'Machine Learning', 9, '2019-07-08', 105.00);


-- TABLE 2: STUDENTS  

DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    student_name VARCHAR(100),
    email VARCHAR(100),
    company VARCHAR(100),
    job_title VARCHAR(80),
    registration_date DATE,
    subscription_tier VARCHAR(20)
)CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

INSERT INTO students (student_id, student_name, email, company, job_title, registration_date, subscription_tier) VALUES 
(101, 'John Smith', 'john.smith@gmail.com', 'TechCorp Inc', 'Junior Developer', '2023-01-15', 'Corporate'),
(102, 'Maria Garcia', 'maria.garcia@yahoo.com', 'InnoStartup', 'Data Analyst', '2023-02-20', 'individual'),
(103, 'Ahmed Hassan', 'ahmed@gmail.com', 'ConsultPro', 'Senior Developer', '2023-01-28', 'Corporate'),
(104, 'Anna Petrov', 'anna.petrov@yahoo', 'Freelancer', 'UX Designer', '2023-03-10', 'Individual'),
(105, 'James Wilson', 'james.wilson@gmail.com', 'BigTech Solutions', 'DevOps Engineer', '2023-02-05', 'Enterprise'),
(106, 'Priya Sharma', 'priya.sharma@yahoo.com', 'InnoStartup', 'Product Manager', '2023-03-22', 'Corporate'),
(107, 'Carlos Mendez', 'carlos@gmail.com', 'TechCorp Inc', 'Security Analyst', '2023-01-12', 'CORPORATE'),
(108, 'Jennifer Lee', 'jen.lee@yahoo.com', '', 'Full Stack Developer', '2023-04-01', 'Enterprise'),
(109, 'Michael Brown', 'mike.brown@gmail.com', 'Acme Software', 'Backend Developer', '2023-04-15', 'Corporate'),
(110, 'Sarah Johnson', 'sarah.j@yahoo.com', 'TechStart LLC', 'Frontend Developer', '2023-03-08', 'Individual'),
(111, 'David Kim', 'david.kim@gmail.com', 'GlobalTech Corp', 'Software Architect', '2023-01-20', 'Enterprise'),
(112, 'Lisa Chen', 'lisa.chen@gmail.com', 'WebDev Solutions', 'Web Developer', '2023-02-12', 'Corporate'),
(113, 'Robert Taylor', 'rob.taylor@yahoo.com', 'DataComp Inc', 'Database Administrator', '2023-03-25', 'corporate'),
(114, 'Emma Davis', 'emma@gmail', 'Freelancer', 'Graphic Designer', '2023-04-08', 'Individual'),
(115, 'Chris Anderson', 'c.anderson@yahoo.com', 'BigCorp International', 'Project Manager', '2023-01-30', 'Enterprise'),
(116, 'Nina Rodriguez', 'nina.rodriguez@gmail.com', 'StartupTech', 'QA Engineer', '2023-02-18', 'Corporate'),
(117, 'Tom White', 'tom.white@yahoo', 'Tech Consultancy', 'Systems Analyst', '2023-03-12', 'Individual'),
(118, 'Rachel Green', 'rachel.green@gmail.com', 'DevHouse Studios', 'Mobile Developer', '2023-04-20', 'Corporate'),
(119, 'Kevin Miller', 'kevin@yahoo.com', 'TechSolutions Pro', 'Cloud Engineer', '2023-01-25', 'ENTERPRISE'),
(120, 'Amanda Clark', 'amanda.clark@gmail.com', '', 'Product Designer', '2023-02-28', 'Individual'),
(121, 'Jason Lee', 'j.lee@yahoo.com', 'CyberSec Corp', 'Security Engineer', '2023-03-15', 'Enterprise'),
(122, 'Sofia Martinez', 'sofia.martinez@gmail.com', 'WebAgency Plus', 'UI Developer', '2023-04-02', 'Corporate'),
(123, 'Daniel Wilson', 'dan.wilson@gmail.com', 'CloudTech Services', 'DevOps Specialist', '2023-01-18', 'corporate'),
(124, 'Megan Thompson', 'megan@yahoo.com', 'Freelancer', 'Full Stack Developer', '2023-02-22', 'Individual'),
(125, 'Alex Johnson', 'alex.johnson@gmail.com', 'Enterprise Solutions', 'Solution Architect', '2023-03-30', 'Enterprise');


-- TABLE 3: COURSES

DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY,
    course_name VARCHAR(150),
    instructor_id INTEGER,
    category VARCHAR(50),
    difficulty_level VARCHAR(20),
    course_price DECIMAL(8,2),
    duration_hours VARCHAR(10),  -- Intentionally VARCHAR for messiness
    max_students INTEGER
)CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

INSERT INTO courses (course_id, course_name, instructor_id, category, difficulty_level, course_price, duration_hours, max_students)
VALUES
    (1, 'Python for Beginners', 1, 'Programming', 'Beginner', 299.99, '20 hours', 50),
    (2, 'Advanced Python Development', 1, 'Programming', 'Advanced', 499.99, '40', 30),
    (3, 'JavaScript Fundamentals', 2, 'Web Development', 'beginner', 249.99, '25 hrs', 60),
    (4, 'React.js Mastery', 7, 'Web Development', 'Intermediate', 399.99, '35 hours', 40),
    (5, 'Data Science with Python', 3, 'Data Science', 'Intermediate', 549.99, '50', 25),
    (6, 'Machine Learning Fundamentals', 8, 'Data Science', 'Advanced', 699.99, '60 hours', 20),
    (7, 'AWS Cloud Essentials', 4, 'Cloud Computing', 'Beginner', 449.99, '30 hours', 45),
    (8, 'Cybersecurity Basics', 5, 'Security', 'Beginner', 349.99, '25 hours', 55),
    (9, 'Ethical Hacking', 5, 'security', 'Advanced', 799.99, '45 hours', 15);


-- TABLE 4: ENROLLMENTS TABLE

DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY,
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE,
    completion_status VARCHAR(20),
    completion_date DATE,
    final_score VARCHAR(10),  -- Intentionally VARCHAR for mixed formats
    payment_status VARCHAR(20)
)CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, completion_status, completion_date, final_score, payment_status) VALUES 
(1, 101, 1, '2023-02-01', 'Completed', '2023-03-15', '87.5', 'Paid'),
(2, 101, 2, '2023-03-20', 'In Progress', NULL, 'null', 'Paid'), -- null as string (messiness)
(3, 102, 3, '2023-02-15', 'Completed', '2023-04-10', '92%', 'Paid'), -- percentage format (messiness)
(4, 102, 5, '2023-04-15', 'in_progress', NULL, NULL, 'Pending'), -- underscore format (messiness)
(5, 103, 6, '2023-02-10', 'Completed', '2023-05-20', '78.3', 'Paid'),
(6, 103, 1, '2023-05-25', 'Dropped', NULL, 'N/A', 'Refunded'), -- N/A instead of NULL (messiness)
(7, 104, 2, '2023-03-05', 'Completed', '2023-05-15', '85.7', 'Paid'),
(8, 105, 7, '2023-02-20', 'Completed', '2023-04-25', '94.2', 'Paid'),
(9, 105, 8, '2023-05-01', 'In Progress', NULL, NULL, 'Paid'),
(10, 106, 4, '2023-03-10', 'Completed', '2023-05-20', '89.8', 'Paid'),
(11, 107, 8, '2023-01-25', 'Completed', '2023-03-15', '91.5', 'Paid'),
(12, 108, 9, '2023-04-05', 'In Progress', NULL, '0', 'Paid'), -- 0 instead of NULL (messiness)
(13, 109, 1, '2023-01-30', 'Completed', '2023-03-20', '88.2', 'Paid'),
(14, 109, 4, '2023-04-01', 'In Progress', NULL, NULL, 'Paid'),
(15, 110, 2, '2023-02-25', 'Completed', '2023-04-15', '76.8', 'Paid'),
(16, 111, 5, '2023-03-12', 'Completed', '2023-05-10', '93.7', 'Paid'),
(17, 112, 6, '2023-01-20', 'Dropped', '2023-02-28', NULL, 'Refunded'),
(18, 113, 3, '2023-02-18', 'Completed', '2023-04-20', '81.5', 'Paid'),
(19, 114, 7, '2023-03-22', 'In Progress', NULL, NULL, 'Pending'),
(20, 115, 8, '2023-01-15', 'Completed', '2023-03-25', '90.1', 'Paid'),
(21, 116, 9, '2023-04-10', 'In Progress', NULL, NULL, 'Paid'),
(22, 117, 1, '2023-02-05', 'Completed', '2023-04-05', '86.0', 'Paid'),
(23, 118, 2, '2023-03-15', 'Completed', '2023-05-12', '95.3', 'Paid'),
(24, 119, 4, '2023-01-28', 'Dropped', NULL, NULL, 'Refunded'),
(25, 120, 5, '2023-04-20', 'In Progress', NULL, NULL, 'Paid'),
(26, 121, 6, '2023-02-12', 'Completed', '2023-04-25', '82.8', 'Paid'),
(27, 122, 3, '2023-03-08', 'Completed', '2023-05-05', '89.4', 'Paid'),
(28, 123, 7, '2023-01-22', 'In Progress', NULL, NULL, 'Pending'),
(29, 124, 8, '2023-04-15', 'Completed', '2023-06-10', '77.0', 'Paid'),
(30, 125, 9, '2023-02-28', 'Completed', '2023-04-30', '91.7', 'Paid');


-- TABLE 5: LEARNING_SESSIONS TABLE

DROP TABLE IF EXISTS learning_sessions;
CREATE TABLE learning_sessions (
    session_id INTEGER PRIMARY KEY,
    student_id INTEGER,
    course_id INTEGER,
    session_date DATE,
    session_duration VARCHAR(15),  -- Intentionally VARCHAR for messiness
    lessons_completed INTEGER,
    quiz_score DECIMAL(5,2),
    device_type VARCHAR(20),
    session_rating INTEGER
)CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

INSERT INTO learning_sessions (session_id, student_id, course_id, session_date, session_duration, lessons_completed, quiz_score, device_type, session_rating) VALUES 
(1, 101, 1, '2023-02-01', '120 minutes', 3, 85.0, 'Desktop', 4),
(2, 101, 1, '2023-02-03', '90 mins', 2, 78.5, 'mobile', 4),
(3, 101, 1, '2023-02-05', '2 hours', 4, 92.0, 'Desktop', 5),
(4, 101, 2, '2023-03-25', '150 minutes', 5, 93.5, 'Desktop', 5),
(5, 102, 3, '2023-02-15', '105', 2, 88.0, 'Laptop', 4),
(6, 102, 3, '2023-02-17', '95 minutes', 3, 91.5, 'Desktop', 5),
(7, 102, 5, '2023-04-18', 'null', 0, NULL, 'Mobile', 2),
(8, 103, 6, '2023-02-10', '150 minutes', 4, 82.0, 'Desktop', 3),
(9, 103, 6, '2023-02-12', '90 minutes', 2, 85.0, 'Mobile', 3),
(10, 103, 1, '2023-05-28', '95', 2, 79.5, 'Desktop', 3),
(11, 104, 2, '2023-03-05', '110 minutes', 3, 87.5, 'tablet', 4),
(12, 105, 7, '2023-02-20', '130 minutes', 5, 89.0, 'Desktop', 5),
(13, 105, 8, '2023-05-01', '90 minutes', 2, 76.0, 'Mobile', 3),
(14, 105, 8, '2023-05-15', '1 hour', 2, 81.5, 'mobile', 3),
(15, 106, 4, '2023-03-10', '85 minutes', 2, 93.0, 'Desktop', 5),
(16, 106, 9, '2023-03-25', '130 minutes', 3, 87.0, 'Desktop', 4),
(17, 107, 8, '2023-01-25', '100 minutes', 3, 88.5, 'Desktop', 4),
(18, 107, 4, '2023-02-05', '', 1, 73.0, 'tablet', 2),
(19, 108, 9, '2023-04-05', '80 minutes', 1, 65.0, 'Mobile', 2),
(20, 108, 6, '2023-04-10', '120 minutes', 3, 86.0, 'Desktop', 4),
(21, 109, 1, '2023-02-02', '115 minutes', 3, 86.5, 'Desktop', 4),
(22, 109, 4, '2023-04-03', '150 minutes', 5, 91.0, 'Laptop', 5),
(23, 109, 8, '2023-04-05', '2 hours', 4, 91.5, 'Mobile', 5),
(24, 110, 2, '2023-03-01', '95', 2, 79.5, 'mobile', 3),
(25, 110, 5, '2023-03-05', '105 minutes', 2, 83.0, 'Desktop', 3),
(26, 111, 5, '2023-03-15', '125 minutes', 4, 88.0, 'Desktop', 4),
(27, 111, 2, '2023-04-22', '85 minutes', 2, 80.0, 'Laptop', 3),
(28, 112, 6, '2023-01-22', '80 minutes', 2, 75.0, 'Mobile', 3),
(29, 112, 7, '2023-01-28', '115 minutes', 3, 85.0, 'Desktop', 4),
(30, 113, 3, '2023-02-20', '100 minutes', 3, 82.0, 'Tablet', 3),
(31, 113, 1, '2023-03-02', '90 minutes', 3, 88.5, 'mobile', 4),
(32, 114, 7, '2023-03-25', '140 minutes', 4, 87.0, 'Desktop', 4),
(33, 114, 9, '2023-04-25', '140 minutes', 5, 92.5, 'Desktop', 5),
(34, 115, 8, '2023-01-18', '120 minutes', 2, 82.0, 'Laptop', 3),
(35, 115, 3, '2023-02-18', '100', 2, 80.0, 'tablet', 3),
(36, 116, 9, '2023-04-12', '100 minutes', 3, 89.5, 'Desktop', 5),
(37, 116, 6, '2023-04-15', '75 minutes', 1, 67.0, 'Mobile', 2),
(38, 117, 1, '2023-02-08', '110', 3, 84.0, 'Mobile', 4),
(39, 117, 8, '2023-03-08', '125 minutes', 3, 87.5, 'Desktop', 4),
(40, 118, 2, '2023-03-18', '135 minutes', 4, 90.0, 'Desktop', 5),
(41, 118, 4, '2023-05-20', '150 minutes', 4, 90.0, 'Laptop', 5),
(42, 119, 4, '2023-01-30', '85 minutes', 1, 70.0, 'Tablet', 2),
(43, 119, 1, '2023-02-02', '110 minutes', 2, 75.0, 'Desktop', 3),
(44, 120, 5, '2023-04-22', '120 minutes', 3, 85.5, 'Desktop', 4),
(45, 120, 7, '2023-04-20', '110 minutes', 3, 84.0, 'mobile', 4),
(46, 121, 6, '2023-02-14', '105 minutes', 2, 88.0, 'Mobile', 4),
(47, 121, 5, '2023-03-18', '95 minutes', 2, 78.5, 'Desktop', 3),
(48, 122, 3, '2023-03-12', '120 minutes', 5, 92.5, 'Desktop', 5),
(49, 122, 2, '2023-05-12', '135 minutes', 4, 89.0, 'Mobile', 4),
(50, 123, 7, '2023-01-24', '90 minutes', 2, 78.0, 'Laptop', 3),
(51, 123, 9, '2023-01-30', '120 minutes', 2, 82.5, 'Tablet', 3),
(52, 124, 8, '2023-04-18', '145 minutes', 4, 86.0, 'Desktop', 4),
(53, 124, 6, '2023-04-12', '85 minutes', 1, 70.5, 'Desktop', 2),
(54, 125, 9, '2023-03-02', '90', 2, 81.0, 'mobile', 3),
(55, 125, 8, '2023-03-05', '150 minutes', 5, 94.0, 'Laptop', 5);


-- DATABASE STATUS:

-- 7 instructors loaded
-- 25 students loaded
-- 9 courses loaded
-- 30 enrollments loaded
-- 55 learning sessions loaded


-- ==========================================
-- Add foreign key relationships
-- ==========================================

ALTER TABLE courses 
ADD CONSTRAINT fk_courses_instructor 
FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id);

ALTER TABLE enrollments 
ADD CONSTRAINT fk_enrollments_student 
FOREIGN KEY (student_id) REFERENCES students(student_id);

ALTER TABLE enrollments 
ADD CONSTRAINT fk_enrollments_course 
FOREIGN KEY (course_id) REFERENCES courses(course_id);

ALTER TABLE learning_sessions 
ADD CONSTRAINT fk_sessions_student 
FOREIGN KEY (student_id) REFERENCES students(student_id);

ALTER TABLE learning_sessions 
ADD CONSTRAINT fk_sessions_course 
FOREIGN KEY (course_id) REFERENCES courses(course_id);