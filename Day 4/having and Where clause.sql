select gender, Avg(age)
from parks_and_recreation.employee_demographics
group by gender
having avg(age)>40;

select occupation,Avg(salary)
from parks_and_recreation.employee_salary 
where occupation like'%manager%'
group by occupation
having Avg(salary)>5000;

select * from parks_and_recreation.employee_demographics;

select gender, avg(age) from parks_and_recreation.employee_demographics
where first_name like 'a%'
group by gender having avg(age)>10;
