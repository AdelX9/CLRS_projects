-- CLRS RB SQL: Assignment 1 
-- Q1106 ADEL

--Quesion 1
SELECT city, COUNT(customer_id) AS customer_count
FROM sale.customer
GROUP BY city
ORDER BY customer_count DESC;
--Question 2
SELECT order_id, SUM(quantity) as total_products
FROM sale.order_item
GROUP BY order_id;
--Question 3 
SELECT customer_id, MIN(order_date) as first_order
FROM sale.orders
GROUP BY customer_id;
--Question 4
SELECT order_id, SUM(quantity*list_price*(1-discount)) as total_value
FROM sale.order_item
GROUP BY (order_id)
ORDER BY total_value DESC;
--Question 5
SELECT TOP 1 order_id, AVG(list_price * (1 - discount)) AS av_price -- average price requires basic calculation
FROM sale.order_item
GROUP BY order_id
ORDER BY av_price DESC;
--Question 6
SELECT brand_id, product_id, list_price
FROM product.product
ORDER BY brand_id ASC, list_price DESC;
--Question 7
SELECT brand_id, product_id, list_price
FROM product.product
ORDER BY  list_price DESC, brand_id ASC;
--Question 8
--The results differ in the output. First 'order by' is fixed (prefectly displayed) while the second 'order by' is dependent on the first one.
--Question 9
SELECT TOP 10*
FROM product.product
WHERE list_price >=3000; -- where filters for the specific condition - quite elegant
--Question 10
SELECT TOP 5*
FROM product.product
WHERE list_price <3000;
--Question 11
SELECT last_name
FROM sale.customer
WHERE last_name LIKE 'B%s';
--Question 12
SELECT *
FROM sale.customer
WHERE city IN ('Allen', 'Buffalo', 'Boston', 'Berkeley') -- IN is like contains with WHERE