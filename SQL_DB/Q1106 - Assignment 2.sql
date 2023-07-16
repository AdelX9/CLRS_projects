--CLRS RB+SQL
--Assignment 2
--Q1106 ADEL
--1

SELECT c.customer_id, c.first_name, c.last_name
FROM sale.customer c
INNER JOIN sale.orders o ON c.customer_id = o.customer_id
INNER JOIN sale.order_item oi ON o.order_id = oi.order_id
INNER JOIN product.product p ON oi.product_id = p.product_id
WHERE p.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'; -- those who bought 

--Answer
  SELECT D.customer_id,D.first_name, D.last_name,
       CASE WHEN EXISTS (
           SELECT 1
           FROM sale.orders A
           INNER JOIN sale.order_item B ON A.order_id = B.order_id
           INNER JOIN product.product C ON B.product_id = C.product_id
           WHERE C.product_name = 'Polk Audio - 50 W Woofer - Black'
           AND A.customer_id = D.customer_id
           AND EXISTS (
               SELECT 1
               FROM sale.orders o2
               INNER JOIN sale.order_item oi2 ON o2.order_id = oi2.order_id
               INNER JOIN product.product p2 ON oi2.product_id = p2.product_id
               WHERE p2.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
               AND o2.customer_id = D.customer_id
           )
       ) THEN 'Yes'
       ELSE 'No'
       END AS other_product
FROM sale.customer D
INNER JOIN sale.orders o ON D.customer_id = o.customer_id
INNER JOIN sale.order_item oi ON o.order_id = oi.order_id
INNER JOIN product.product p ON oi.product_id = p.product_id
WHERE p.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD';

--2
--Create table
CREATE TABLE Actions (
  Visitor_ID INT,
  adv_Type VARCHAR(5),
  Action VARCHAR(10)
);
--Insert values
INSERT INTO Actions (Visitor_ID, adv_Type, Action)
VALUES
  (1, 'A', 'Left'),
  (2, 'A', 'Order'),
  (3, 'B', 'Left'),
  (4, 'A', 'Order'),
  (5, 'A', 'Review'),
  (6, 'A', 'Left'),
  (7, 'B', 'Left'),
  (8, 'B', 'Order'),
  (9, 'B', 'Review'),
  (10, 'A', 'Review');
--Count if order = order
SELECT adv_Type, COUNT(*) AS Total_Actions, SUM(CASE WHEN Action = 'Order' THEN 1 ELSE 0 END) AS Total_Orders
FROM Actions
GROUP BY adv_Type;
--covnersion rate
SELECT adv_Type, CAST(SUM(CASE WHEN Action = 'Order' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS Conversion_Rate
FROM Actions
GROUP BY adv_Type;