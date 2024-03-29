-- select * from employees
-- -- 1
-- -- Number of Orders per Employee: Count the number of orders handled by each employee
-- -- Display the employee's name and the number of orders they have handled
-- SELECT
--     CONCAT(first_Name, ' ', Last_Name) AS Employee_Name,
--     COUNT(Orders.Order_ID) AS NumberOfOrdersHandled 
-- from orders inner join employees
-- on orders.employee_id = employees.employee_id
-- group by employee_name

-- -- 2
-- -- Total Sales by Category: Write a SQL query to find the total sales amount for each product category in the Northwind database. 
-- -- Display the category name and the total sales amount in descending order of sales.
-- select category_name, count(order_details.order_id) as Sales_Count
-- from categories inner join products
-- on categories.category_id = products.category_id inner join order_details 
-- on order_details.product_id = products.product_id
-- group by category_name
-- order by Sales_Count DESC



-- -- 3 
-- Average Order Price : 
-- Calculate the average order price for each customer. 
-- Display the customer's name and their average order price, sorted from highest to lowest.
-- SELECT
--     Sub.Customer_ID,
--     AVG(Sub.TotalOrderCost) AS AverageOrderCost
-- FROM (
--     SELECT
--     Customers.Customer_ID,
--     Orders.Order_ID,
--     SUM(Order_Details.Unit_Price * Order_Details.Quantity * (1 - order_details.discount)) AS TotalOrderCost
-- FROM
--     Customers
-- INNER JOIN
--     Orders ON Customers.Customer_ID = Orders.Customer_ID
-- INNER JOIN
--     Order_Details ON Orders.Order_ID = Order_Details.Order_ID
-- GROUP BY
--     Customers.Customer_ID, Orders.Order_ID

-- ) AS Sub
-- GROUP BY
--     Sub.Customer_ID;

-- -- 4
-- -- Top 10 Customers by Total Spending: Write a query to find the top 10 customers who have spent the most in total. 
-- SELECT
--     customers.contact_name AS Name,
--     round(SUM(order_details.unit_price * order_details.quantity * (1 - order_details.discount))) AS TotalSpending
-- FROM
--     customers
-- JOIN
--     orders ON customers.customer_id = orders.customer_id
-- JOIN
--     order_details ON orders.order_id = order_details.order_id
-- GROUP BY
--     customers.contact_name
-- ORDER BY
--     TotalSpending DESC
-- LIMIT 10;

-- -- 5 
-- -- Monthly Sales Total: Calculate the total sales for each month. 
-- -- Display the month and the total sales amount for that month. Sort the results by month
-- SELECT
--     TO_CHAR(Orders.order_date, 'YYYY-MM') AS Month,
--     ROUND(SUM((order_details.unit_price * order_details.quantity) * (1 - order_details.discount))) AS TotalSales
-- FROM
--     Orders
-- JOIN
--     order_details ON Orders.order_id = order_details.order_id
-- GROUP BY
--     Month
-- ORDER BY
--     Month;

-- -- 6
-- -- Products with Low Stock: 
-- -- Find products in the database that have a stock level below a certain threshold (e.g., less than 10 units). 
-- -- Display the product name and the current stock level.
-- -- Displaying products with stock less than 10
-- select product_name, units_in_stock from products where units_in_stock < 10

-- -- 7
-- -- Customer with the Highest Single Order: 
-- -- Identify the customer who placed the highest single order in terms of order amount. 
-- -- Display the customer's name and the order amount.
-- select contact_name, sum(quantity) as order_size 
-- from order_details join orders 
-- on orders.order_id = order_details.order_id
-- join customers ON customers.customer_id = orders.customer_id
-- group by order_details.order_id, customers.contact_name
-- order by order_size desc
-- limit 1

-- -- 8
-- -- Total Revenue by Country: 
-- -- Calculate the total revenue generated by orders in each country. 
-- -- Display the country and the total revenue in descending order of revenue.
-- select customers.country, 
-- 	sum(order_details.quantity * order_details.unit_price * (1 - order_details.discount)) 
-- FROM customers
-- join orders ON 
-- 	orders.customer_id = customers.customer_id
-- join order_details ON 
-- 	order_details.order_id = orders.order_id
-- group by country

-- -- 9
-- -- Most Popular Shipper: 
-- -- Determine the shipper that has been used for the most orders. 
-- -- Display the shipper's name and the number of orders they have handled.
-- select shippers.shipper_id, count(orders.ship_via) from shippers join 
-- orders orders ON orders.ship_via = shippers.shipper_id
-- group by shippers.shipper_id
-- order by count desc

-- 10
-- Products with No Sales: Find products that have not been sold yet. 
-- Display the product name and any relevant information.
-- SELECT
--     Products.ProductName,
--     Products.SupplierID,
--     Products.CategoryID,
--     Products.QuantityPerUnit,
--     Products.UnitPrice
-- FROM
--     Products
-- LEFT JOIN
--     OrderDetails ON Products.ProductID = OrderDetails.ProductID
-- WHERE
--     OrderDetails.ProductID IS NULL;

