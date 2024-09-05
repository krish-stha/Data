-- Window function

select gender,avg(salary) as avg_salary
 from employee_demographics ed
 join
 employee_salary es
 on ed.employee_id=es.employee_id
 group by
 gender;
 
 -- average salary by gender indepenedently
 select  gender,ed.first_name,salary,avg(salary) over(partition by gender) -- it is completely independent.
 from employee_demographics ed
 join
 employee_salary es
 on ed.employee_id=es.employee_id
;

-- Rolling total
 select  gender,ed.first_name,salary,sum(salary) over(partition by gender order by ed.employee_id) as Rolling_Total 
 from employee_demographics ed
 join
 employee_salary es
 on ed.employee_id=es.employee_id
;

-- Row number
select  gender,ed.first_name,salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num, -- gives next number positionally and works on group by, not duplicate
dense_rank() over(partition by gender order by salary desc) as dense_num-- gives next number numericly and works on group by, not duplicate
 from employee_demographics ed
 join
 employee_salary es
 on ed.employee_id=es.employee_id
;


