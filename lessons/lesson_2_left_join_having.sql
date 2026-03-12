-- ============================================================
-- LESSON 2: LEFT JOIN + HAVING (Finding Missing Relationships)
-- ============================================================
-- GOAL: Find rows in one table that have NO matching rows in another.
--
-- KEY CONCEPTS:
--   LEFT JOIN — returns ALL rows from the left table, even if there's
--              no match in the right table (unmatched columns come back as NULL).
--   HAVING    — filters AFTER grouping (WHERE filters BEFORE grouping).
--   COUNT() with LEFT JOIN — count of a right-table column is 0 when no match exists.
--
-- MENTAL MODEL:
--   WHERE  = "filter individual rows before grouping"
--   HAVING = "filter groups after GROUP BY runs"

USE university;

-- ----------------------------------------
-- EXAMPLE 2a: LEFT JOIN — see the NULLs
-- "Show every course and its assigned faculty (if any)"
-- ----------------------------------------
SELECT c.name AS course, fc.facultyId
FROM course c
LEFT JOIN facultyCourse fc ON c.id = fc.courseId;

-- Notice: courses with no faculty show NULL in the facultyId column.
-- An INNER JOIN would have hidden those rows entirely.

-- ----------------------------------------
-- EXAMPLE 2b: LEFT JOIN vs INNER JOIN comparison
-- Run both and compare the row counts:
-- ----------------------------------------

-- INNER JOIN: only courses that HAVE faculty
SELECT c.name AS course, fc.facultyId
FROM course c
INNER JOIN facultyCourse fc ON c.id = fc.courseId;

-- LEFT JOIN: ALL courses, faculty or not
SELECT c.name AS course, fc.facultyId
FROM course c
LEFT JOIN facultyCourse fc ON c.id = fc.courseId;

-- ----------------------------------------
-- EXAMPLE 2c: Using HAVING to find courses with NO faculty
-- "Which courses have zero faculty assigned?"
-- ----------------------------------------
SELECT c.name
FROM course c
LEFT JOIN facultyCourse fc ON c.id = fc.courseId
GROUP BY c.name
HAVING COUNT(fc.facultyId) = 0
ORDER BY c.name ASC;

-- HOW IT WORKS step by step:
--   1. LEFT JOIN gives every course a row (NULLs for unmatched faculty)
--   2. GROUP BY c.name groups rows per course
--   3. COUNT(fc.facultyId) counts non-NULL values — so unassigned courses get 0
--   4. HAVING COUNT(...) = 0 keeps only courses where that count is zero

-- WHY NOT WHERE?
-- This would NOT work:
--     WHERE COUNT(fc.facultyId) = 0   ← ERROR! Can't use aggregate in WHERE
-- Aggregates (COUNT, SUM, AVG, etc.) can only be filtered with HAVING.


-- ============================================================
-- PRACTICE 2
-- ============================================================
-- Write a query to find students who are NOT enrolled in any course.
--
-- Tables: student (s), studentCourse (sc)
-- Join on: s.id = sc.studentId
--
-- Hint: LEFT JOIN + GROUP BY + HAVING COUNT(...) = 0

-- SCROLL DOWN FOR ANSWER...










-- ANSWER:
-- (In our current data, all students have enrollments, so this returns 0 rows.
--  That's expected! The pattern is what matters.)
SELECT s.firstName, s.lastName
FROM student s
LEFT JOIN studentCourse sc ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName
HAVING COUNT(sc.courseId) = 0;
