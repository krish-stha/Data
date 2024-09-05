-- Trigger , automaticallly update when any evennts occurred

Delimiter //

-- the concept is that if we add any data in employe salary table then the first name , last name and employee_id should automatically
--  in the employee_demographic table
create trigger employee_insert -- name of trigger
	after insert on employee_salary -- after insertion in the employee salary table
    for each row -- all the row should be recorded in the employee_demographic table
Begin
	insert into employee_demographics( employee_id,first_name,last_name) 
    Values (New.employee_id,new.first_name,new.last_name);
    
End //
Delimiter ;

insert into employee_salary(employee_id,first_name,last_name,occupation,salary,dept_id)
Values(13,'ghost','leyeay','Entertainment',1000000,Null);-- the record is added in demographic table too


select * from employee_salary;
select * from employee_demographics; 


-- Events - it takes place when its schedules
-- if age is over 60 they are retired and removed from the events
select * from employee_demographics;

Delimiter //

create event delete_over_60_year_old
on schedule every 30 second -- checks every 30 seconds
Do 
Begin
	Delete from employee_demographics
    where age>=60;
    
End //

delimiter ;

show variables like 'event%';