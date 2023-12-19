-- Non Graded Challenge 5 --
-- Catherine Helenna Mulyadi --
		-- RMT 027 --
		
-- Create table
-- CREATE TABLE <Table Name> (columnName dataType constrain)

-- create first table: customer_info
CREATE TABLE customer_info(
	customer_id SERIAL PRIMARY KEY,
	customer_name VARCHAR(30),
	city VARCHAR(30)
);

SELECT * FROM customer_info

-- create first table: order_info
-- note: customer_id is the foreign key, relating with customer_info() table
CREATE TABLE order_info(
	order_id SERIAL PRIMARY KEY,
	customer_id INTEGER REFERENCES customer_info(customer_id),
	order_date DATE NOT NULL,
	total_amount FLOAT
);

SELECT * FROM order_info

-- Inserting values into each table

INSERT INTO customer_info (customer_name, city)
VALUES
    ('John Doe', 'New York'),
    ('Jane Smith', 'Los Angeles'),
    ('David Johnson', 'Chicago');

SELECT * FROM customer_info

INSERT INTO order_info (customer_id, order_date, total_amount)
VALUES
    ('1', '2022-01-10', 100.00),
    ('1', '2022-02-15', 150.00),
    ('2', '2022-03-20', 200.00),
	('3', '2022-04-25', 50.00);
	
DELETE FROM order_info

SELECT * FROM order_info
-- TASK ABOUT JOINING TWO TABLES TO PRESENT TOTAL NUMBER OF ORDERS EACH CUSTOMER MAKES
------------------------------------------------------------------------------------------


-- SELECT customer_name data from customer info, then COUNT the number of customer id showed in order_info
-- label the count output (a column) AS total_orders
SELECT customer_info.customer_name, COUNT(order_info.customer_id) AS total_orders
-- LEFT JOIN means that the left side will be the result which is FROM the order_info table.
-- under condition that order_info.customer_id matches with customer_info.customer_id
FROM order_info
LEFT JOIN customer_info ON order_info.customer_id = customer_info.customer_id
-- GROUP BY means that the result will be concluded into rows according to the customer_name.
GROUP BY customer_name;
