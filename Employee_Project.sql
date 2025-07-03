-- CREATE DATABASE
create database company;

-- USE DATABASE
use company;

-- CREATE TABLES
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(20)
);

CREATE TABLE managers (
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary INT,
    hire_date DATE,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES managers(manager_id)
);

--INSERT DATA INTO TABLES
INSERT INTO departments (department_id, department_name) VALUES
(10, 'HR','New York'),
(20, 'Finance','Dallas'),
(30, 'IT','Chicago'),
(40, 'Marketing','Boston');

INSERT INTO managers (manager_id, manager_name) VALUES
(201, 'Sarah Lee'),
(202, 'Tom Hanks'),
(203, 'Nina Patel');

INSERT INTO employees VALUES (101, 'John', 'Doe', 10, 60000, '2015-04-12', 201);
INSERT INTO employees VALUES (102, 'Jane', 'Smith', 20, 75000, '2016-07-19', 202);
INSERT INTO employees VALUES (103, 'Bob', 'Johnson', 10, 55000, '2018-03-24', 201);
INSERT INTO employees VALUES (104, 'Alice', 'Brown', 30, 82000, '2017-09-17', 203);
INSERT INTO employees VALUES (105, 'Mike', 'Davis', 20, 50000, '2019-01-10', 202);
INSERT INTO employees VALUES (106, 'Emma', 'Wilson', 10, 72000, '2020-11-05', 201);
INSERT INTO employees VALUES (107, 'Raj', 'Mehta', 40, 91000, '2014-02-20', NULL);


                                      -- QUERIES--
                                      
--List all employees in department 10.

select *from employees where department_id = 10;

--Find employees with salary greater than 60,000.

select *from employees where salary > 60000;

--Get details of employees hired after January 1, 2017.

select * from employees where hire_date > '2017-01-01';

--Find employees with the last name 'Smith'.

select *from employees where last_name = 'Smith';

--List employees in department 10 or 30.

select *from employees where department_id in (10,30);

--Find employees whose salary is between 60,000 and 80,000.
    
select *from employees where salary between 60000 AND 80000;

-- Get employees who are not in department 20.

select *from employees where department_id not in (20);

-- Find employees in HR with salary more than 60,000.

SELECT e.*, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'HR' AND e.salary > 60000;

-- List employees sorted by salary in descending order.

select * from employees order by salary desc;

-- Get the top 3 highest-paid employees.
select * from employees 
order by salary desc 
limit 3;

-- Retrieve the earliest hired employee.
select * from employees 
order by hire_date asc 
limit 1;

select *from employees
where hire_date =
(select min(hire_date) from employees);

-- Find employees whose first name starts with 'J'.
select *from employees where first_name like 'j%';

-- List employees who don’t have a manager.
select *from employees where manager_id IS NULL;

-- Show employees in HR or IT departments.
select e.*,d.department_name
from employees e
join departments d
on e.department_id = d.department_id
where department_name IN ('HR', 'IT');

-- Count employees in each department.
select department_id,count(employee_id) AS employee_count
FROM employees
group by department_id;
       
SELECT d.department_name, COUNT(*) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Find the average salary for each department.
select department_id,avg(salary)
from employees
group by department_id;

SELECT d.department_name,Avg(salary) 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Find the highest salary in each department.
select department_id,max(salary) As salary
from employees
group by department_id;

select d.department_name,max(salary) AS Salary
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name;

-- List employees with their department names.
Select e.employee_id,e.first_name,e.last_name,e.salary,d.department_name
from employees e
join departments d
on e.department_id = d.department_id;

-- Show employees with their manager's name.
Select e.employee_id,e.first_name,e.last_name,e.salary,m.manager_name
from employees e
join managers m
on e.manager_id = m.manager_id;

-- Display employees with department and manager names.
Select e.employee_id,e.first_name,e.last_name,e.salary,d.department_name,m.manager_name
from employees e
join departments d on e.department_id = d.department_id
join managers m on e.manager_id = m.manager_id;

