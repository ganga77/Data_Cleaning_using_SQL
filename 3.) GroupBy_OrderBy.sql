SELECT * FROM Parks_and_Recreation.employee_demographics;
Select * from employee_salary;

Select age from Parks_and_Recreation.employee_demographics group by age; -- Here in GroupBy we can use aggregate functions or the same column name (eg, age) as used in this example

Select gender, AVG(age) from Parks_and_Recreation.employee_demographics group by gender;

select first_name, occupation, salary from employee_salary group by occupation, first_name, salary;

Select occupation, AVG(salary) from employee_salary group by occupation;


-- Order by (Sort by either asc or desc)

Select * from employee_demographics order by gender, age;