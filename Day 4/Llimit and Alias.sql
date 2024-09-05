-- Limit and Aliasing

-- Limit means how many rows you want to select.alter
select * from parks_and_recreation.employee_demographics
order by age desc limit 1,2;
-- To know the top 3 oldest people

-- Aliasing
-- it is just to rename the column name and it is also used in a join

select gender, Avg(age) As avg_age
 from parks_and_recreation.employee_demographics
group by gender having a>40;