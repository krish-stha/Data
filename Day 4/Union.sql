-- unions

select first_name,last_name from employee_demographics
union
select first_name,last_name from employee_salary;


select first_name,last_name,'old Man' as Label
 from employee_demographics 
 where  age>40 and gender='Male'
 union 
 select first_name,last_name,'old Lady'
 from employee_demographics 
 where  age>40 and gender='Female'
 union
 select first_name,last_name,'Highly Paid employee' 
 from employee_salary
 where  salary>70000

 union 
 select first_name,last_name ,'other occupartion' from employee_salary
 where occupation  like '%manager'
  order by first_name,last_name;
