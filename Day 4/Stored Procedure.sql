Delimiter $$ -- now the delimiter is no longer semi-colon i.e ';'
create procedure large_salaries2() -- creating the procedure
Begin

-- we have to change the delimiter to proceed the two select operation
select * from employee_salary
where salary>=50000; -- it is really simple to do in stored procedure
select * from employee_salary
where salary>=10000;

end $$
Delimiter ;-- change it back to ';'

DELIMITER //


create procedure large_data()
Begin
-- we have to change the delimiter to proceed the two select operation
select * from employee_salary
where salary>=50000; -- it is really simple to do in stored procedure
select * from employee_salary
where salary>=10000;
end //
DELIMITER ;

call large_data();

-- parmater it accept an input values

DELIMITER //


create procedure large_data1(yoyo INT)-- this is the parameter 
Begin

select * from employee_salary
where employee_id=yoyo; -- if the employee id meets the parameter the retrieve that data when it is called

end //
DELIMITER ;

call large_data1(1);-- calling the data whose employee_id is 1.