# 🏢 Employee SQL Project

This project represents a mini employee management system using SQL. It demonstrates how to create and manage employee, department, and manager data, as well as how to perform a wide range of SQL queries including filtering, aggregation, joins, and advanced window functions.

---

## 📂 Contents

- `CREATE DATABASE` and `USE` statements
- `CREATE TABLE` statements for:
  - `departments`
  - `managers`
  - `employees`
- `INSERT INTO` statements with sample data
- A rich collection of SQL queries for:
  - Filtering and searching
  - Aggregations
  - Subqueries
  - JOINs (Inner, Left, Right, Cross)
  - Window functions (`ROW_NUMBER()`)
  - Ranking (e.g., nth highest salary)
  - Data analysis tasks

---

## 🛠 Schema Overview

### `departments`
| Column         | Type         |
|----------------|--------------|
| department_id  | INT (PK)     |
| department_name| VARCHAR(50)  |
| location       | VARCHAR(20)  |

### `managers`
| Column      | Type         |
|-------------|--------------|
| manager_id  | INT (PK)     |
| manager_name| VARCHAR(50)  |

### `employees`
| Column        | Type         |
|---------------|--------------|
| employee_id   | INT (PK)     |
| first_name    | VARCHAR(50)  |
| last_name     | VARCHAR(50)  |
| department_id | INT (FK)     |
| salary        | INT          |
| hire_date     | DATE         |
| manager_id    | INT (FK)     |

---

## 📊 Sample Queries Included

### 🔎 Basic Queries
- Employees in a specific department
- Employees with salary above a threshold
- Employees hired after a specific date
- Employees without a manager

### 🧮 Aggregate Queries
- Average, Maximum, and Minimum salary by department
- Employee count by department
- Departments with more than 2 employees

### 🔁 Joins
- Employees with their department and manager names
- Employees working in a specific location (e.g., Chicago)

### 🎯 Advanced SQL
- Top N salaried employees
- Nth highest salary (using `ROW_NUMBER()`)
- Employees who earn more than department average
- Employees who joined in the same year as a specific employee
- Alternate/even records using `MOD` and `ROW_NUMBER()`
- First and last rows using `ROW_NUMBER()`
- Departments with only one employee
- Employees without department

---

## 🚀 Getting Started

1. Open your SQL client (e.g., MySQL Workbench, pgAdmin, SQL Server Management Studio).
2. Run the full script from `Employee_Project.sql`.
3. Explore and run queries as needed.

---

## ✅ Requirements

- Any SQL-compatible RDBMS (MySQL, PostgreSQL, SQL Server, etc.)
- Basic SQL knowledge

---
