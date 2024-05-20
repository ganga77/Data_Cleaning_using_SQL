-- Where Clause
Select * from employee_demographics where birth_date > '1985-01-01';

Select * from employee_demographics where (first_name = 'Leslie') OR age > 55;

-- Like Clause (% = anything, _ = specific)
-- The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

Select * from employee_demographics where first_name LIKE 'Jer%';

select * from employee_demographics where last_name LIKE '_i%'