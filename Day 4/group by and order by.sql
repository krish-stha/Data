select * from parks_and_recreation.employee_demographics;

select gender from parks_and_recreation.employee_demographics group by gender;

select gender, Avg(age),Max(age),Min(age),count(age)
 from parks_and_recreation.employee_demographics 
 group by gender;
 
 select occupation,salary
 from parks_and_recreation.employee_salary
 group by occupation,salary;
 
 -- order by
 
 select * from parks_and_recreation.employee_demographics order by first_name
 DESC;
 
  select * from parks_and_recreation.employee_demographics order by gender,age desc;
  
  -- not a good practice to do so.
   select * from parks_and_recreation.employee_demographics order by 5,4 desc;
 


