-- Union combines rows of data from seperate tables (Union is by default Distinct)

Select first_name, last_name
from employee_demographics
Union 
Select first_name, last_name
from employee_salary;

-- Union all

Select first_name, last_name
from employee_demographics
Union All
Select first_name, last_name
from employee_salary;


Select first_name, last_name, 'Old Man' as label
from employee_demographics
where age > 40 and gender = 'Male'
Union 
Select first_name, last_name, 'Old Lady' as label
from employee_demographics
where age > 40 and gender = 'Female'
Union
Select first_name, last_name, 'Highly Paid' as label
from employee_salary
where salary > 70000
order by first_name, last_name;