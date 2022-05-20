
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);


CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);


CREATE TABLE title(
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE dept_manager(
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);


CREATE TABLE dept_emp( 
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL, 
	to_date DATE NOT NULL
);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM title;
SELECT * FROM salaries;
SELECT * FROM dept_emp;






SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31-;'

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- new table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

SELECT first_name, last_name, birth_date, emp_no
INTO table_1
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

SELECT title, from_date, to_date, emp_no
INTO table_2
FROM title;

SELECT * FROM table_1
SELECT * FROM table_2

SELECT table_1.emp_no, first_name, last_name, title, from_date, to_date
INTO retirement_titles
FROM table_1
FULL JOIN table_2
ON table_1.emp_no = table_2.emp_no
ORDER BY table_1.emp_no;

SELECT * FROM retirement_titles;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title, to_date
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles;

SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;

SELECT first_name, last_name, birth_date, emp_no
INTO table_3
FROM employees
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31');

SELECT from_date, to_date, emp_no
INTO table_4
FROM dept_emp
WHERE (to_date = '9999-01-01' AND to_date IS NOT NULL);

SELECT * FROM table_4;

SELECT DISTINCT ON (emp_no) title, emp_no
INTO table_5
FROM title

SELECT * FROM table_5;

SELECT table_3.emp_no, first_name, last_name, birth_date, from_date, to_date, title
INTO mentorship_eligibility
FROM table_3
FULL JOIN table_4
ON table_3.emp_no = table_4.emp_no
FULL JOIN table_5
ON table_3.emp_no = table_5.emp_no
ORDER BY table_3.emp_no;

DELETE FROM mentorship_eligibility WHERE to_date IS NULL;

SELECT * FROM mentorship_eligibility;