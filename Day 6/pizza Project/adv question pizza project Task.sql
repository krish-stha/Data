create database pizzahut;

-- Beginner Questions
-- 1 Retrieve the total  number of orders placed.

SELECT 
    COUNT(*) AS total_orders
FROM
    pizzahut.order;

-- 2 Calculate the total revenue generated from pizza sales

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS Total_Revenue
FROM
    pizzahut.order_details od
        JOIN
    pizzahut.pizzas p ON od.pizza_id = p.pizza_id;

-- 3 Identify the highest price pizza

SELECT 
    pt.name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name , p.price
ORDER BY p.price DESC limit 1;

-- 4 Identify the most common pizza size order

SELECT 
    p.size, COUNT(od.order_details_id) AS number_of_Orders
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.size order by number_of_Orders desc;


-- 5 List the top 5 most ordered pizza types along with their quantities

SELECT 
    pt.name, SUM(od.quantity) AS number_of_quantity
FROM
    pizza_types pt
        INNER JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY number_of_quantity DESC
LIMIT 5;

-- Intermediate question

-- 1 Join the necesssary tables to find the total quantity of each pizza Category
SELECT 
    pt.category, SUM(od.quantity) AS number_of_quantity
FROM
    pizza_types pt
        INNER JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY number_of_quantity DESC
LIMIT 5;

-- 2 Determine the distribution of orders by hour of the day
SELECT 
    SUBSTRING(o.order_time, 1, 2) AS hour,
    SUM(quantity) AS quantity
FROM
    pizzahut.order o
        JOIN
    order_details od ON o.order_id = od.order_id
GROUP BY hour
ORDER BY hour DESC;

-- 3 join relevant tables to find the category wise distribution of pizzas
SELECT category, count(name) FROM pizzahut.pizza_types group by  category ; -- without joining the table

-- 4 Group the orders by date and calculate the average numbers of pizzas ordered per day.
SELECT 
    order_date, AVG(sum_quantity)
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS sum_quantity
    FROM
        pizzahut.order o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY order_date) as other_quantity
    group by order_date
 ;
 
 -- 5 Dettermine the top 3 most ordered pizza type based on revenue
 SELECT 
    pt.name,round(sum(p.price*od.quantity),0) as revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
    join order_details od
    on p.pizza_id=od.pizza_id
    group by pt.name order by revenue desc limit 3
    ;
    
-- Advance Question

-- 1 Calculate the percentage contribution of each type to total revenue

WITH percentage_pizza AS (
    SELECT 
        pt.category,
        ROUND(SUM(p.price * od.quantity), 0) AS revenue
    FROM
        pizza_types pt
    JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON p.pizza_id = od.pizza_id
    GROUP BY pt.category
    ORDER BY revenue DESC
)

SELECT 
    category, 
    round(revenue) as Revenue -- grouped according to category
    ,round((revenue / SUM(revenue) OVER() * 100),2) AS Percentage_Of_Revenue-- over() perfoemed operation with each row
    FROM 
    percentage_pizza;
    
-- Analyze the cumulative revenue generated over time
with cumulative as
(
SELECT 
    o.order_date as order_date,
    sum(od.quantity*p.price) as Revenue
    
FROM
    pizzahut.order o
        JOIN
    order_details od ON o.order_id = od.order_id
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
    group by order_date)
    
    select order_date, sum(Revenue) over(order by order_date) from cumulative ;
    
-- Determine the top 3 most ordered pizza types based on revenue for each pizza category

with revenue_with_category as (
SELECT 
    pt.category ,pt.name, SUM(p.price * od.quantity) AS Revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category,pt.name),
b as
(select category, name, Revenue,Rank() over(partition by category order by Revenue desc ) as `rank` from revenue_with_category)
select name,category,Revenue from b where `rank`<=3;

-- practice again 

with category_rank as(
SELECT 
    pt.name as name,
    pt.category as category,
    sum(p.price* od.quantity) as Revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
    group by pt.name,category),
    b as(
select name, category,Revenue, Rank() over(partition by category order by Revenue desc) as `rank` from category_rank)
select name, category, `rank` from b where `rank`<=3 ;











