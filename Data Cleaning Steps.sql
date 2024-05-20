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
