-- ============================================================
-- LESSON 1: INNER JOIN + GROUP BY + ORDER BY
-- ============================================================
-- GOAL: Combine rows from two related tables, group the results,
--       and sort them.
--
-- KEY CONCEPTS:
--   INNER JOIN — returns only rows that have a match in BOTH tables.
--   GROUP BY   — collapses rows into groups (one row per group).
--   COUNT()    — counts how many rows are in each group.
--   ORDER BY   — sorts the final result. Can sort by aliases or multiple columns.

USE university;

-- ----------------------------------------
-- EXAMPLE 1a: Basic INNER JOIN (no grouping)
-- "Show every course alongside its department name"
-- ----------------------------------------
SELECT d.name AS department, c.name AS course
FROM department d
INNER JOIN course c ON d.id = c.deptId;

-- Notice: each row is one course. Departments with multiple courses appear multiple times.

-- ----------------------------------------
-- EXAMPLE 1b: Adding GROUP BY + COUNT
-- "How many courses does each department have?"
-- ----------------------------------------
SELECT d.name, COUNT(c.id) AS total_courses
FROM department d
INNER JOIN course c ON d.id = c.deptId
GROUP BY d.name;

-- GROUP BY d.name collapses all courses per department into one row.
-- COUNT(c.id) counts how many course rows fell into each group.

-- ----------------------------------------
-- EXAMPLE 1c: Adding ORDER BY with multiple columns
-- "Sort by total_courses ascending, then by department name ascending"
-- ----------------------------------------
SELECT d.name, COUNT(c.id) AS total_courses
FROM department d
INNER JOIN course c ON d.id = c.deptId
GROUP BY d.name
ORDER BY total_courses, d.name;

-- MySQL lets you ORDER BY a column alias (total_courses).
-- When two departments tie on total_courses, d.name breaks the tie.


-- ============================================================
-- PRACTICE 1 (try before looking at the answer below)
-- ============================================================
-- Write a query that shows each course name and how many students
-- are enrolled in it. Sort by number of students descending,
-- then course name ascending.
--
-- Tables: course (c), studentCourse (sc)
-- Join on: sc.courseId = c.id

-- SCROLL DOWN FOR ANSWER...










-- ANSWER:
SELECT c.name, COUNT(sc.studentId) AS num_of_students
FROM course c
INNER JOIN studentCourse sc ON sc.courseId = c.id
GROUP BY c.name
ORDER BY num_of_students DESC, c.name ASC;
