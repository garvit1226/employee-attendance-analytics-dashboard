-- Q21 Display employee name along with department name.
SELECT e.FirstName , e.LastName , d.DepartmentName
FROM employees as e
JOIN departments as d
ON e.DepartmentID = d.DepartmentID;

-- Q22 Count employees in each department using JOIN.
SELECT d.DepartmentName , COUNT(e.EmployeeID) as Total_employee
FROM departments d
JOIN employees e
ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

-- Q23 Find the department with the highest number of employees.
SELECT * FROM
(SELECT d.DepartmentName , COUNT(e.EmployeeID) as total_employees
FROM departments d
JOIN employees e
ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID) 
AS dept_count
ORDER BY total_employees DESC
LIMIT 1;

-- Q24 Show every employee along with their shift.
SELECT e.FirstName , e.LastName , s.ShiftName
FROM employees e
JOIN shifts s
ON e.EmployeeID = s.EmployeeID;

-- Q25 Find how many employees are assigned to each shift.
SELECT s.ShiftName , COUNT(e.EmployeeID)
FROM shifts s
JOIN employees e
ON s.EmployeeID = e.EmployeeID
GROUP BY 1;

-- Q26 Count attendance records for each employee.
SELECT 
    e.EmployeeID, e.FirstName, e.LastName,
    COUNT(a.AttendanceID) AS TotalAttendance
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY e.EmployeeID;

-- Q27 Calculate attendance percentage for every employee.
SELECT e.EmployeeID, e.FirstName , e.Lastname,
ROUND((SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END)* 100) / COUNT(*), 2) AS Attendance
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2,3;

-- Q28 Find employees having attendance below 80%.
SELECT * FROM (
SELECT e.EmployeeID, e.FirstName , e.Lastname,
ROUND((SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END)* 100) / COUNT(*), 2) AS Attendance
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2,3
) AS emp_attendance
WHERE attendance <80;

-- Q29 Find employees who were absent more than 10 days.
SELECT * FROM (
SELECT 
e.EmployeeID , e.FirstName, e.LastName,
SUM(CASE WHEN a.Status = 'Absent' THEN 1 ELSE 0 END) as Absent_days
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2,3
) AS emp_record
WHERE Absent_days>10;

-- Q30 Find department-wise attendance percentage.
SELECT 
d.DepartmentName,
ROUND((SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END)*100)/ COUNT(*) , 2) AS Attendance
FROM departments d
JOIN employees e
ON d.DepartmentID = e.DepartmentID
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1;

-- Q31 Find total Present, Absent, WFH, Half Day, Leave, Holiday and Weekend records.
SELECT a.status , COUNT(e.EmployeeId) as Total_records
FROM attendance a
JOIN employees e
ON a.EmployeeID = e.EmployeeID
GROUP BY 1;

-- Q32 Find the busiest attendance month.
SELECT
    YEAR(AttendanceDate) AS Year,
    MONTHNAME(AttendanceDate) AS Month,
    COUNT(*) AS TotalAttendance
FROM attendance
GROUP BY YEAR(AttendanceDate), MONTHNAME(AttendanceDate)
ORDER BY TotalAttendance DESC
LIMIT 1;

-- Q33 Find employees who took the highest number of leaves.
SELECT *
FROM (
    SELECT
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        SUM(CASE WHEN a.Status = 'Leave' THEN 1 ELSE 0 END) AS Leaves
    FROM employees e
    JOIN attendance a
    ON e.EmployeeID = a.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
) AS emp_leaves
WHERE Leaves = (
    SELECT MAX(Leaves)
    FROM (
        SELECT
            SUM(CASE WHEN Status = 'Leave' THEN 1 ELSE 0 END) AS Leaves
        FROM attendance
        GROUP BY EmployeeID
    ) AS max_leaves
);

-- Q34 Find the average number of leave days taken by employees.
SELECT AVG(Leaves) FROM (
SELECT EmployeeID , SUM(CASE WHEN Status = 'Leave' THEN 1 ELSE 0 END) as Leaves
FROM attendance
GROUP BY 1
) AS emp_leaves;

-- Q35 Count Approved, Pending and Rejected leave requests.
SELECT 
ApprovalStatus , 
COUNT(EmployeeID) as Total
FROM leaverequests
GROUP BY 1;

-- Q36 Find employees who never applied for leave.
SELECT * FROM (
SELECT e.FirstName , e.LastName,
SUM(CASE WHEN a.Status = 'Leave' THEN 1 ELSE 0 END) AS Leaves
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2
) as emp_leaves
WHERE leaves = 0;

-- Q37 Calculate the average check-in time.
SELECT 
sec_to_time(Avg(time_to_sec(CheckIn))) as Average_time
FROM attendance;

-- Q38 Calculate average working hours for each employee.
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    SEC_TO_TIME(
        AVG(TIME_TO_SEC(a.CheckOut) - TIME_TO_SEC(a.CheckIn))
    ) AS AverageWorkingHours
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

-- Q39 Find employees who worked more than 9 hours on average.
SELECT * FROM 
(
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    SEC_TO_TIME(
        AVG(TIME_TO_SEC(a.CheckOut) - TIME_TO_SEC(a.CheckIn))
    ) AS AverageWorkingHours
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
) as emp 
WHERE AverageWorkingHours < '09:00:00';

-- Q40 Find employees who most frequently worked from home.
SELECT * FROM 
(
SELECT e.FirstName , e.LastName ,
SUM(CASE WHEN a.Status = 'WFH' THEN 1 ELSE 0 END) as WFH
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY e.EmployeeID
) as emp_wfh
where WFH = (
SELECT MAX(WFH_MAX)
FROM
(
SELECT SUM(CASE WHEN Status = 'WFH' THEN 1 ELSE 0 END) as WFH_MAX
FROM attendance 
Group by EmployeeID
) as detail
);