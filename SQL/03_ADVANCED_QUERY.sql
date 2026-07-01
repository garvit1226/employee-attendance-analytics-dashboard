-- Q41 Rank employees by salary.
SELECT EmployeeID, FirstName, LastName, Salary,
RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM employees;

-- Q42 Find the Top 5 highest-paid employees using Window Functions.
SELECT * FROM (
SELECT EmployeeID, FirstName, LastName, Salary,
ROW_NUMBER() OVER (ORDER BY Salary DESC) as RN
FROM employees
) as emp
WHERE RN<=5;

-- Q43 Find the second-highest salary.
SELECT * FROM(
SELECT EmployeeID, FirstName,LastName, Salary,
DENSE_RANK() OVER (order by Salary DESC) as DR
FROM employees
) AS EMP
WHERE DR = 2;

-- Q44 Rank departments by average salary.
SELECT * , RANK() OVER (ORDER BY avg_salary DESC) as rk 
FROM(
SELECT d.DepartmentName , AVG(e.Salary) as avg_salary
FROM departments d
JOIN employees e
ON d.DepartmentID = e.DepartmentID
GROUP BY 1
) as emp;

-- Q45 Find the employee with the highest attendance percentage.
SELECT * 
FROM ( 
SELECT e.EmployeeID ,e.FirstName, e.LastName,
ROUND(SUM((CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END)*100)/COUNT(*),2) as attendance_pr,
 DENSE_RANK() OVER(ORDER BY ROUND(SUM((CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END)*100)/COUNT(*),2) DESC) as dr
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2,3
) as emp
WHERE dr = 1;

-- Q46 Find Top 10 employees having maximum Present days.
SELECT * FROM (
SELECT e.employeeID, e.FirstName, e.LastName, 
ROUND( SUM((CASE WHEN a.Status ='Present' THEN 1 ELSE 0 END)*100)/COUNT(*),2) as present,
RANK() OVER (ORDER BY ROUND( SUM((CASE WHEN a.Status ='Present' THEN 1 ELSE 0 END)*100)/COUNT(*),2) DESC) as dr
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2,3
) as emp
WHERE dr <=10;

-- Q47 Find Top 10 employees with the maximum WFH days.
SELECT * FROM (
SELECT e.employeeID, e.FirstName, e.LastName, 
SUM(CASE WHEN a.Status ='WFH' THEN 1 ELSE 0 END) as WFH,
RANK() OVER (ORDER BY SUM(CASE WHEN a.Status ='WFH' THEN 1 ELSE 0 END) DESC) as dr
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2,3
) as emp
WHERE dr <=10;

-- Q48 Find Top 10 employees having the most leave requests.
SELECT * FROM (
SELECT e.employeeID, e.FirstName, e.LastName, 
SUM(CASE WHEN a.Status ='Leave' THEN 1 ELSE 0 END) as Leaves,
RANK() OVER (ORDER BY SUM(CASE WHEN a.Status ='Leave' THEN 1 ELSE 0 END) DESC) as dr
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2,3
) as emp
WHERE dr <=10;

-- Q49 Find employees whose salary is greater than the company average.
SELECT EmployeeID, FirstName, LastName, Salary 
FROM employees
where Salary>(
SELECT AVG(Salary) FROM employees);

/* -- Q50 Create a View named: EmployeeAttendanceSummary 
Containing:
EmployeeID
Employee Name
Department
Present Days
Absent Days
Leave Days
Attendance % */
CREATE VIEW EmployeeAttendanceSummary AS
SELECT e.EmployeeID , CONCAT(e.FirstName , ' ', e.LastName ) as EmployeeName,
d.DepartmentName as Department,
SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) as PresentDays,
SUM(CASE WHEN a.Status = 'Absent' THEN 1 ELSE 0 END) as AbsentDays,
SUM(CASE WHEN a.Status = 'Leave' THEN 1 ELSE 0 END) as LeaveDays,
ROUND((SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2) AS AttendancePercentage
FROM departments d
JOIN employees e
ON d.DepartmentID = e.DepartmentID
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1;

SELECT * FROM employeeattendancesummary;

-- Q51 Find the previous attendance status of every employee.
SELECT EmployeeID, AttendanceDate , Status,
LAG(Status) OVER(partition by EmployeeID order by AttendanceDate) as PreviousAttendance
FROM attendance;

-- Q52 Find the next attendance status of every employee.
SELECT EmployeeID, AttendanceDate, Status,
LEAD(Status) OVER(partition by EmployeeID order by AttendanceDate) as NextAttendance
FROM attendance;

-- Q53 Find consecutive absent days for every employee.
SELECT * FROM(
SELECT EmployeeID, AttendanceDate, Status,
LAG(Status) Over(partition by EmployeeID order by AttendanceDate) as PrevAttendance
FROM attendance
) as emp
WHERE Status = PrevAttendance and Status = 'Absent';

-- Q54 Find monthly attendance percentage using a CTE.
WITH monthlyattendance as 
(
SELECT 
YEAR(AttendanceDate),
MONTHNAME(AttendanceDate),
ROUND(SUM((CASE WHEN Status = 'Present' THEN 1 ELSE 0 END)*100)/COUNT(*),2) as attendancePr
FROM attendance
group by 1,2
)
SELECT * FROM monthlyattendance;

-- Q55 Find employees whose attendance is above the department average.
WITH employeeattendance as(
SELECT e.EmployeeID, e.FirstName, e.LastName ,
e.DepartmentID, 
ROUND(SUM((CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END)*100)/COUNT(*),2) as attendancepr
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2,3,4
),
departmentAttendance as(
SELECT DepartmentID,
AVG(attendancepr) as deptattenpr
FROM employeeattendance
GROUP by 1
)
SELECT ea.EmployeeID, ea.FirstName, ea.LastName,
ea.attendancepr
FROM employeeattendance ea
JOIN departmentAttendance da
ON ea.DepartmentID = da.DepartmentID
WHERE ea.attendancepr>da.deptattenpr;

-- Q56 Find the department with the highest attendance percentage.
WITH departmentattend as(
SELECT d.DepartmentName ,
ROUND(SUM((CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END)*100)/COUNT(*),2) as attend
FROM departments d
JOIN employees e
ON d.DepartmentID = e.DepartmentID
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1
)
SELECT * FROM departmentattend
ORDER BY attend DESC
LIMIT 1;

-- Q57 Find the employee with the longest working hour.
SELECT e.EmployeeID , e.FirstName, e.LastName,
SEC_TO_TIME(MAX(TIME_TO_SEC(a.Checkout) - TIME_TO_SEC(a.CheckIn))) as working_hour
FROM employees e
JOIN attendance a
ON e.EmployeeID = a.EmployeeID
GROUP BY 1,2,3
ORDER BY working_hour DESC
LIMIT 1;

 