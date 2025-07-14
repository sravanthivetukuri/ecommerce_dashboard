CREATE SCHEMA ecommerce;
CREATE TABLE ecommerce.customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    signup_date DATE,
    country VARCHAR(50)
);
INSERT INTO ecommerce.customers (customer_id, name, gender, age, signup_date, country) VALUES
(1, 'Alice', 'Female', 30, '2021-01-15', 'USA'),
(2, 'Bob', 'Male', 25, '2020-03-20', 'India'),
(3, 'Carlos', 'Male', 40, '2021-06-05', 'Mexico'),
(4, 'Diana', 'Female', 35, '2022-01-10', 'UK'),
(5, 'Ethan', 'Male', 28, '2022-05-12', 'India'),
(6, 'Fiona', 'Female', 29, '2021-02-18', 'Canada'),
(7, 'George', 'Male', 30, '2021-08-01', 'USA'),
(8, 'Hannah', 'Female', 27, '2023-03-22', 'Germany'),
(9, 'Ivan', 'Male', 38, '2022-07-19', 'France'),
(10, 'Julia', 'Female', 29, '2021-09-30', 'Australia');


CREATE TABLE ecommerce.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2)
);
INSERT INTO ecommerce.products (product_id, product_name, category, sub_category, cost_price, selling_price) VALUES
(101, 'Wireless Mouse', 'Electronics', 'Accessories', 300, 500),
(102, 'T-Shirt', 'Clothing', 'Men', 200, 400),
(103, 'Coffee Mug', 'Home & Kitchen', 'Crockery', 100, 250),
(104, 'Bluetooth Speaker', 'Electronics', 'Audio', 800, 1500),
(105, 'Notebook', 'Stationery', 'Office', 50, 120),
(106, 'Yoga Mat', 'Fitness', 'Gear', 350, 800),
(107, 'Sunglasses', 'Accessories', 'Fashion', 400, 900),
(108, 'LED Lamp', 'Home & Kitchen', 'Lighting', 300, 700),
(109, 'Running Shoes', 'Footwear', 'Men', 1000, 1800),
(110, 'Smart Watch', 'Electronics', 'Wearables', 1500, 2800);


CREATE TABLE ecommerce.orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    payment_method VARCHAR(20)
);
INSERT INTO ecommerce.orders VALUES
(1001, 1, '2023-01-10', 'Delivered', 'Credit Card'),
(1002, 2, '2023-02-12', 'Cancelled', 'UPI'),
(1003, 3, '2023-03-15', 'Delivered', 'Cash'),
(1004, 1, '2023-04-20', 'Returned', 'Credit Card'),
(1005, 4, '2023-05-10', 'Delivered', 'Credit Card'),
(1006, 5, '2023-06-14', 'Delivered', 'Net Banking'),
(1007, 6, '2023-06-18', 'Pending', 'UPI'),
(1008, 7, '2023-07-02', 'Delivered', 'Debit Card'),
(1009, 8, '2023-07-20', 'Delivered', 'Cash'),
(1010, 9, '2023-08-01', 'Delivered', 'Credit Card'),
(1011, 10, '2023-08-15', 'Cancelled', 'UPI');


CREATE TABLE ecommerce.order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT
);
INSERT INTO ecommerce.order_items VALUES
(1, 1001, 101, 2),
(2, 1001, 102, 1),
(3, 1002, 103, 3),
(4, 1003, 102, 2),
(5, 1004, 101, 1),
(6, 1005, 104, 1),
(7, 1005, 105, 4),
(8, 1006, 106, 2),
(9, 1007, 107, 1),
(10, 1008, 108, 2),
(11, 1009, 109, 1),
(12, 1010, 110, 1),
(13, 1011, 101, 2);


CREATE TABLE ecommerce.shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipped_date DATE,
    delivery_date DATE,
    shipping_cost DECIMAL(10,2)
);
INSERT INTO ecommerce.shipping VALUES
(501, 1001, '2023-01-11', '2023-01-15', 50),
(502, 1003, '2023-03-16', '2023-03-18', 60),
(503, 1004, '2023-04-21', '2023-04-25', 55),
(504, 1005, '2023-05-11', '2023-05-13', 40),
(505, 1006, '2023-06-15', '2023-06-17', 45),
(506, 1008, '2023-07-03', '2023-07-05', 50),
(507, 1009, '2023-07-21', '2023-07-25', 70),
(508, 1010, '2023-08-02', '2023-08-04', 60);


SELECT 
  o.order_id,
  c.name AS customer_name,
  c.country,
  o.order_status,
  c.signup_date,
  p.product_name,
  p.category,
  oi.quantity,
  (oi.quantity * p.selling_price) AS revenue,
  (oi.quantity * p.cost_price) AS cost,
  ((oi.quantity * p.selling_price) - (oi.quantity * p.cost_price)) AS profit,
  o.order_date,
  s.shipping_cost,
  s.delivery_date - s.shipped_date AS delivery_time_days
FROM ecommerce.orders o
JOIN ecommerce.order_items oi ON o.order_id = oi.order_id
JOIN ecommerce.products p ON oi.product_id = p.product_id
JOIN ecommerce.customers c ON o.customer_id = c.customer_id
LEFT JOIN ecommerce.shipping s ON o.order_id = s.order_id
WHERE o.order_status = 'Delivered';
