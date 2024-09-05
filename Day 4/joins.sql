-- Joins
select *
from employee_demographics;

select *
from employee_salary;

-- inner join
select ed.employee_id,ed.first_name,ed.age,es.salary
from employee_demographics ed
inner join employee_salary es
	ON ed.employee_id=es.employee_id;
;

-- outer join left and right
select ed.employee_id,ed.first_name,ed.age,es.salary
from employee_demographics ed
 right outer join employee_salary es
	ON ed.employee_id=es.employee_id;
;

-- self join

select es1.employee_id as es1_Santa,
es1.first_name as santa_name
,es1.last_name,
es2.employee_id as emp_id,
es2.first_name as emp_name
,es2.last_name
 from employee_salary es1
 join employee_salary es2
	ON es1.employee_id+1=es2.employee_id;
    
-- joining multiple table together like 3 table
select *
from employee_demographics ed
inner join employee_salary es
	ON ed.employee_id=es.employee_id
inner join parks_departments pd 
on es.dept_id=pd.department_id;
;

