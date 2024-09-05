-- case Statement

select first_name,last_name,age,
case 
	when age<=30 then 'Young'
    when age between 31 and 50 then 'old'
    when age>=50 then "on the way to death"
    END as age_status
from employee_demographics;

-- pay increase
-- and bonus
-- <50000=5%
-- >50000=7%
-- finance=10%

select *,
case
 when salary<50000 then salary+((5*salary)/100)
when salary>50000 then salary+((7*salary)/100)
end as salary_increase,
case
when dept_id=6 then salary*0.1
end as bonus
from employee_salary;