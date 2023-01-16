
/*Try using LIMIT yourself below by writing a query that
 displays all the data in the occurred_at, account_id, and channel columns of the web_events table,
and limits the output to only the first 15 rows.*/

SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;
### ORDER BY
/*Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.*/
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at DESC
LIMIT 10;
/*Write a query to return the top 5 orders in terms of the largest total_amt_usd. Include the id, account_id, and total_amt_usd.*/
SELECT id,account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/*Write a query to return the lowest 20 orders in terms of the smallest total_amt_usd. Include the id, account_id, and total_amt_usd.*/

SELECT id,account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;
-- /*Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).*/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC
/*Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.*/
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5
/*Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.

*/
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10
/*Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.*/
SELECT id,
account_id,
standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;
/*Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also. NOTE - you will receive an error with the correct solution to this question. This occurs because at least one of the values in the data creates a division by zero in your formula. There are ways to better handle this. For now, you can just limit your calculations to the first 10 orders, as we did in question #1, and you'll avoid that set of data that causes the problem.*/
SELECT id,
account_id,
poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) *100 AS revenue_percent
FROM orders
LIMIT 10;
/*Use the accounts table to find

All the companies whose names start with 'C'.*/
SELECT name
FROM accounts
WHERE name LIKE 'C%';
/*All companies whose names contain the string 'one' somewhere in the name.*/
SELECT name
FROM accounts
WHERE name LIKE '%one%';
/*All companies whose names end with 's'.*/
SELECT name
FROM accounts
WHERE name LIKE '%s';
/*Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.*/
SELECT name,primary_poc,sales_rep_id
FROM accounts
WHERE name IN ('Walmart','Target','Nordstrom');
/*Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.*/
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');
/*Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.*/
SELECT name,primary_poc,sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart','Target','Nordstrom');
/*Use the accounts table to find:

All the companies whose names do not start with 'C'.*/
SELECT *
FROM accounts
WHERE name NOT LIKE ('C%');
/*Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.*/
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty =0;
/*Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.*/
SELECT *
FROM accounts
WHERE name NOT LIKE ('C%') AND name NOT LIKE ('%s')
/*When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the answer to this important question by writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.
*/
SELECT *
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29
/*endpoints were included*/
/*Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.*/
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000
/*Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.*/
SELECT *
FROM orders
WHERE (gloss_qty > 1000 OR poster_qty > 1000) AND standard_qty = 0
/*Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.*/
SELECT orders.standard_qty, orders.poster_qty,accounts.website,accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
/*Provide a table for all web_events associated with the account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.*/
SELECT w.occurred_at,a.name,a.primary_poc,w.channel
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
WHERE a.name = 'Walmart';
/*Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.*/
SELECT r.name region_name, s.name sales_rep_name,a.name account_name
FROM region r
JOIN sales_reps s
ON r.id =s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name
/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.*/

SELECT a.name account_name,r.name region_name,o.total_amt_usd/(total +0.01) unitprice
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id= a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
/*Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.*/
SELECT s.name salesrep_name, r.name region_name, a.name account_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name
/*Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.*/
SELECT s.name salesrep_name, r.name region_name, a.name account_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'AND s.name LIKE 'S%'
ORDER BY a.name
/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).*/
SELECT r.name region_name, a.name account_name,o.total_amt_usd/(total +0.01) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100
ORDER BY a.name
/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).*/
SELECT r.name region_name, a.name account_name,o.total_amt_usd/(total +0.01) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price
/*What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.*/
SELECT DISTINCT a.name,w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001'
/*Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.

*/
SELECT a.name,o.occurred_at,o.total,o.total_amt_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
/*Find the total amount of poster_qty paper ordered in the orders table.*/
SELECT SUM(poster_qty) poster_total
FROM orders
/*Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.*/
SELECT standard_amt_usd + gloss_amt_usd total

FROM orders
/*Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both aggregation and a mathematical operator.*/
SELECT SUM(standard_amt_usd)/ SUM(standard_qty +0.01) standard_per_unit
FROM orders
/*When was the earliest order ever placed? You only need to return the date.*/
SELECT MIN(occurred_at) earliest_date
FROM orders
-- /*When did the most recent (latest) web_event occur?*/
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC 
LIMIT 
/*Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.*/
SELECT AVG(poster_qty) avgposter,
		AVG(standard_qty) avstandard,
        AVG(gloss_qty) avggloss,
        AVG(poster_amt_usd) avgpsteramt,
        AVG(standard_amt_usd) avgstandardamt,
        AVG(gloss_amt_usd) avgglossamt
FROM orders
/*Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.*/
SELECT a.name, MIN(o.occurred_at)
FROM accounts a
JOIN orders o
ON a.id= o.account_id
GROUP BY a.name
LIMIT 1
/*Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.*/
SELECT a.name, SUM(total_amt_usd)
FROM accounts a
JOIN orders o
ON a.id= o.account_id
GROUP BY a.name
/*Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.*/
SELECT a.name, w.channel,MAX(w.occurred_at)
FROM accounts a
JOIN web_events w
ON a.id= w.account_id
GROUP BY a.name, w.channel
LIMIT 1
/*Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.*/
SELECT w.channel,COUNT(w.channel) channel_count
FROM web_events w
GROUP BY w.channel
/*Who was the primary contact associated with the earliest web_event?*/
SELECT a.primary_poc, MIN(w.occurred_at)
FROM web_events w
JOIN accounts a 
ON w.account_id = a.id
GROUP BY a.primary_poc
LIMIT 1
/*What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.*/
SELECT a.name, MIN(o.total_amt_usd)
FROM orders o
JOIN accounts a 
ON o.account_id = a.id
GROUP BY a.name, o.total_amt_usd
ORDER BY o.total_amt_usd
/*Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from the fewest reps to most reps.*/
SELECT r.name, COUNT(s.name)
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
/*Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.*/
SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;
/*Write a query to display for each order, the account ID, the total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.*/
SELECT account_id, total,
		CASE WHEN total >= 3000 THEN 'large'
        	  WHEN total < 3000 THEN  'small'	END AS level
