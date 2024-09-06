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
	partition by company,industry,total_laid_off,percentage_laid_off,`date`) as row_num
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

-- trim the white space present in the company and update it 
select distinct company,(trim(company)) from layoffs_staging2;

update layoffs_staging2 set company=trim(company);

select * from layoffs_staging2;

select distinct industry from layoffs_staging2 order by 1;-- we can find that there is same thing written in different language

select * from layoffs_staging2 where industry like 'Crypto%';

update layoffs_staging2 set industry ='Crypto'-- update all the crypto thing to crypto only
where industry like 'Crypto%';

-- now turn of location ( everything seem fine'

select distinct location from  layoffs_staging2 order by 1;

-- now country(there is issue in united states , thats why.)
update layoffs_staging2 set country ='United States' where country like 'United States%';
select distinct country from layoffs_staging2 order by 1;

-- another way to do so
select distinct country, trim( trailing '.' from country) from layoffs_staging2 order by 1;

-- changing the datat types text to date to the date column

select `date`, str_to_date(`date`,'%m/%d/%Y') as date_format
from layoffs_staging2;

update layoffs_staging2 set `date`=str_to_date(`date`,'%m/%d/%Y');

-- Now changing the actual data type

Alter table layoffs_staging2 
modify column `date` date;

select * from layoffs_staging2;

-- Completed doing standarization.

-- 3 null or blank values
select * from layoffs_staging2 where total_laid_off is Null and percentage_laid_off is null;-- '=' 'Like' doesnot work, so we have to use 'is'


select  * from layoffs_staging2 where industry is Null or industry='';


select * from layoffs_staging2 where company LIKE 'Bally%'; -- changing the blank to travel

-- implementing self join
SELECT 
    *
FROM
    layoffs_staging2 t1
        JOIN
    layoffs_staging2 t2 ON t1.company = t2.company
        AND t1.location = t2.location
WHERE
    (t1.industry IS NULL OR t1.industry = '')
        AND t2.industry IS NOT NULL;

update layoffs_staging2 t1 JOIN
    layoffs_staging2 t2 ON t1.company = t2.company
    set t1.industry=t2.industry where 
    (t1.industry IS NULL OR t1.industry = '')
        AND t2.industry IS NOT NULL; -- not working ,'IT WORKED AFTER CONVERTING TO BLANK TO NULL'
        
update layoffs_staging2 set industry=Null where industry='';

-- completed removing nulls
        
        
-- 4 Remove rows and column that is unnecessary

select * from layoffs_staging2 where total_laid_off is Null and percentage_laid_off is null;

-- deleting all the null value in both because that is completely useless, as the main point is all about the toal laid off and
-- percentage in the future for data analysis.
delete from layoffs_staging2 where total_laid_off is Null and percentage_laid_off is null;

select * from layoffs_staging2;

-- drop the table row_number as it is comple

alter table layoffs_staging2
drop column row_num;

-- COMPLETED DATA Cleaning - it is not the best but tried to do cleaning as much as possible.

 
 




