-- Find departments with more than 2 employees.
select department_id,count(employee_id)
from employees e
group by department_id
having count(employee_id) > 2;

select d.department_name,count(employee_id)
from employees e
join departments d
on e.department_id = d.department_id
group by department_name
having count(employee_id) > 2;

-- Show departments with an average salary greater than 70,000.
select d.department_name,avg(salary)
from employees e
join departments d on d.department_id = e.department_id
group by department_name
having avg(salary) > 70000;


select department_id,avg(salary)
from employees
group by department_id
having avg(salary) > 70000;

-- List employees who earn more than the average salary.
select * from employees
where
salary > (select avg(salary) from employees);

-- Find the employee(s) with the maximum salary.
select * from employees
where salary = (
select max(salary) from employees);

--Find the employee with second highest salary
select employee_id,first_name,last_name,salary
from employees
where salary = (
select max(salary)
from employees where salary < (select max(salary) from employees));

select max(salary) from employees 
where salary < (select max(salary) from employees);

select * from employees
order by salary desc
limit 1
offset 1;

-- Find employees who earn more than the average salary.
select employee_id,first_name,last_name,salary
from employees
where salary > (select avg(salary) from employees);

-- Find employees who earn more than the average salary of their department.
SELECT e.employee_id, e.first_name, e.last_name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
  SELECT AVG(e2.salary)
  FROM employees e2
  WHERE e2.department_id = e.department_id
);

-- List the departments along with the number of employees and their average salary.
select department_id,count(employee_id),avg(salary)
from employees
group by department_id;

-- Display the names of employees along with their manager’s name.
select e.employee_id,e.first_name,e.last_name,e.salary,m.manager_name
from employees e
join managers m on e.manager_id = m.manager_id;


-- Find the department that has the highest average salary.
select d.department_name, AVG(e.salary) AS avg_salary
from employees e
join departments d ON e.department_id = d.department_id
group BY d.department_name
order BY avg_salary DESC
limit 1;


-- List employees who joined in the same year as Jane Smith.
SELECT *
FROM employees
WHERE YEAR(hire_date) = (
SELECT YEAR(hire_date)
FROM employees
WHERE first_name = 'Jane' AND last_name = 'Smith'
);

-- Find employees who do not share a department with any other employee.
SELECT *
FROM employees
WHERE department_id IN (
SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*) = 1);

-- Display departments that have more than 2 employees.
select d.department_name,count(e.employee_id)
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name
having count(e.employee_id) > 2;


-- Show departments where the average salary is above 70,000 and all employees have a manager.
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 70000
AND COUNT(*) = COUNT(manager_id);

-- Find employees who do not have a department assigned (if any).
SELECT *
FROM employees
WHERE department_id IS NULL;

-- List all employees along with their department name and manager name (NULLs if not available).
select e.employee_id,e.first_name,e.last_name,e.salary,d.department_name,m.manager_name
from employees e
join departments d on e.department_id = d.department_id
join managers m on e.manager_id = m.manager_id;

-- nth employee in each department
select department_id,count(employee_id) As Employee_Count
from employees
group by department_id;

-- Dispaly Alternate Records
select * from (select * ,
row_number() over (order by employee_id) AS row_count
from employees) AS temp where mod(row_count,2) = 0;

-- Dispaly Duplicate Of A column
select first_name,count(first_name) as name_count
from employees
group by first_name
having count(first_name) > 1;

-- Dispaly nth row (fetch 2nd row,fetch 4th row)
select * from (select * ,
row_number() over (order by employee_id) as row_count
from employees) temp where row_count = 2;

select * from (select * ,
row_number() over (order by employee_id) as row_count
from employees) temp where row_count in (2,4,7);

-- Inner join
select e.employee_id,e.first_name,e.last_name,e.department_id,e.salary,d.department_name,d.location
from employees e
inner join
departments d
on e.department_id = d.department_id;

-- Dispaly employee who are working in location chicago from emp and department table
select e.employee_id,e.first_name,e.last_name,e.department_id,e.salary,d.department_name,d.location
from employees e
inner join
departments d
on e.department_id = d.department_id
where d.location = "chicago";

