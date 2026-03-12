# SQL Lessons — Study Guide

This module prepares you for the HackerRank SQL assessment. Work through each lesson in order — each one builds on the previous.

> **Before starting:** Make sure you've completed the [setup instructions](README.md) and have the `university` database loaded in MySQL Workbench.

---

## How to Use These Lessons

1. Open any `.sql` file in MySQL Workbench (**File → Open SQL Script**)
2. Read the comments — they explain the concept
3. **Run examples one at a time**: highlight a single query and press **Ctrl+Shift+Enter**
4. Try the **Practice** problem at the end before scrolling to the answer

---

## Lesson Plan

### Day 1 — Joins and Grouping

| Lesson | File | What You'll Learn |
|--------|------|-------------------|
| 1 | [lesson_1_join_group_order.sql](lessons/lesson_1_join_group_order.sql) | INNER JOIN, GROUP BY, COUNT, multi-column ORDER BY |
| 2 | [lesson_2_left_join_having.sql](lessons/lesson_2_left_join_having.sql) | LEFT JOIN, NULL behavior, HAVING vs WHERE, finding missing data |

**After Day 1 you can solve:**
- Count courses per department (JOIN + GROUP BY)
- Count students per course (JOIN + GROUP BY + ORDER BY)
- Find courses with no faculty (LEFT JOIN + HAVING)

### Day 2 — Dates, Aggregates, and Filtering

| Lesson | File | What You'll Learn |
|--------|------|-------------------|
| 3 | [lesson_3_dates_distinct.sql](lessons/lesson_3_dates_distinct.sql) | YEAR(), COUNT(DISTINCT), date functions |
| 4 | [lesson_4_avg_round_having.sql](lessons/lesson_4_avg_round_having.sql) | AVG, ROUND, HAVING with aliases, LIMIT |

**After Day 2 you can solve:**
- Distinct students per year (YEAR + DISTINCT)
- Students with low average progress (AVG + HAVING)
- Top course by average (ORDER BY + LIMIT)

### Day 3 — CASE Expressions + Practice Exam

| Lesson | File | What You'll Learn |
|--------|------|-------------------|
| 5 | [lesson_5_case_min_max.sql](lessons/lesson_5_case_min_max.sql) | CASE WHEN/THEN/END, MIN, MAX, combining CASE with aggregates |
| Practice | [practice_exam.sql](lessons/practice_exam.sql) | 7 fresh questions covering all patterns (timed practice) |

**After Day 3 you can solve:**
- Letter grade assignments using CASE + MIN/MAX
- Any combination of the patterns above

---

## Quick Reference

### SQL Clause Order
```sql
SELECT   columns / expressions / aggregates
FROM     table
JOIN     other_table ON condition
WHERE    row-level filters (before grouping)
GROUP BY columns to group on
HAVING   group-level filters (after grouping)
ORDER BY sort columns (ASC/DESC)
LIMIT    number of rows to return
```

### Common Aggregate Functions
| Function | Description |
|----------|-------------|
| `COUNT(column)` | Number of non-NULL values |
| `COUNT(DISTINCT column)` | Number of unique non-NULL values |
| `COUNT(*)` | Total row count (including NULLs) |
| `AVG(column)` | Average value |
| `SUM(column)` | Total sum |
| `MIN(column)` | Smallest value |
| `MAX(column)` | Largest value |
| `ROUND(value, n)` | Round to n decimal places |

### JOIN Types
| Type | Returns |
|------|---------|
| `INNER JOIN` | Only rows with matches in **both** tables |
| `LEFT JOIN` | All rows from the **left** table + matches from right (NULL if no match) |
| `RIGHT JOIN` | All rows from the **right** table + matches from left (NULL if no match) |

### CASE Expression
```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default
END AS alias
```

### WHERE vs HAVING
| | WHERE | HAVING |
|---|---|---|
| Filters | Individual rows | Groups (after GROUP BY) |
| Can use aggregates? | No | Yes |
| Runs | Before grouping | After grouping |

---

## Database Schema

See the full [Entity Relationship Diagram](ERD.md) for a visual.

```
department    (id, name)
course        (id, name, deptId → department.id)
student       (id, firstName, lastName)
faculty       (id, firstName, lastName)
studentCourse (studentId, courseId, startDate, progress)
facultyCourse (facultyId, courseId)
```
