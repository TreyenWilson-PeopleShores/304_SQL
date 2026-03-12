-- ============================================
-- University Database Setup Script
-- Open this file in MySQL Workbench and run it
-- (Click the lightning bolt icon or Ctrl+Shift+Enter)
-- ============================================

DROP DATABASE IF EXISTS university;
CREATE DATABASE university;
USE university;

-- ============================================
-- CREATE TABLES
-- ============================================

CREATE TABLE department (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    deptId INT NOT NULL,
    FOREIGN KEY (deptId) REFERENCES department(id)
);

CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL
);

CREATE TABLE faculty (
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL
);

CREATE TABLE studentCourse (
    studentId INT NOT NULL,
    courseId INT NOT NULL,
    startDate DATE NOT NULL,
    progress DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (studentId, courseId),
    FOREIGN KEY (studentId) REFERENCES student(id),
    FOREIGN KEY (courseId) REFERENCES course(id)
);

CREATE TABLE facultyCourse (
    facultyId INT NOT NULL,
    courseId INT NOT NULL,
    PRIMARY KEY (facultyId, courseId),
    FOREIGN KEY (facultyId) REFERENCES faculty(id),
    FOREIGN KEY (courseId) REFERENCES course(id)
);

-- ============================================
-- INSERT DATA
-- ============================================

-- Departments
INSERT INTO department (id, name) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'English'),
(4, 'Physics');

-- Courses (varying count per department for Query 1)
INSERT INTO course (id, name, deptId) VALUES
(1, 'Intro to Programming', 1),
(2, 'Data Structures', 1),
(3, 'Database Systems', 1),
(4, 'Calculus I', 2),
(5, 'Linear Algebra', 2),
(6, 'Creative Writing', 3),
(7, 'British Literature', 3),
(8, 'Mechanics', 4),
(9, 'Thermodynamics', 4),
(10, 'Algorithms', 1);

-- Students
INSERT INTO student (id, firstName, lastName) VALUES
(1, 'Alice', 'Martin'),
(2, 'Bob', 'Wilson'),
(3, 'Carol', 'Davis'),
(4, 'David', 'Taylor'),
(5, 'Emma', 'Anderson'),
(6, 'Frank', 'Thomas'),
(7, 'Grace', 'Jackson'),
(8, 'Henry', 'White'),
(9, 'Irene', 'Clark'),
(10, 'Jack', 'Lewis');

-- Faculty
INSERT INTO faculty (id, firstName, lastName) VALUES
(1, 'Dr. Sarah', 'Smith'),
(2, 'Dr. James', 'Johnson'),
(3, 'Dr. Maria', 'Williams'),
(4, 'Dr. Robert', 'Brown');

-- Faculty-Course assignments
-- NOTE: Some courses intentionally have NO faculty (for Query 3)
-- Courses WITHOUT faculty: Database Systems (3), British Literature (7), Thermodynamics (9)
INSERT INTO facultyCourse (facultyId, courseId) VALUES
(1, 1),  -- Dr. Smith -> Intro to Programming
(1, 2),  -- Dr. Smith -> Data Structures
(2, 4),  -- Dr. Johnson -> Calculus I
(2, 5),  -- Dr. Johnson -> Linear Algebra
(3, 6),  -- Dr. Williams -> Creative Writing
(4, 8),  -- Dr. Brown -> Mechanics
(1, 10); -- Dr. Smith -> Algorithms

-- Student-Course enrollments with progress and start dates across multiple years
-- Progress values are designed to cover all grade ranges (F<40, D<50, C<50, B<70, A>=70)
-- Some students have avg progress < 50 (for Query 5)
-- Start dates span 2023-2026 (for Query 4)
INSERT INTO studentCourse (studentId, courseId, startDate, progress) VALUES
-- Alice Martin: high performer (avg > 50)
(1, 1, '2023-09-01', 85.50),
(1, 4, '2023-09-01', 72.00),
(1, 2, '2024-01-15', 78.30),
(1, 6, '2025-09-01', 90.00),

-- Bob Wilson: low performer (avg < 50)
(2, 1, '2023-09-01', 35.00),
(2, 4, '2024-01-15', 42.50),
(2, 8, '2024-09-01', 28.00),

