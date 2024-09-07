create database music;

-- importing all the csv file to the workbench

-- This above is used to calculate the age.
SELECT * FROM music.employee;

-- to calculate the age
SELECT birthdate,TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age
FROM employee;



select substring(birthdate,1,10),birthdate from employee;

update employee set birthdate=substring(birthdate,1,10);

select birthdate,str_to_date(birthdate,'%d-%m-%Y') from employee;

update employee set birthdate=str_to_date(birthdate,'%d-%m-%Y') ;

alter table employee
modify column birthdate date;

-- Question 1- Who is the senior most employee based on job title;

select * from employee order by levels desc limit 1;

--  Question 2 which country have the most invoices
SELECT 
    billing_country, COUNT(invoice_id) as Number_of_invoice
FROM
    music.invoice
GROUP BY billing_country
order by 2 desc
;

select * from invoice;

 -- Question 3 what are top 3 values of total invoice


select total from invoice order by total desc limit 3;

-- question 4- write a query that returns one city that has the highest invoice toal that returns both the city and sum of all the invoices

select billing_city,sum(total) as total from invoice group by billing_city order by total desc limit 1;

-- question 5- who is the best customer? A customer who spent the most money declared the best customer. write a query that returns the person

SELECT 
    c.first_name, c.last_name, SUM(i.total) as total 
FROM
    invoice i
        JOIN
    customer c ON i.customer_id = c.customer_id
GROUP BY c.first_name , c.last_name
ORDER BY 3 DESC limit 1; 

-- Question set 2

-- Q1- write query to return the email, first_name, last_name and genre of all rock music listeners. Return your list ordered alphabeticaally
-- by email starting with A

SELECT 
   distinct email, first_name, last_name
FROM
    customer c
        JOIN
    invoice i ON c.customer_id = i.customer_id
        JOIN
    invoice_line il ON i.invoice_id = il.invoice_id
        JOIN
    track t ON il.track_id = t.track_id
        JOIN
    genre g ON t.genre_id = g.genre_id
WHERE
    g.name like 'Rock%'
ORDER BY email; 

-- Q2- Lets invite the artists who have written the most rock music in our dataset. Write a query that returns the artist name and total track count
-- of the top 10 rock bands


SELECT 
    a.artist_id, a.name as artist_name,count(t.track_id) as number_of_track
FROM
    artist a
        JOIN
    album2 al ON a.artist_id = al.artist_id
        JOIN
    track t ON al.album_id = t.album_id
        JOIN
    genre g ON t.genre_id = g.genre_id where g.name like 'Rock%'
    group by a.artist_id,artist_name order by number_of_track desc limit 10;

-- Return all the track names that have a song length longer than the avergae song length. Return the Name and miliseconds fot each
-- track. ordeer by the song length with the longest songs listed first
with ctes as(

SELECT name,milliseconds, avg(milliseconds) over() as avg_song FROM music.track)

select name, milliseconds, avg_song from ctes where milliseconds > avg_song
ORDER BY milliseconds DESC;

-- Advance question
-- Question number 1
-- Find how much amount spent by each customer on artists? write a query to return customer name, artist name and total spent

SELECT 
    c.first_name AS Customer_name,
    ar.name AS artist_name,
    ROUND(SUM(il.quantity * il.unit_price), 2) AS total_spent
FROM
    customer c
        JOIN
    invoice i ON c.customer_id = i.customer_id
        JOIN
    invoice_line il ON i.invoice_id = il.invoice_id
        JOIN
    track t ON il.track_id = t.track_id
        JOIN
    album2 a ON t.album_id = a.album_id
        JOIN
    artist ar ON a.artist_id = ar.artist_id
GROUP BY c.first_name , ar.name
ORDER BY total_spent DESC;

-- Question 2

-- We want to find out the most popular music genre for each country. we determine the most popular genre
-- as the genre with the highest amount of purchases. Write a query that returns each country along with the top genre. For countries
-- where the maximum number of purchases is shared return all genre


with ctes (country, genre_name,number_of_quantity,genre_id, row_rank )as(
SELECT 
    c.country, g.name,count(il.quantity) as number_of_quantity,g.genre_id, row_number()over(partition by c.country order by count(il.quantity) desc) 
FROM customer c join
    invoice i on c. customer_id=i.customer_id
        JOIN 
    invoice_line il ON i.invoice_id = il.invoice_id
        JOIN
    track t ON il.track_id = t.track_id
        JOIN
    genre g ON t.genre_id = g.genre_id
     group by c.country, g.name,g.genre_id 
     order by c.country asc, 4 desc )
     select * from ctes where row_rank<=1;
     
     
SELECT 
   *
FROM customer c join
    invoice i on c. customer_id=i.customer_id
        JOIN 
    invoice_line il ON i.invoice_id = il.invoice_id
        JOIN
    track t ON il.track_id = t.track_id
        JOIN
    genre g ON t.genre_id = g.genre_id where i.billing_country like 'austria'
    ; -- to see whether argentina have 1 reord or  more
    
-- question number 3
--  write a query that determines the customer that has spent the most on music for each country. write a query that returns the country
-- along with the top customer and how much they spend. for countries where the top amount spend is shared ,provide all custommer who spend this

      
with ctes (customer_id,billing_country, spent_amount, row_rank )as
(
SELECT 
    c.customer_id,i.billing_country, sum(i.total) , row_number()over(partition by i.billing_country order by sum(i.total) desc) 
FROM customer c join
    invoice i on c. customer_id=i.customer_id
        JOIN 
    invoice_line il ON i.invoice_id = il.invoice_id
        JOIN
    track t ON il.track_id = t.track_id
        JOIN
    genre g ON t.genre_id = g.genre_id
     group by i.billing_country,c.customer_id
     order by  3 desc )
     select * from ctes where  row_rank<=1;
     

 