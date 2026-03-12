# University Database — Entity Relationship Diagram

```mermaid
erDiagram
    department ||--|{ course : "has"
    course }|--|| department : "belongs to"

    student ||--o{ studentCourse : "enrolls in"
    course ||--o{ studentCourse : "has enrollment"

    faculty ||--o{ facultyCourse : "teaches"
    course ||--o{ facultyCourse : "taught by"

    department {
        INT id PK
        VARCHAR name
    }

    course {
        INT id PK
        VARCHAR name
        INT deptId FK
    }

    student {
        INT id PK
        VARCHAR firstName
        VARCHAR lastName
    }

    faculty {
        INT id PK
        VARCHAR firstName
        VARCHAR lastName
    }

    studentCourse {
        INT studentId FK
        INT courseId FK
        DATE startDate
        DECIMAL progress
    }

    facultyCourse {
        INT facultyId FK
        INT courseId FK
    }
```

## Relationships

| Relationship | Type | Description |
|---|---|---|
| department → course | One-to-Many | A department has many courses; each course belongs to one department |
| student → studentCourse | One-to-Many | A student can enroll in many courses |
| course → studentCourse | One-to-Many | A course can have many enrolled students |
| faculty → facultyCourse | One-to-Many | A faculty member can teach many courses |
| course → facultyCourse | One-to-Many | A course can be taught by many faculty |

> **Note:** `studentCourse` and `facultyCourse` are **junction tables** (also called bridge/join tables). They create many-to-many relationships between student↔course and faculty↔course.
