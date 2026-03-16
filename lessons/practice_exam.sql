-- ============================================================
-- SBA PRACTICE EXAM
-- ============================================================
-- These questions use the same patterns as the HackerRank exam.
-- Try each one on your own before checking the answers at the bottom.
-- Time yourself — on the real exam you won't have unlimited time.
--
-- REMEMBER:
--   USE university;  (run this first)
-- ============================================================

USE university;

-- ============================================================
-- QUESTION 1
-- ============================================================
-- Show each department name and the number of students enrolled
-- in courses in that department.
-- Count DISTINCT students (a student in 2 courses in the same dept = 1).
-- Sort by student count descending, then department name ascending.
--
-- Expected columns: name, student_count
-- My result: 

-- select d.name, COUNT(DISTINCT(sc.studentId)) as student_count
-- from university.department d
-- inner join university.course as c ON d.id = c.deptId
-- inner join university.studentcourse as sc ON c.id = sc.courseId
-- group by d.name
-- ORDER by student_count desc, d.name asc


-- ============================================================
-- QUESTION 2
-- ============================================================
-- Show the first name and last name of students who are enrolled
-- in more than 3 courses.
-- Sort by last name ascending, first name ascending.
--
-- Expected columns: firstName, lastName
-- My code:

-- select s.firstName, s.lastName
-- from university.student as s
-- INNER join university.studentcourse as sc ON s.id = sc.studentId
-- group by sc.studentId
-- having COUNT(sc.studentId)>3
-- order by s.firstName asc , s.lastName asc


-- ============================================================
-- QUESTION 3
-- ============================================================
-- Show each department name and its average student progress,
-- rounded to 1 decimal place. Only include departments where
-- the average progress is below 60.
-- Sort by average progress ascending.
--
-- Expected columns: name, AvgProgress
-- My Code:
-- select d.name, ROUND(avg(sc.progress),1) as AvgProgress
-- from university.department as d
-- inner join university.course as c ON d.id = c.deptId
-- inner join university.studentcourse as sc ON c.id = sc.courseId
-- group by d.name
-- having AvgProgress<60
-- order by AvgProgress asc;



-- ============================================================
-- QUESTION 4
-- ============================================================
-- Show each faculty member's first name, last name, and how
-- many courses they teach. Include faculty who teach 0 courses.
-- Sort by course count descending, then last name ascending.
--
-- Expected columns: firstName, lastName, course_count
-- MY Code:
-- USE university; -- Acts as a quick university.faculty
-- select f.firstName, f.lastName, COUNT(fc.courseId) as course_count
-- from faculty as f
-- inner join facultycourse as fc ON f.id = fc.facultyId
-- group by f.id -- Has to be grouped based on what matches in the ON
-- order by course_count desc, f.lastName asc


-- ============================================================
-- QUESTION 5
-- ============================================================
-- For each year, show the number of distinct courses that had
-- at least one enrollment.
-- Sort by year ascending.
--
-- Expected columns: Year, active_courses
-- My Code:
-- USE university;
-- select YEAR(sc.startDate) as Year, count(DISTINCT(courseId)) as active_courses
-- from studentcourse as sc
-- group by Year
-- having count(distinct(courseId))>=1
-- order by Year asc

-- ============================================================
-- QUESTION 6
-- ============================================================
-- Show each student's first name, last name, and a "status" column:
--   If their MAX progress >= 70: 'On Track'
--   If their MAX progress >= 50: 'Needs Improvement'
--   Otherwise: 'At Risk'
-- Sort by status ascending, then last name ascending.
--
-- Expected columns: firstName, lastName, status
-- MY Code:
-- USE university;
-- select s.firstName as "First Name", s.lastName as "Last Name",
-- case
--	  when sc.progress>=70 then "On Track"
--    when sc.progress>=50 then "Needs Improvement"
--    else "At Risk"
-- end as Status
-- from student as s
-- inner join studentcourse as sc ON s.id = sc.studentId
-- order by Status asc, s.lastName DESC


-- ============================================================
-- QUESTION 7
-- ============================================================
-- Show the single department that has the most enrolled students
-- (count distinct students). Display the department name and count.
--
-- Expected columns: name, student_count
-- MY code:
-- use university;
-- select d.name, count(distinct(studentId)) as student_count
-- from department as d
-- inner join course as c ON d.id = c.deptId
-- inner join studentcourse as sc ON c.id = sc.courseId
-- group by d.name






































-- ============================================================
-- ANSWERS (don't peek until you've tried!)
-- ============================================================

-- ANSWER 1
SELECT d.name, COUNT(DISTINCT sc.studentId) AS student_count
FROM department d
INNER JOIN course c ON d.id = c.deptId
INNER JOIN studentCourse sc ON c.id = sc.courseId
GROUP BY d.name
ORDER BY student_count DESC, d.name ASC;

-- ANSWER 2
SELECT s.firstName, s.lastName
FROM student s
INNER JOIN studentCourse sc ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName
HAVING COUNT(sc.courseId) > 3
ORDER BY s.lastName ASC, s.firstName ASC;

-- ANSWER 3
SELECT d.name, ROUND(AVG(sc.progress), 1) AS AvgProgress
FROM department d
INNER JOIN course c ON d.id = c.deptId
INNER JOIN studentCourse sc ON c.id = sc.courseId
GROUP BY d.name
HAVING AvgProgress < 60
ORDER BY AvgProgress ASC;

-- ANSWER 4
SELECT f.firstName, f.lastName, COUNT(fc.courseId) AS course_count
FROM faculty f
LEFT JOIN facultyCourse fc ON f.id = fc.facultyId
GROUP BY f.firstName, f.lastName
ORDER BY course_count DESC, f.lastName ASC;

-- ANSWER 5
SELECT YEAR(sc.startDate) AS Year, COUNT(DISTINCT sc.courseId) AS active_courses
FROM studentCourse sc
GROUP BY Year
ORDER BY Year ASC;

-- ANSWER 6
SELECT s.firstName, s.lastName,
    CASE
        WHEN MAX(sc.progress) >= 70 THEN 'On Track'
        WHEN MAX(sc.progress) >= 50 THEN 'Needs Improvement'
        ELSE 'At Risk'
    END AS status
FROM student s
INNER JOIN studentCourse sc ON s.id = sc.studentId
GROUP BY s.firstName, s.lastName
ORDER BY status ASC, s.lastName ASC;

-- ANSWER 7
SELECT d.name, COUNT(DISTINCT sc.studentId) AS student_count
FROM department d
INNER JOIN course c ON d.id = c.deptId
INNER JOIN studentCourse sc ON c.id = sc.courseId
GROUP BY d.name
ORDER BY student_count DESC, d.name ASC
LIMIT 1;
