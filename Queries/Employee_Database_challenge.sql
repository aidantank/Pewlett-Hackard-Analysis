-- Number of Retiring Employees
-- Create retirement_titles table to show titles of employees about to retire
SELECT e.emp_no, e.first_name, e.last_name,
		t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no) = (t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

-- Number of Employees by recent job who are about to retire
SELECT count(title), title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(title) DESC;

-- Create mentorship-eligibility table holding current employees born in 1965
SELECT DISTINCT ON(e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
		de.from_date, de.to_date,
		t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no) = (de.emp_no)
INNER JOIN titles as t
ON (e.emp_no) = (t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Sample Query 1. Mentorship-eligibility grouped by title
SELECT COUNT(title), title
FROM mentorship_eligibility
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Sample Query 2. Salaries for retiring employees
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name,
		s.salary
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, s.to_date DESC;