-- Carol Davis: medium performer
(3, 2, '2024-01-15', 55.00),
(3, 5, '2024-09-01', 62.40),
(3, 6, '2025-01-15', 58.00),

-- David Taylor: low performer (avg < 50)
(4, 1, '2024-09-01', 45.00),
(4, 3, '2024-09-01', 38.20),
(4, 8, '2025-01-15', 52.00),

-- Emma Anderson: high performer
(5, 1, '2023-09-01', 92.00),
(5, 2, '2024-01-15', 88.50),
(5, 5, '2024-09-01', 75.00),
(5, 10, '2025-09-01', 80.00),

-- Frank Thomas: low performer (avg < 50)
(6, 4, '2025-01-15', 30.00),
(6, 8, '2025-09-01', 48.50),

-- Grace Jackson: medium-high performer
(7, 1, '2024-09-01', 65.00),
(7, 6, '2025-01-15', 71.30),
(7, 3, '2025-09-01', 60.00),

-- Henry White: varied grades (min low, max high for Query 7)
(8, 2, '2023-09-01', 35.50),
(8, 5, '2024-01-15', 82.00),
(8, 10, '2025-01-15', 55.00),

-- Irene Clark: low performer (avg < 50)
(9, 1, '2025-09-01', 40.00),
(9, 4, '2025-09-01', 47.50),
(9, 7, '2026-01-15', 33.00),

-- Jack Lewis: medium performer
(10, 3, '2026-01-15', 68.00),
(10, 9, '2026-01-15', 57.50),
(10, 1, '2025-09-01', 73.00);

-- ============================================
-- VERIFY: Run each query below to confirm data works
-- ============================================

-- Query 1: Count courses per department
SELECT d.name, count(c.id) as total_courses
FROM department d
INNER JOIN course c
ON d.id = c.deptId
GROUP BY d.name
ORDER BY total_courses, d.name;

-- Query 2: Count students per course
SELECT c.name, count(sc.studentId) as num_of_students
FROM course c
INNER JOIN studentCourse sc
ON sc.courseId = c.id
GROUP BY c.name
ORDER BY num_of_students desc, c.name asc;

-- Query 3: Courses with no faculty assigned
SELECT c.name
FROM course c
LEFT JOIN facultyCourse fc
ON c.id = fc.courseId
GROUP BY c.name
HAVING count(fc.facultyID) = 0
ORDER BY c.name asc;

-- Query 4: Distinct students per year
SELECT count(distinct sc.studentId) as Students, YEAR(sc.startDate) as Year
FROM studentCourse sc
GROUP BY Year
ORDER BY Year asc, Students desc;

-- Query 5: Students with average progress below 50
SELECT s.firstName, s.lastName, ROUND(AVG(sc.progress), 1) as AverageProgress
FROM student s
LEFT JOIN studentCourse sc
ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName
HAVING AverageProgress < 50
ORDER BY AverageProgress desc, s.firstName asc, s.lastName asc;

-- Query 6: Course with highest average progress
SELECT c.name, ROUND(AVG(sc.progress), 1) as AverageProgress
FROM course c
INNER JOIN studentCourse sc
ON c.id = sc.courseId
GROUP BY c.name
ORDER BY AverageProgress desc, c.name
LIMIT 1;

-- Query 7: Min and max grade per student
SELECT s.firstName, s.lastName,
    CASE
        WHEN MIN(sc.progress) < 40 THEN 'F'
        WHEN MIN(sc.progress) < 50 THEN 'D'
        WHEN MIN(sc.progress) < 60 THEN 'C'
        WHEN MIN(sc.progress) < 70 THEN 'B'
        WHEN MIN(sc.progress) >=70 THEN 'A'
    END as minGrade,
    CASE
        WHEN MAX(sc.progress) < 40 THEN 'F'
        WHEN MAX(sc.progress) < 50 THEN 'D'
        WHEN MAX(sc.progress) < 60 THEN 'C'
        WHEN MAX(sc.progress) < 70 THEN 'B'
        WHEN MAX(sc.progress) >=70 THEN 'A'
    END as maxGrade
FROM student s
INNER JOIN studentCourse sc
ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName
ORDER BY minGrade desc, maxGrade desc, s.firstName, s.lastName;
