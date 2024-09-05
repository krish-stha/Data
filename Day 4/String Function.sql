-- string function

-- length
select length('skyfall');

select first_name,length(first_name) from employee_demographics order by first_name ;

-- Upper
select upper('skyfall');

select first_name,upper(first_name) from employee_demographics order by first_name ;

-- Lower
select lower('skyfall');

select first_name,lower(first_name) from employee_demographics order by first_name ;

-- trim

select rtrim('                sky                   ');

-- Left and right function
select first_name, left(first_name,4), right(first_name,4)
from employee_demographics;

-- Substring

select first_name, substring(first_name,3,2) , birth_date ,
substring(birth_date,6,2) as birth_month from employee_demographics;

-- Replace

select first_name, replace(first_name,'a','z') from employee_demographics;

-- locate
select locate('x','Alexander');

select first_name, locate ('An',first_name) from employee_demographics;

-- concat

select first_name, last_name, concat(first_name,' ',last_name) from employee_demographics;