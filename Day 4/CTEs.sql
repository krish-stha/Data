-- CTEs- common Table Expression- Professional way to write and it is clear

with CTE(gender,avg_salary,avg_age,max_age,min_AGE,COUNT_AGE) as -- it overwrite the under name given below
(
select gender,avg(salary) avg_salary ,avg(age) as avg_age,max(age) as max_age,min(age) as min_age,count(age) -- to know the average of the result
 from employee_demographics dem
 join employee_salary sal
 on dem.employee_id=sal.employee_id
group by gender) 
select * from CTE
;

with CTE_Example as
(
select employee_id,gender,birth_date
from employee_demographics 
where birth_date>'1985-01-01'
),
CTE_Example2 as
(
select employee_id,salary from employee_salary
where salary>50000)

select *
from CTE_Example
join CTE_Example2
on CTE_Example.employee_id=CTE_Example2.employee_id
;