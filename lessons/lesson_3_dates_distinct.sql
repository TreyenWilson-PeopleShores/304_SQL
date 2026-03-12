-- ============================================================
-- LESSON 3: DATE FUNCTIONS + DISTINCT + GROUP BY
-- ============================================================
-- GOAL: Extract parts of dates and count unique values.
--
-- KEY CONCEPTS:
--   YEAR()            — extracts the year from a DATE or DATETIME column.
--   COUNT(DISTINCT x) — counts only unique values of x (ignores duplicates).
--   Aliasing in GROUP BY — MySQL allows GROUP BY on a column alias.
--
-- OTHER DATE FUNCTIONS (good to know):
--   MONTH(date)  — returns 1-12
--   DAY(date)    — returns 1-31
--   DATE_FORMAT(date, '%Y-%m') — custom formatting

USE university;

-- ----------------------------------------
-- EXAMPLE 3a: YEAR() basics
-- "Show each enrollment with the year extracted"
-- ----------------------------------------
SELECT sc.studentId, sc.courseId, sc.startDate, YEAR(sc.startDate) AS enrollYear
FROM studentCourse sc;

-- ----------------------------------------
-- EXAMPLE 3b: COUNT vs COUNT(DISTINCT)
-- "How many enrollments per year vs how many UNIQUE students per year?"
-- ----------------------------------------

-- Total enrollments per year (one student in 3 courses = counted 3 times)
SELECT YEAR(sc.startDate) AS Year, COUNT(*) AS total_enrollments
FROM studentCourse sc
GROUP BY Year
ORDER BY Year;

-- Unique students per year (one student in 3 courses = counted once)
SELECT YEAR(sc.startDate) AS Year, COUNT(DISTINCT sc.studentId) AS unique_students
FROM studentCourse sc
GROUP BY Year
ORDER BY Year;

-- Compare the numbers — COUNT(DISTINCT) is always <= COUNT(*)

-- ----------------------------------------
-- EXAMPLE 3c: Full query — distinct students per year, sorted
-- ----------------------------------------
SELECT COUNT(DISTINCT sc.studentId) AS Students, YEAR(sc.startDate) AS Year
FROM studentCourse sc
GROUP BY Year
ORDER BY Year ASC, Students DESC;


-- ============================================================
-- PRACTICE 3
-- ============================================================
-- Write a query that shows:
--   - The year
--   - The number of UNIQUE courses that had enrollments that year
-- Sort by year ascending.
--
-- Table: studentCourse (sc)
-- Use: YEAR(sc.startDate), COUNT(DISTINCT sc.courseId)

-- SCROLL DOWN FOR ANSWER...










-- ANSWER:
SELECT YEAR(sc.startDate) AS Year, COUNT(DISTINCT sc.courseId) AS active_courses
FROM studentCourse sc
GROUP BY Year
ORDER BY Year ASC;
