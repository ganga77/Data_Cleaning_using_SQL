Select * from employee_demographics;

-- HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.

Select occupation, AVG(salary) from employee_salary group by occupation having AVG(salary) > 50000;