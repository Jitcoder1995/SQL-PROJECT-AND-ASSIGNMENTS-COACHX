USE customers_orders_products;

-- TASK 1: BASIC SQL
-- 1. All customers
SELECT * FROM customers;

-- 2. Customers whose names start with J
SELECT customer_name, email FROM customers WHERE customer_name LIKE 'J%';

-- 3. Order ID, product name and quantity
SELECT o.order_id, p.product_name, o.quantity
FROM orders o JOIN products p ON p.product_id=o.product_id;

-- 4. Total quantity ordered
SELECT SUM(quantity) AS total_quantity FROM orders;

-- 5. Customers who placed orders
SELECT DISTINCT c.customer_name
FROM customers c JOIN orders o ON o.customer_id=c.customer_id;

-- 6. Products priced above 10
SELECT * FROM products WHERE price > 10;

-- 7. Customer and order date from 5 July 2023 onwards
SELECT c.customer_name, o.order_date
FROM customers c JOIN orders o ON o.customer_id=c.customer_id
WHERE o.order_date >= '2023-07-05' ORDER BY o.order_date;

-- 8. Average product price
SELECT ROUND(AVG(price),2) AS average_price FROM products;

-- 9. Each customer's total ordered quantity, including zero
SELECT c.customer_id, c.customer_name, COALESCE(SUM(o.quantity),0) AS total_quantity
FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.customer_name;

-- 10. Products never ordered
SELECT p.product_id,p.product_name
FROM products p LEFT JOIN orders o ON o.product_id=p.product_id
WHERE o.order_id IS NULL;

-- TASK 2: INTERMEDIATE SQL
-- 1. Top 5 customers by total quantity
SELECT c.customer_id,c.customer_name,SUM(o.quantity) AS total_quantity
FROM customers c JOIN orders o ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.customer_name
ORDER BY total_quantity DESC LIMIT 5;

-- 2. Average price by category: see optional category script.

-- 3. Customers with no orders
SELECT c.customer_id,c.customer_name
FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id
WHERE o.order_id IS NULL;

-- 4. Order details for customers whose names start with M
SELECT o.order_id,c.customer_name,p.product_name,o.quantity,o.order_date
FROM orders o JOIN customers c ON c.customer_id=o.customer_id
JOIN products p ON p.product_id=o.product_id
WHERE c.customer_name LIKE 'M%';

-- 5. Total revenue
SELECT ROUND(SUM(o.quantity*p.price),2) AS total_revenue
FROM orders o JOIN products p ON p.product_id=o.product_id;

-- 6. Revenue by customer
SELECT c.customer_id,c.customer_name,ROUND(SUM(o.quantity*p.price),2) AS revenue
FROM customers c JOIN orders o ON o.customer_id=c.customer_id
JOIN products p ON p.product_id=o.product_id
GROUP BY c.customer_id,c.customer_name ORDER BY revenue DESC;

-- 7. Customers who ordered from every category: see optional category script.

-- 8. Customers with orders on consecutive days
SELECT DISTINCT c.customer_id,c.customer_name
FROM customers c JOIN orders a ON a.customer_id=c.customer_id
JOIN orders b ON b.customer_id=c.customer_id
AND DATEDIFF(b.order_date,a.order_date)=1;

-- 9. Top 3 products by average quantity per order
SELECT p.product_name,ROUND(AVG(o.quantity),2) AS average_quantity
FROM products p JOIN orders o ON o.product_id=p.product_id
GROUP BY p.product_id,p.product_name
ORDER BY average_quantity DESC LIMIT 3;

-- 10. Percentage of orders with quantity above average
SELECT ROUND(100.0*SUM(CASE WHEN quantity>(SELECT AVG(quantity) FROM orders)
THEN 1 ELSE 0 END)/COUNT(*),2) AS percentage_above_average
FROM orders;

-- BONUS: Monthly revenue
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS order_month,
ROUND(SUM(o.quantity*p.price),2) AS revenue
FROM orders o JOIN products p ON p.product_id=o.product_id
GROUP BY DATE_FORMAT(o.order_date,'%Y-%m') ORDER BY order_month;

-- BONUS: Best-selling product by units
SELECT p.product_name,SUM(o.quantity) AS units_sold
FROM products p JOIN orders o ON o.product_id=p.product_id
GROUP BY p.product_id,p.product_name ORDER BY units_sold DESC LIMIT 1;
