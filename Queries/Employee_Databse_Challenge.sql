-- Create Retirement Titles Table
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	ti.title, 
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

DROP TABLE if exists retiring_titles

SELECT COUNT(ut.title), title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title 
ORDER BY count DESC;

SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT COUNT(me.title), title
INTO mentorship_titles
FROM mentorship_eligibility as me
GROUP BY me.title 
ORDER BY count DESC;

DROP TABLE if exists promotion_eligibility

SELECT COUNT(ti.title), title
INTO promotion_eligibility
FROM titles as ti
INNER JOIN employees as e
ON ti.emp_no = e.emp_no
WHERE (hire_date BETWEEN '1987-01-01' AND '2000-12-31')
	AND ti.to_date = ('9999-01-01')
GROUP BY ti.title
ORDER BY count DESC;