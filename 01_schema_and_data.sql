DROP DATABASE IF EXISTS customers_orders_products;
CREATE DATABASE customers_orders_products;
USE customers_orders_products;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE
);
CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL UNIQUE,
  price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  order_date DATE NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1,'John Doe','johndoe@example.com'),
(2,'Jane Smith','janesmith@example.com'),
(3,'Robert Johnson','robertjohnson@example.com'),
(4,'Emily Brown','emilybrown@example.com'),
(5,'Michael Davis','michaeldavis@example.com'),
(6,'Sarah Wilson','sarahwilson@example.com'),
(7,'David Thompson','davidthompson@example.com'),
(8,'Jessica Lee','jessicalee@example.com'),
(9,'William Turner','williamturner@example.com'),
(10,'Olivia Martinez','oliviamartinez@example.com'),
(11,'James Anderson','jamesanderson@example.com'),
(12,'Kelly Clarkson','kellyclarkson@example.com');

INSERT INTO products VALUES
(1,'Product A',10.99),(2,'Product B',8.99),(3,'Product C',5.99),
(4,'Product D',12.99),(5,'Product E',7.99),(6,'Product F',6.99),
(7,'Product G',9.99),(8,'Product H',11.99),(9,'Product I',14.99),
(10,'Product J',4.99),(11,'Product K',3.99),(12,'Product L',15.99);

INSERT INTO orders VALUES
(1,1,1,'2023-07-01',5),(2,2,2,'2023-07-02',3),
(3,3,3,'2023-07-03',2),(4,4,1,'2023-07-04',1),
(5,5,2,'2023-07-05',4),(6,6,3,'2023-07-06',2),
(7,7,1,'2023-07-07',3),(8,8,2,'2023-07-08',2),
(9,9,3,'2023-07-09',5),(10,10,1,'2023-07-10',1),
(11,11,4,'2023-07-10',3),(12,12,5,'2023-07-11',6),
(13,5,7,'2023-07-12',2),(14,4,8,'2023-07-13',4),
(15,6,9,'2023-07-14',3);

SELECT COUNT(*) AS customers FROM customers;
SELECT COUNT(*) AS products FROM products;
SELECT COUNT(*) AS orders FROM orders;
SELECT SUM(quantity) AS total_quantity FROM orders; -- 46
