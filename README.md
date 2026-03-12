# SQL Module - Setup & Installation Guide

## Step 1: Install MySQL Community Server

1. Go to: https://dev.mysql.com/downloads/installer/
2. Download **MySQL Installer for Windows** (the larger "mysql-installer-community" file)
3. Run the installer and choose **Custom** setup type
4. Select these two products:
   - **MySQL Server 8.x** (under MySQL Servers)
   - **MySQL Workbench 8.x** (under Applications)
5. Click **Next** through each step. Use these settings when prompted:
   - **Port:** `3306` (default)
   - **Root password:** set a password you'll remember (e.g., `password` is fine for local dev)
   - **Windows Service:** check "Configure MySQL Server as a Windows Service" and "Start the MySQL Server at System Startup"
6. Complete the installation

> **Already have MySQL installed a different way?** That's fine — just make sure MySQL Server is running and you know the root password. You can check by opening a terminal and running: `mysql -u root -p`

## Step 2: Open MySQL Workbench

- Press `Win + S`, type **MySQL Workbench**, and open it
- If it doesn't appear in search, check your Start Menu under the **MySQL** folder

## Step 3: Connect to Your Local Server

1. On the Workbench home screen, you should see a **Local instance** connection tile — click it
2. If no connection exists, create one:
   - Click the **+** icon next to "MySQL Connections"
   - **Connection Name:** `Local`
   - **Hostname:** `127.0.0.1`
   - **Port:** `3306`
   - **Username:** `root`
   - **Password:** click "Store in Vault" and enter the root password you set during install
   - Click **Test Connection** — you should see "Successfully made the MySQL connection"
   - Click **OK**
3. Double-click the connection to open it

## Step 4: Load the University Database

1. In Workbench, go to **File → Open SQL Script**
2. Navigate to this folder and open **`setup_university_db.sql`**
3. Click the **lightning bolt** icon (⚡) or press **Ctrl+Shift+Enter** to run the entire script
4. You should see results appearing in the output panel at the bottom
5. In the left sidebar under **SCHEMAS**, right-click and select **Refresh All** — you should now see the `university` database

## Step 5: Start Writing Queries

1. Open a **new query tab**: **File → New Query Tab** (or **Ctrl+T**)
2. Make sure `university` is selected as your active schema:
   - Either double-click `university` in the left sidebar (it will become **bold**)
   - Or type `USE university;` at the top of your query
3. Write your SQL and press **Ctrl+Shift+Enter** to execute

## Database Schema

```
department    (id, name)
course        (id, name, deptId → department.id)
student       (id, firstName, lastName)
faculty       (id, firstName, lastName)
studentCourse (studentId → student.id, courseId → course.id, startDate, progress)
facultyCourse (facultyId → faculty.id, courseId → course.id)
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Can't connect to MySQL server" | MySQL Server isn't running. Open **Services** (Win+R → `services.msc`) and start the **MySQL80** service |
| No schemas in sidebar | Right-click in the SCHEMAS panel → Refresh All |
| "Access denied for user root" | Wrong password. Re-enter it via: Edit Connection → Store in Vault |
| Workbench won't open | Re-download from https://dev.mysql.com/downloads/workbench/ |

## Re-running Setup

The `setup_university_db.sql` script is safe to re-run anytime — it drops and recreates the database from scratch.
