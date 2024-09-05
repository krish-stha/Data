-- where cluse practice

select *
from parks_and_recreation.employee_demographics
where first_name="Leslie"; 

select * 
from parks_and_recreation.employee_salary 
where first_name='Leslie';


select * 
from parks_and_recreation .employee_salary
where salary>=50000;

select *
from parks_and_recreation .employee_salary
where salary<40000;

select * 
from parks_and_recreation.employee_demographics
where gender !='Male';

select * 
from parks_and_recreation.employee_demographics
where birth_date>'1985-05-16' 
and Not gender='Male';

select * 
from parks_and_recreation.employee_demographics
where (first_name='Leslie' And age=44) or age>55;

-- Like statement
-- % and _
select * 
from parks_and_recreation.employee_demographics
where first_name Like '%e%';

select * 
from parks_and_recreation.employee_demographics
where first_name Like 'a___%';

select * 
from parks_and_recreation.employee_demographics
where  birth_date like '1989%';