USE customers_orders_products;

-- Optional exercise: original assignment schema did not include categories.
ALTER TABLE products ADD COLUMN product_category VARCHAR(50);

-- Illustrative categories only; replace with genuine category data if supplied.
UPDATE products SET product_category = CASE
 WHEN product_id IN (1,2,3) THEN 'Category 1'
 WHEN product_id IN (4,5,6) THEN 'Category 2'
 WHEN product_id IN (7,8,9) THEN 'Category 3'
 ELSE 'Category 4' END;

-- Task 2 Q2: average price by category
SELECT product_category,ROUND(AVG(price),2) AS average_price
FROM products GROUP BY product_category;

-- Task 2 Q7: customers who ordered from every category
SELECT c.customer_id,c.customer_name
FROM customers c JOIN orders o ON o.customer_id=c.customer_id
JOIN products p ON p.product_id=o.product_id
GROUP BY c.customer_id,c.customer_name
HAVING COUNT(DISTINCT p.product_category)=
 (SELECT COUNT(DISTINCT product_category) FROM products);
