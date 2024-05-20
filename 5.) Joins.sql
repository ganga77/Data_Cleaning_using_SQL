-- Joins 

-- Inner Join. They join 2 or more tables together having same column

Select * from employee_demographics;

Select * from employee_salary;

Select dem.employee_id, occupation, age from employee_demographics as dem
JOIN
employee_salary as sal
	ON dem.employee_id = sal.employee_id;


-- Left Join

Select * from employee_demographics as dem
LEFT JOIN
employee_salary as sal
	ON dem.employee_id = sal.employee_id;


-- Right Join

Select * from employee_demographics as dem
RIGHT JOIN
employee_salary as sal
	ON dem.employee_id = sal.employee_id;

-- Self Join

-- Multiple Joins

Select * from employee_demographics as dem
JOIN
employee_salary as sal
ON dem.employee_id = sal.employee_id
JOIN parks_departments as dept
ON sal.dept_id = dept.department_id
order by dem.age;



