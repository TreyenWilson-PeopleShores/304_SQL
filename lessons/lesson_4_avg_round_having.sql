-- ============================================================
-- LESSON 4: AGGREGATE FUNCTIONS — AVG, ROUND, HAVING with aliases
-- ============================================================
-- GOAL: Calculate averages, round results, and filter groups by
--       aggregate values.
--
-- KEY CONCEPTS:
--   AVG()   — returns the average of a numeric column within a group.
--   ROUND(value, decimals) — rounds to N decimal places.
--   HAVING with alias — MySQL allows HAVING to reference a SELECT alias.
--                        (Note: PostgreSQL and SQL Server do NOT allow this.)

USE university;

-- ----------------------------------------
-- EXAMPLE 4a: AVG basics
-- "What is each student's average progress across all their courses?"
-- ----------------------------------------
SELECT s.firstName, s.lastName, AVG(sc.progress) AS avg_progress
FROM student s
LEFT JOIN studentCourse sc ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName;

-- Notice: the averages have many decimal places. Let's clean that up.

-- ----------------------------------------
-- EXAMPLE 4b: ROUND
-- "Same query, but round to 1 decimal place"
-- ----------------------------------------
SELECT s.firstName, s.lastName, ROUND(AVG(sc.progress), 1) AS AverageProgress
FROM student s
LEFT JOIN studentCourse sc ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName;

-- ROUND(value, 1) → one decimal place
-- ROUND(value, 0) → whole number
-- ROUND(value, 2) → two decimal places

-- ----------------------------------------
-- EXAMPLE 4c: HAVING with a column alias
-- "Only show students whose average progress is below 50"
-- ----------------------------------------
SELECT s.firstName, s.lastName, ROUND(AVG(sc.progress), 1) AS AverageProgress
FROM student s
LEFT JOIN studentCourse sc ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName
HAVING AverageProgress < 50
ORDER BY AverageProgress DESC, s.firstName ASC, s.lastName ASC;

-- IMPORTANT MYSQL BEHAVIOR:
--   HAVING AverageProgress < 50   ✅ works in MySQL (alias in HAVING)
--   HAVING AVG(sc.progress) < 50  ✅ also works (repeat the expression)
--   WHERE AVG(sc.progress) < 50   ❌ ERROR — can't use aggregates in WHERE

-- ----------------------------------------
-- EXAMPLE 4d: LIMIT — getting top/bottom N results
-- "Which single course has the highest average progress?"
-- ----------------------------------------
SELECT c.name, ROUND(AVG(sc.progress), 1) AS AverageProgress
FROM course c
INNER JOIN studentCourse sc ON c.id = sc.courseId
GROUP BY c.name
ORDER BY AverageProgress DESC, c.name
LIMIT 1;

-- ORDER BY ... DESC puts the highest first, LIMIT 1 takes just that one row.
-- To get bottom 1: change DESC to ASC.
-- To get top 3: change LIMIT 1 to LIMIT 3.


-- ============================================================
-- PRACTICE 4
-- ============================================================
-- Write a query that shows each department's average student progress.
-- Round to 1 decimal. Only show departments where the average is above 55.
-- Sort by average descending.
--
-- You'll need to join: department → course → studentCourse
--
-- Tables: department (d), course (c), studentCourse (sc)
-- Joins: d.id = c.deptId, c.id = sc.courseId

-- SCROLL DOWN FOR ANSWER...










-- ANSWER:
SELECT d.name, ROUND(AVG(sc.progress), 1) AS AvgProgress
FROM department d
INNER JOIN course c ON d.id = c.deptId
INNER JOIN studentCourse sc ON c.id = sc.courseId
GROUP BY d.name
HAVING AvgProgress > 55
ORDER BY AvgProgress DESC;