-- Display the department name and total salaries from each department
select d.department_name,sum(salary)
from employees e
inner join
departments d
on e.department_id = d.department_id
group by d.department_name;

--Left Join
select e.employee_id,e.first_name,e.last_name,e.department_id,e.salary,d.department_name,d.location
from employees e
left join
departments d
on e.department_id = d.department_id and d.location = "chicago";

-- Right Join 
select e.employee_id,e.first_name,e.last_name,e.department_id,e.salary,d.department_name,d.location
from employees e
right join
departments d
on e.department_id = d.department_id and d.department_name = "finance";

-- Cross join
select e.employee_id,e.first_name,e.last_name,e.department_id,e.salary,d.department_name,d.location
from employees e
cross join
departments d;

-- Nth highest salary (3rd highest salary, 5th highest salary)
select * from (select * ,
row_number() over (order by salary desc) as sal_order
from employees) temp where sal_order = 3;

select * from (select distinct salary ,
row_number() over (order by salary desc) as sal_order
from employees) temp where sal_order = 3;

-- lowest salary of the table
select * from (select * ,
row_number() over (order by salary desc) as sal_order
from employees) temp where sal_order = (select count(salary) from employees);

-- highest salary of the table
select * from (select * ,
row_number() over (order by salary desc) as sal_order
from employees) temp where sal_order = 1;

-- Dispaly first and last row of the table
select * from (select * ,
row_number() over (order by employee_id) as employee_rank
from employees) temp where employee_rank = 1 or employee_rank = (select count(employee_id) from employees);

select * 
from (
    select *, 
           row_number() over (order by employee_id) as employee_rank,
           count(*) over () as total_employees
    from employees
) temp 
where employee_rank = 1 
   or employee_rank = total_employees;

select * from (select * ,
row_number() over (order by employee_id) as employee_rank
from employees) temp where employee_rank = 1 or employee_rank = (select count(employee_id) from employees);

-- Display Even Records
select * from (select * ,
row_number() over (order by employee_id) as employee_rank
from employees) temp where mod(employee_rank,2) = 0 ;

-- Display last two rows of the table
select * from (select * ,
row_number() over (order by employee_id) as employee_rank,
count(*) over () as total_employees
from employees) temp where employee_rank > total_employees-2;

-- Display first two  and last two rows of the table
select * from (select * ,
row_number() over (order by employee_id) as employee_rank,
count(*) over () as total_employees
from employees) temp where employee_rank > total_employees-2 or employee_rank in (1,2);

-- Query to find the cumulative sum of employee's salary
select * ,
sum(salary) over(order by employee_id) as cumulative_sum
from employees;

-- Query to find the cumulative sum of empoyee's salary departmentwise
select * ,
sum(salary) over(partition by department_id order by employee_id) as cumulative_sum
from employees;

-- Write a query to fetch 50% records from the employee table
select * from (select * ,
row_number() over(order by employee_id) as employee_rank
from employees) as temp where employee_rank <= (
    select count(employee_id) / 2 from employees
); 

-- Window Function(Aggregate)
select employee_id,salary,
sum(salary) over(order by employee_id) AS "Total",
avg(salary) over(order by employee_id) AS "Average",
count(salary) over(order by employee_id) AS "Count",
min(salary) over(order by employee_id) AS "Min",
max(salary) over(order by employee_id) AS "Max"
from employees;

-- Window Function(Ranking)
select employee_id,first_name,salary,
row_number() over (order by employee_id) AS "row_number",
rank() over (order by employee_id) AS "rank",
dense_rank() over (order by employee_id) "dense_rank",
percent_rank() over (order by employee_id) "percent_rank"
from employees;

-- window function
select employee_id,first_name,salary,
first_value(salary) over(order by salary) as "first_value",
last_value(salary) over(order by salary) as "last_value",
lead(salary) over(order by salary) as "lead",
lag(salary) over(order by salary) as "lag"
from employees;
