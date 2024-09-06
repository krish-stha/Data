-- Data Cleaning project

create database world_layoffs;

SELECT 
    *
FROM
    world_layoffs.layoffs;

-- step number 1- Remove the duplicates

CREATE TABLE layoffs_staging LIKE layoffs;

SELECT 
    *
FROM
    layoffs_staging;

insert layoffs_staging -- making duplicate table to know the raw data.
select * from layoffs;

-- row number


select *, 
row_number() over(
	partition by company,industry,total_laid_off,percentage_laid_off,`date`) as row_nnumber
from layoffs_staging;

-- Making a CTEs to know the duplicates

with duplicate_ctes as
(select *, 
row_number() over(
	partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging)
select * from duplicate_ctes where row_num> 1 ;


SELECT 
    *
FROM
    world_layoffs.layoffs_staging
WHERE
    company = 'Casper';

-- Deleting that duplicate (cannot be possible in this way)
with duplicate_ctes as
(select *, 
row_number() over(
	partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging)
delete from duplicate_ctes where row_num> 1 ;

-- Actual method to delete


create table layoffs_staging2(
 company text,
 location text,
 industry text,
 total_laid_off int default null,
 percentage_laid_off text,
 `date` text,
 stage text,
 country text,
 funds_raised_millions int default null,
 row_num int
 );
 
 insert into layoffs_staging2
 select *, 
row_number() over(
	partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging;


delete from layoffs_staging2 where row_num>1;
select * from layoffs_staging2 where row_num=1 ;

-- 1 Removing duplicates completed

-- 2 Standarized the data
-- 3 null or blank values
-- 4 Remove rows and column that is unnecessary


 
 
 




















