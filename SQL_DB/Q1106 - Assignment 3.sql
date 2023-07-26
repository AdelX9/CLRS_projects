--RB+SQL 
--Assignment 3
--Q1106 ADEL

-- 1 check what we have and merge tables
SELECT DISTINCT P.product_id
FROM  product.product P
INNER JOIN sale.order_item oi ON oi.product_id=p.product_id
INNER JOIN sale.orders O ON O.order_id=oi.order_id
ORDER BY P.product_id
--307 active product_ids

-- 2 perhaps using order_item would suffice
SELECT product_id, discount, SUM (quantity) AS total_qnt
FROM sale.order_item
GROUP BY product_id, discount
ORDER BY product_id

-- 3 Instead of using chronological discount change, for this case only max and min values will be used (for the sake of mental well-being)
SELECT DISTINCT product_id,
	FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY total_qty DESC , discount DESC) discount_rate_max_sale, --
	FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY total_qty DESC, discount DESC) max_qty,
	FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY total_qty ASC, discount ASC) discount_rate_min_sale,
	FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY total_qty ASC, discount ASC) min_qty,
	FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY total_qty DESC , discount DESC) - FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY total_qty ASC, discount ASC) discount_diff,
	CASE
		WHEN FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY total_qty DESC , discount DESC) - FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY total_qty ASC, discount ASC) > 0 THEN 'Positive'
		WHEN FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY total_qty DESC , discount DESC) - FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY total_qty ASC, discount ASC) < 0 THEN 'Negative'
		ELSE 'Neutral'
		END AS discount_effect
FROM(
	SELECT product_id, discount, SUM(quantity) total_qty,
		COUNT(discount) OVER (PARTITION BY product_id) num_of_discount_rates
	FROM sale.order_item
	GROUP BY product_id, discount
	) subq
	WHERE num_of_discount_rates > 1 -- where the are at least 2 values to compare
		
--4 FINAL_SOLUTION
-- use quantity instead of discount
SELECT product_id, discount_effect
FROM (
SELECT DISTINCT product_id,
	FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY discount DESC) AS max_discount, --
	FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount DESC) max_qty,
	FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY discount ASC) min_discount,
	FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount ASC) min_qty,
	FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount DESC) - FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount ASC) qnt_diff,
	CASE
		WHEN FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount DESC) - FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount ASC) > 0 THEN 'Positive'
		WHEN FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount DESC) - FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount ASC) < 0 THEN 'Negative'
		ELSE 'Neutral'
		END AS discount_effect
FROM(
	SELECT product_id, discount, SUM(quantity) total_qty
	FROM sale.order_item
	GROUP BY product_id, discount
	) subq -- double checked with subquery
) a;

--check  
SELECT DISTINCT product_id,
	FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY discount DESC) AS max_discount, --
	FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount DESC) max_qty,
	FIRST_VALUE(discount) OVER (PARTITION BY product_id ORDER BY discount ASC) min_discount,
	FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount ASC) min_qty,
	FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount DESC) - FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount ASC) qnt_diff,
	CASE
		WHEN FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount DESC) - FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount ASC) > 0 THEN 'Positive'
		WHEN FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount DESC) - FIRST_VALUE(total_qty) OVER (PARTITION BY product_id ORDER BY discount ASC) < 0 THEN 'Negative'
		ELSE 'Neutral'
		END AS discount_effect
FROM(
	SELECT product_id, discount, SUM(quantity) total_qty
	FROM sale.order_item
	GROUP BY product_id, discount
	) subq

--P.S
--Assignment task could have been better specified