FROM orders;
/*Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*/
SELECT table_3.rep_name, table_3.region_name, table_3.max_total
FROM(SELECT rep_name,region_name, MAX(max_total) max_total
FROM 
        (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) max_total
        FROM region r
        JOIN sales_reps s
        ON r.id = s.region_id 
        JOIN accounts a 
        ON s.id= a.sales_rep_id
        JOIN orders o
        ON a.id=o.account_id
        GROUP BY 1,2) table_1
GROUP BY 1,2) table_2
JOIN (SELECT s.name rep_name, r.name region_name, 						SUM(o.total_amt_usd) max_total
        FROM region r
        JOIN sales_reps s
        ON r.id = s.region_id 
        JOIN accounts a 
        ON s.id= a.sales_rep_id
        JOIN orders o
        ON a.id=o.account_id
        GROUP BY 1,2) table_3
ON table_3.region_name = table_2.region_name  AND table_3.max_total= table_2.max_total 
/*Now, modify your query from the previous quiz to include partitions. Still create a running total of standard_amt_usd (in the orders table) over order time, but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable.



Your final table should have three columns:

One with the amount being added for each row
One for the truncated date,
A final column with the running total within each year*/
SELECT standard_amt_usd,DATE_TRUNC('year',occurred_at),SUM(standard_amt_usd) OVER (PARTITION BY  DATE_TRUNC('year',occurred_at) ORDER BY occurred_at) AS running_total
FROM orders;
/*Select the id, account_id, and total variable from the orders table, then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. Your final table should have these four columns.

*/
SELECT id,
		account_id,
        total,
        ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders  
/*Now, create and use an alias to shorten the following query (which is different from the one in the Aggregates in Windows Functions video) that has multiple window functions. Name the alias account_year_window, which is more descriptive than main_window in the example above.*/
SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW  account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))                                                                            
/*In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist in the accounts table.*/
SELECT RIGHT(website,3) AS domain, COUNT(*) AS no_of_websites
FROM accounts
GROUP BY 1
ORDER BY 1;
/*From the accounts table, display the name of the client, the coordinate as concatenated (latitude, longitude), email id of the primary point of contact as <first letter of the primary_poc><last letter of the primary_poc>@<extracted name and domain from the website>.*/
SELECT CONCAT(long, '-',lat) coordinate, CONCAT(LEFT(primary_poc,1), RIGHT(primary_poc,1),'@',substr(website,5)) email
 FROM accounts  
 /*From the web_events table, display the concatenated value of account_id, '_' , channel, '_', count of web events of the particular channel.*/
 WITH table1 AS 
	(SELECT account_id, channel, COUNT(*) count_of_channel
 	FROM web_events
 	GROUP BY account_id,channel
 	ORDER BY account_id) 
 SELECT CONCAT(table1.account_id, '_',channel,'_',count_of_channel)
 FROM table1
 /*Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.

*/
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, 
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts;

/*Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.*/
SELECT LEFT(name, STRPOS(name, ' ') -1 ) first_name, 
    RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps;
/*Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.
You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise, your solution should be just as in question 1. Some helpful documentation is here.*/
SELECT TRIM( ' ' FROM CONCAT(LEFT(primary_poc, STRPOS(primary_poc,' ')-1),'.', RIGHT(name, LENGTH(primary_poc) - STRPOS(primary_poc,' ')),'@','.com'))
FROM accounts  
/*Use your query to return the email, first name, last name, and Genre of all Rock Music listeners (Rock & Roll would be considered a different category for this exercise). Return your list ordered alphabetically by email address starting with A.*/
WITH table1 AS 
(SELECT c.firstname AS first_name, c.lastname AS LAST_NAME, c.email AS e_mail, g.name AS genre_name, COUNT(g.name)
FROM customer c
JOIN invoice i
ON c.customerid = i.customerid
JOIN invoiceline il
ON i.invoiceid=il.invoiceid
JOIN track t
ON il.trackid = t.trackid  
JOIN genre g
ON g.genreid = t.genreid
WHERE g.name = 'Rock'
GROUP BY 1,2,3,4
ORDER BY email)
SELECT  first_name,LAST_NAME,e_mail, genre_name
FROM table1
ORDER BY 3
/*top 10 artist that sang the genre music of Rock*/
/*USING THE IVOICE TABLE TO DETERMINE THE COUNTRIES THAT HAVE THE MOST INVOICES  */
SELECT BillingCountry, count(*) TOTAL_INVOICES
FROM Invoice
GROUP BY 1
ORDER BY 2 DESC