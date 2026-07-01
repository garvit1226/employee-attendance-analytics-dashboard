# Employee Attendance & Workforce Analytics Dashboard

A complete end-to-end Data Analytics project that simulates a real-world Human Resource (HR) analytics system using Python, MySQL, SQL, and Power BI. The project demonstrates the entire analytics lifecycle—from synthetic data generation and relational database design to SQL-based business analysis, KPI development, data modeling, DAX calculations, and interactive dashboard creation.

The solution is designed to transform raw operational data into meaningful business insights that help HR teams monitor workforce performance, employee attendance, leave management, departmental trends, and shift allocation.

---

# Project Objective

Organizations generate thousands of attendance records every month, but raw data alone provides little business value. This project demonstrates how a Data Analyst can transform transactional HR data into interactive dashboards that support data-driven decision making.

The project answers business questions such as:

- What is the overall attendance rate?
- Which departments have the highest attendance?
- How many employees are on leave?
- What are the average working hours?
- Which shift is assigned most frequently?
- Which departments have the highest absenteeism?
- How are leave requests distributed?
- How does attendance change over time?

---

# Complete Analytics Workflow

```
Python
        │
        ▼
Synthetic Dataset Generation
        │
        ▼
CSV Files
        │
        ▼
MySQL Database
        │
        ▼
SQL Analysis & KPI Queries
        │
        ▼
Power BI Data Model
        │
        ▼
DAX Measures
        │
        ▼
Interactive Dashboard
```

---

# Technology Stack

- Python
- Pandas
- Faker
- MySQL
- SQL
- Power BI Desktop
- DAX

---

# Database Schema

The project follows a relational database structure where the **Employees** table acts as the central entity connecting attendance, leave requests, shifts, and departments.

<img width="1536" height="1024" alt="Database_Schema" src="https://github.com/user-attachments/assets/5f665357-4021-4c01-a1c8-86dd65ff27b6" />


---

# Project Structure

```
Employee-Attendance-Analytics-Dashboard
│
├── Data
│   ├── attendance.csv
│   ├── departments.csv
│   ├── employees.csv
│   ├── holidays.csv
│   ├── leaverequests.csv
│   └── shifts.csv
│
├── Images
│   └── ER_Diagram.png
│
├── Power BI
│   └── Employee Attendance & Workforce Analytics Dashboard.pbix
│
├── Python
│   ├── generate_employees.py
│   ├── generate_attendance.py
│   ├── generate_leave_requests.py
│   └── generate_shifts.py
│
├── SQL
│   ├── BASIC_QUERY.sql
│   ├── INTERMEDIATE_QUERY.sql
│   ├── ADVANCED_QUERY.sql
│   └── KPI_QUERY.sql
│
├── README.md
├── LICENSE
└── .gitignore
```

---

# Dataset

The project consists of six relational tables.

| Table | Description |
|--------|-------------|
| Employees | Employee master information |
| Attendance | Daily attendance records |
| Departments | Department information |
| Leave Requests | Employee leave applications |
| Shifts | Employee shift allocation |
| Holidays | Company holiday calendar |

Project Statistics

- 500 Employees
- 180,000+ Attendance Records
- Multiple Departments
- Multiple Shift Types
- Multiple Leave Categories

---

# Python Implementation

Python was used to generate realistic HR datasets using synthetic data generation techniques.

The datasets were generated using:

- Pandas
- Faker
- Random module

Python scripts automatically created

- Employee Information
- Attendance Records
- Leave Requests
- Shift Allocation

The generated datasets were exported as CSV files and later imported into MySQL for analysis.

Python Scripts

- generate_employees.py
- generate_attendance.py
- generate_leave_requests.py
- generate_shifts.py

---

# SQL Implementation

After importing the datasets into MySQL, SQL was used to perform data analysis and business reporting.

Topics Covered

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Aggregate Functions
- CASE Statements
- INNER JOIN
- LEFT JOIN
- Multiple Table Joins
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Date Functions
- Business KPI Queries

SQL Files

- Basic SQL Queries
- Intermediate SQL Queries
- Advanced SQL Queries
- KPI Queries

---

# Power BI Implementation

The cleaned data was imported into Power BI where a relational data model was created.

Power BI features implemented include

- Relationship Modeling
- DAX Measures
- KPI Cards
- Interactive Slicers
- Cross Filtering
- Multi-page Report Design
- Professional Dashboard Layout

---

# Dashboard Pages

### Executive Summary

Provides an overall organizational overview including workforce KPIs and high-level attendance metrics.

### Attendance Analytics

Analyzes attendance patterns, daily trends, attendance status, and working hours.

### Department Analytics

Compares departmental performance, employee distribution, attendance, and salary insights.

### Employee Insights

Provides employee-level analysis including attendance history, leave records, department details, and shift allocation.

---

# Key Performance Indicators (KPIs)

- Total Employees
- Attendance Rate
- Present Days
- Absent Days
- Leave Days
- Average Working Hours
- Average Salary
- Highest Salary
- Lowest Salary
- Holiday Count
- Department Count
- Leave Approval Rate
- Pending Leave Requests
- Rejected Leave Requests
- Department-wise Attendance
- Shift Distribution

---

# Skills Demonstrated

- Data Cleaning
- Synthetic Data Generation
- Relational Database Design
- SQL Query Optimization
- Business KPI Development
- Data Modeling
- DAX
- Dashboard Design
- Data Visualization
- Business Intelligence
- HR Analytics

---

# Future Enhancements

- Live MySQL Database Connection
- Power BI Service Deployment
- Automated ETL Pipeline
- Attendance Forecasting
- Employee Performance Analytics
- HR Predictive Analytics

---

# Author

**Garbhit Maheshwari**

B.Tech Computer Science (AI & ML)

Aspiring Data Analyst

### Connect with me

- LinkedIn: *(Add your LinkedIn URL)*
- GitHub: *(Add your GitHub URL)*
