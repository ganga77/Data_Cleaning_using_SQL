-- CTEs are useful to write code instead of subqueries 
WITH CTE_EXAMPLE AS
(
Select gender, MAX(salary) max_sal, AVG(salary) avg_sal, MIN(salary) min_sale from employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
group by gender
)
Select AVG(avg_sal) from CTE_EXAMPLE;

-- Without CTE
Select dem.employee_id, dem.first_name, gender, birth_date, salary from employee_demographics dem 
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
where sal.salary > 50000 AND
dem.birth_date > '1985-01-01';

-- Same above example with CTE

WITH CTE_EXAMPLE2 AS (
    SELECT employee_id, first_name, gender, birth_date
    FROM employee_demographics
    WHERE birth_date > '1985-01-01'
),
CTE_EXAMPLE3 AS (
    SELECT employee_id, salary
    FROM employee_salary
    WHERE salary > 50000
)

SELECT *
FROM CTE_EXAMPLE2
JOIN CTE_EXAMPLE3
ON CTE_EXAMPLE2.employee_id = CTE_EXAMPLE3.employee_id;
