-- String Functions
Select first_name, SUBSTR(birth_date, 6,2) as birth_month from employee_demographics;

Select first_name, last_name, CONCAT(first_name, ' ', last_name) as full_name from employee_demographics;

Select * from employee_demographics;
Select * from employee_salary;

-- IN 
Select * from employee_demographics where first_name in (Select first_name from employee_salary)

-- CASE

Select first_name, last_name, salary 
CASE
	WHEN salary < 50000 THEN salary * 1.05
END AS NEW_SALARY
from employee_salary;    

Select first_name, last_name, salary ,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
    
END AS NEW_SALARY,
CASE
	WHEN dept_id = 6 THEN salary * .10
END as Bonus    
from employee_salary;

