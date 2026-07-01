-- Q1 Display all employee details.
SELECT * FROM employees;

-- Q2 Display only the following columns: FirstName LastName DepartmentID Salary
SELECT FirstName , LastName , DepartmentID, Salary FROM employees; 

-- Q3 Display all unique cities where employees live.
SELECT distinct city FROM employees; 

-- Q4 Find all employees whose salary is greater than ₹80,000.
SELECT * FROM employees
Where Salary>80000;

-- Q5 Display employees belonging to DepartmentID = 5 (IT).
SELECT * FROM employees
where DepartmentID = 5;

-- Q6 Find employees who joined after 1 January 2023.
SELECT * FROM employees
Where JoiningDate > '2023-01-01';

-- Q7 Display employees ordered by salary from highest to lowest.
SELECT * FROM employees
order by Salary DESC;

-- Q8 Display the top 10 highest-paid employees. 
SELECT * FROM employees
order by Salary DESC
LIMIT 10;

-- Q9 Count the total number of employees.
SELECT COUNT(EmployeeID) FROM employees;

-- Q10 Find the average salary of all employees.
SELECT AVG(Salary) FROM employees;

-- Q11 Find the highest salary.
SELECT MAX(Salary) FROM employees;

-- Q12 Find the lowest salary.
SELECT MIN(Salary) FROM employees;

-- Q13 Find the total salary paid by the company.
SELECT SUM(Salary) FROM employees;

-- Q14 Count employees in each department.
SELECT DepartmentID , COUNT(EmployeeID) as total_employees FROM employees
GROUP BY 1;

-- Q15 Find the average salary of every department.
SELECT DepartmentID , AVG(Salary) as average_salary FROM employees
GROUP BY 1;

-- Q16 Display departments having more than 70 employees.
SELECT DepartmentID , COUNT(EmployeeID) FROM employees
GROUP BY 1
HAVING COUNT(*) >70;

-- Q17 Count male and female employees.
SELECT Gender , COUNT(EmployeeID) as Total_employee FROM employees
GROUP BY 1;

-- Q18 Find employees living in Delhi.
SELECT * FROM employees
Where City = 'Delhi';

-- Q19 Display employees whose salary is between ₹50,000 and ₹80,000.
SELECT * FROM employees
WHERE Salary BETWEEN 50000 AND 80000;

-- Q20 Find employees whose first name starts with "A".
SELECT * FROM employees
Where FirstName LIKE 'A%';