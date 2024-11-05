-- drop conditions
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

-- creating tables
CREATE TABLE departments (
  dept_no character varying(10) NOT NULL,
  dept_name character varying(45) NOT NULL
);

CREATE TABLE dept_emp (
  emp_no integer NOT NULL,
  dept_no character varying(10) NOT NULL
);

CREATE TABLE dept_manager (
  dept_no character varying(10) NOT NULL,
  emp_no integer NOT NULL
);

CREATE TABLE employees (
    emp_no integer NOT NULL,
    emp_title_id character varying(10) NOT NULL,
	birth_date character varying(10) NOT NULL,
	first_name character varying(45) NOT NULL,
	last_name character varying(45) NOT NULL,
	sex character varying(5) NOT NULL,
	hire_date character varying(10) NOT NULL
);

CREATE TABLE salaries (
  emp_no integer NOT NULL,
  salary integer NOT NULL
);

CREATE TABLE titles (
  title_id character varying(10) NOT NULL,
  title character varying(45) NOT NULL
);


-- data analysis portion

-- 1) list the employee number, last name, first name, sex, salary.
SELECT employees.emp_no, last_name, first_name, sex, salary
FROM
	employees
	INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

-- 2) list the first name, last name, and hire date for emp hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986';

-- 3) list the manager of each dept along with their dept #, dept name, emp #, last name, first name
SELECT
	e.last_name,
	e.first_name,
	d.dept_name,
	d.dept_no
FROM employees AS e
INNER JOIN
	dept_manager AS m ON e.emp_no = m.emp_no
INNER JOIN 
	departments AS d ON d.dept_no = m.dept_no;

-- 4) list the dept # for each emp along with their emp #, last name, first name, dept name
SELECT
	de.dept_no,
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees AS e
INNER JOIN
	dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN
	departments AS d ON de.dept_no = d.dept_no;

-- 5) list first name, last name, sex of each emp whose first name is Hercules & last name begins with B
SELECT
	first_name,
	last_name,
	sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- 6) list each emp in Sales dept, emp #, last name, first name
SELECT
	e.emp_no,
	e.last_name,
	e.first_name
FROM employees AS e
	INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
	INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE
d.dept_name = 'Sales';

-- 7) list each emp in Sales & Development depts, emp #, last name, first name, dept name
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees AS e
	INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
	INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE
d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- 8) list the frequency counts, in descending order, of all the emp last names
SELECT last_name, COUNT(*) AS "Last Name Frequency Counts"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Frequency Counts" DESC;
