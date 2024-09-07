-- Exploratory Data Analaysis

SELECT 
    *
FROM
    layoffs_staging2;

SELECT 
    MAX(total_laid_off), MAX(percentage_laid_off)
FROM
    layoffs_staging2;

SELECT 
    *
FROM
    layoffs_staging2
WHERE
    percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


SELECT 
    company, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT 
    MIN(`date`), MAX(`date`)
FROM
    layoffs_staging2;-- it is the data of three years

SELECT 
    industry, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;-- in the pandemmic period consumer and retail industry has more laid off

SELECT 
    country, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;-- country laid off

SELECT 
    year(`date`), SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY year(`date`)
ORDER BY  1 DESC;-- country laid off 

SELECT 
    stage, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY stage
ORDER BY  2 DESC;-- country laid off 

-- Rolling total lay off according to year and month
with rolling as(
SELECT 
    MONTH(`date`) AS mon, year(`date`) as ye , SUM(total_laid_off) as total
FROM
    layoffs_staging2 where MONTH(`date`) is not null and year(`date`) is not null
GROUP BY mon , ye
ORDER BY ye,mon asc)
select ye,mon, sum(total) over(order by ye,mon) as rolling_total from rolling;
;

-- ranking of company total laid off top 3
with ranking(company, years, total_laid_off) as(
SELECT 
    company,year(`date`) ,SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY company,year(`date`)
),-- country laid off
company_year_rank as(-- we need another ctes because we canot use the dense rank in the same table, so it should be used by another.
select *, dense_rank() over(partition by years order by total_laid_off desc) as `rank` from ranking where years is not null)
select * from company_year_rank  where `rank`<=3;
;


