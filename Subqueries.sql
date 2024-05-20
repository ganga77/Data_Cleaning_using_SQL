Select * from 
employee_demographics
where employee_id IN (
	Select employee_id from employee_salary where dept_id = 1);


    
    
    