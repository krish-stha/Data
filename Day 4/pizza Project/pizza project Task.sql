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

-- 1