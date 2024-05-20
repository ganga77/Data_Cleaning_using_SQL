Select dem.first_name, dem.last_name, dem.gender, AVG(salary) OVER(PARTITION BY gender)
from employee_demographics dem
JOIN employee_salary sal
on dem.employee_id = sal.employee_id;



Select dem.first_name, dem.last_name, dem.gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) as row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as dense_rank_num
from layoffs.employee_demographics dem
JOIN layoffs.employee_salary sal
on dem.employee_id = sal.employee_id;
