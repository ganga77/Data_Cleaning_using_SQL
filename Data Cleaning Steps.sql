Select * from layoffs.layoffs;

-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. Remove any colums (irrevalant)

Create table layoffs.layoffs_staging
LIKE layoffs.layoffs;

INSERT layoffs.layoffs_staging
select * from layoffs.layoffs;

-- With this query we can find if row_num > 1, then that data is duplicate
WITH duplicate_cte AS 
(
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
           ) as row_num
    FROM layoffs.layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Remove duplicates

CREATE TABLE layoffs.`layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs.layoffs_staging2
SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
           ) as row_num
    FROM layoffs.layoffs_staging;


DELETE FROM layoffs.layoffs_staging2
where row_num > 1;



Select * from layoffs.layoffs_staging2
where row_num > 1;

-- Standardizing data

Select * from layoffs.layoffs_staging2;

Update layoffs.layoffs_staging2
set company = TRIM(company);

Select industry from layoffs.layoffs_staging2
order by 1;

Select * from layoffs.layoffs_staging2
where industry LIKE 'Crypto%';

update layoffs.layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';


Select Distinct country 
from layoffs.layoffs_staging2
order by 1;

Select country , TRIM(TRAILING '.' FROM country) from layoffs.layoffs_staging2 order by 1;


update layoffs.layoffs_staging2
set country = TRIM(TRAILING '.' FROM country);


update  layoffs.layoffs_staging2
set `date`  = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER table layoffs.layoffs_staging2
MODIFY COLUMN `date` Date;

-- Null Values

Select * from 
layoffs.layoffs_staging2
where industry IS NULL;

UPDATE layoffs.layoffs_staging2
set industry = null
where industry = '';

Select *
from layoffs.layoffs_staging2 t2
JOIN layoffs.layoffs t1
On t1.company = t2.company
where (t1.industry IS NOT NULL)
and 
t2.industry IS NULL;

Update layoffs.layoffs_staging2 t2
JOIN layoffs.layoffs_staging t1
On t1.company = t2.company
set t2.industry = t1.industry
where (t2.industry is NULL)
and 
t1.industry IS NOT NULL;


Select * 
from layoffs.layoffs_staging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
from layoffs.layoffs_staging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL;


Select * from layoffs.layoffs_staging2;

-- Data Analysis

Select YEAR(`date`), SUM(total_laid_off)
from layoffs.layoffs_staging2
group by YEAR(`date`)
order by 1;

Select SUBSTR(`date`,1, 7) as `MONTH`, SUM(total_laid_off) as total_off
from layoffs.layoffs_staging2
where  SUBSTR(`date`,1, 7) IS NOT NULL
GROUP BY `MONTH`
order by 1;

-- Total layoffs by month and totalling them 
WITH Rolling_total AS(
Select SUBSTR(`date`,1, 7) as `MONTH`, SUM(total_laid_off) as total_off
from layoffs.layoffs_staging2
where  SUBSTR(`date`,1, 7) IS NOT NULL
GROUP BY `MONTH`
order by 1
)
Select `MONTH`, total_off, SUM(total_off) OVER(ORDER BY `MONTH`)
from Rolling_total
GROUP BY `MONTH`;



-- Ranking which company fired most employees according to years
WITH Highest_laid AS (
Select company, YEAR(`date`) as `DATE`, SUM(total_laid_off) as total_laid
from layoffs.layoffs_staging2
GROUP BY company, YEAR(`date`)
order by 3 DESC
)
Select company, `DATE`, total_laid,
DENSE_RANK() OVER(PARTITION BY `DATE` ORDER BY total_laid DESC) as Ranking_Companies_Firing_MOST
from Highest_laid;











