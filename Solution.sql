
/*Q1: Who is the senior most employee based on job title?*/

--select top 1 first_name,last_name,* from employee order by levels desc

/*Q2: Which countries have the most Invoices?*/

--select billing_country,count(Invoice_Id) as [No of invoice] from invoice group by billing_country order by [No of invoice] desc

--Q3: What are top 3 values of total invoice?

--select top 3 * from invoice order by total desc

/*Q4: Which city has the best customers? We would like to throw a promotional 
Music Festival in the city we made the most money. Write a query that returns one city 
that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals*/

--select top 30 city,* from customer a 
--select billing_city,sum(total) as total  from invoice group by billing_city order by total desc


/*Question 5: Who is the best customer? The customer who has spent the most money will be declared the best customer.
Write a query that returns the person who has spent the most money.*/


--select c.customer_id as ID, c.first_name as [Name],
--sum(total) as Total from customer c 
--left join invoice i on c.customer_id = i.customer_id
--group by c.customer_id,c.first_name order by total desc


/*Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A*/

--select distinct first_name,last_name,email, g.name  from customer c
--left join invoice i on c.customer_id = i.customer_id
--left join invoice_line il on i.invoice_id = il.invoice_id
--left join track t on il.track_id = t.track_id
--left join genre g on g.genre_id = t.genre_id where g.name like '%Rock%' order by c.email 


/*Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands*/

--select top 10 a.name, count(a.artist_id) as Track_ID from Artist a
--left join Album al on a.artist_id = al.artist_id
--left join track t on t.album_id = al.album_id 
--left join genre g on g.genre_id = t.genre_id
--where g.name  like 'Rock' group by a.name order by Track_ID desc

/*Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first*/

--select name,milliseconds  from track where (
--select avg(Milliseconds) as [Avg] from track ) < milliseconds order by milliseconds desc


/*Q1: Find how much amount spent by each customer on artists? 
Write a query to return customer name, artist name and total spent*/



--select  e.name as Nam,sum(b.quantity*b.unit_price) as [qty] from invoice a
--left join invoice_line b on a.invoice_id  =b.invoice_id
--left join track c on c.track_id =b.track_id
--left join Album d on d.album_id = c.album_id
--left join artist e on e.artist_id = d.artist_id
--group by e.name order by qty desc


/*Q2: We want to find out the most popular music Genre for each country. 
We determine the most popular genre as the genre with the highest amount of purchases.
Write a query that returns each country along with the top Genre. For countries 
where the maximum number of purchases is shared return all Genres.
Steps to Solve:  There are two parts in question- first most popular music genre 
and second need data at country level. */



--with cte as (SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
--	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
--    FROM invoice_line 
--	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
--	JOIN customer ON customer.customer_id = invoice.customer_id
--	JOIN track ON track.track_id = invoice_line.track_id
--	JOIN genre ON genre.genre_id = track.genre_id
--	GROUP BY  customer.country, genre.name, genre.genre_id)

--	select * from cte where RowNo<=1 order by purchases desc





--with cte as (
--select sum(total) as total,first_name as [name],last_name,billing_country,
--ROW_NUMBER() over (Partition by billing_country order by sum(total) desc) as row_num from customer c
--left join invoice i on c.customer_id = i.customer_id group by first_name,last_name,billing_country)

--select * from cte where row_num<=1 order by billing_country 








