-- ============================================================
-- LESSON 5: CASE EXPRESSIONS + MIN/MAX
-- ============================================================
-- GOAL: Transform numeric values into categories (like letter grades)
--       using CASE, combined with MIN/MAX aggregates.
--
-- KEY CONCEPTS:
--   CASE WHEN ... THEN ... END — SQL's "if/else" for transforming values.
--   MIN() / MAX()             — smallest/largest value in a group.
--   Combining CASE with aggregates — apply CASE to the RESULT of MIN/MAX.
--
-- CASE SYNTAX:
--   CASE
--       WHEN condition1 THEN result1
--       WHEN condition2 THEN result2
--       ...
--       ELSE default_result
--   END

USE university;

-- ----------------------------------------
-- EXAMPLE 5a: Basic CASE — assign letter grades to progress
-- "Show every enrollment with a letter grade"
-- ----------------------------------------
SELECT s.firstName, s.lastName, c.name AS course, sc.progress,
    CASE
        WHEN sc.progress < 40 THEN 'F'
        WHEN sc.progress < 50 THEN 'D'
        WHEN sc.progress < 60 THEN 'C'
        WHEN sc.progress < 70 THEN 'B'
        WHEN sc.progress >= 70 THEN 'A'
    END AS grade
FROM student s
INNER JOIN studentCourse sc ON s.id = sc.studentId
INNER JOIN course c ON sc.courseId = c.id
ORDER BY s.lastName, s.firstName;

-- IMPORTANT: CASE evaluates top-to-bottom and stops at the FIRST true condition.
-- So "< 50" only catches values 40-49 because "< 40" already caught everything below 40.

-- ----------------------------------------
-- EXAMPLE 5b: MIN and MAX basics
-- "What is each student's lowest and highest progress score?"
-- ----------------------------------------
SELECT s.firstName, s.lastName,
    MIN(sc.progress) AS lowest,
    MAX(sc.progress) AS highest
FROM student s
INNER JOIN studentCourse sc ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName;

-- ----------------------------------------
-- EXAMPLE 5c: CASE wrapped around MIN/MAX
-- "Show each student's worst grade and best grade as letters"
-- ----------------------------------------
SELECT s.firstName, s.lastName,
    CASE
        WHEN MIN(sc.progress) < 40 THEN 'F'
        WHEN MIN(sc.progress) < 50 THEN 'D'
        WHEN MIN(sc.progress) < 60 THEN 'C'
        WHEN MIN(sc.progress) < 70 THEN 'B'
        WHEN MIN(sc.progress) >= 70 THEN 'A'
    END AS minGrade,
    CASE
        WHEN MAX(sc.progress) < 40 THEN 'F'
        WHEN MAX(sc.progress) < 50 THEN 'D'
        WHEN MAX(sc.progress) < 60 THEN 'C'
        WHEN MAX(sc.progress) < 70 THEN 'B'
        WHEN MAX(sc.progress) >= 70 THEN 'A'
    END AS maxGrade
FROM student s
INNER JOIN studentCourse sc ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName
ORDER BY minGrade DESC, maxGrade DESC, s.firstName, s.lastName;

-- HOW THE SORTING WORKS:
--   Grades sort alphabetically: A < B < C < D < F
--   DESC reverses it: F first, then D, C, B, A
--   So students with the WORST min grades appear first.
--   Ties on minGrade break by maxGrade (also DESC), then name.


-- ============================================================
-- PRACTICE 5
-- ============================================================
-- Write a query that shows each student's name and their
-- average progress as a letter grade:
--   A >= 70, B >= 60, C >= 50, D >= 40, F < 40
-- Sort by grade descending, then first name ascending.
--
-- Hint: Use CASE on ROUND(AVG(sc.progress), 1)

-- SCROLL DOWN FOR ANSWER...










-- ANSWER:
SELECT s.firstName, s.lastName,
    CASE
        WHEN AVG(sc.progress) < 40 THEN 'F'
        WHEN AVG(sc.progress) < 50 THEN 'D'
        WHEN AVG(sc.progress) < 60 THEN 'C'
        WHEN AVG(sc.progress) < 70 THEN 'B'
        WHEN AVG(sc.progress) >= 70 THEN 'A'
    END AS avgGrade
FROM student s
INNER JOIN studentCourse sc ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName
ORDER BY avgGrade DESC, s.firstName ASC;
