-- Active: 1695192762344@@127.0.0.1@5432@northwind@public

-- החזר לקוחות שלא ביצעו אף הזמנה
SELECT *
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.customer_id IS NULL

-- החזר לקוחות שיש להם מעל 10 הזמנות
SELECT * 
FROM (
    SELECT customers.customer_id, COUNT(orders.order_id) AS amount_of_orders
    FROM customers 
    FULL JOIN orders
    ON customers.customer_id = orders.customer_id
    GROUP BY customers.customer_id
)
WHERE amount_of_orders > 10

-- החזר מוצרים שמעל המחיר הממוצע
SELECT AVG(unit_price) 
FROM products -- 28.83

SELECT product_id, unit_price 
FROM products
WHERE unit_price > (
    SELECT AVG(unit_price) 
    FROM products
)

-- החזר רשימה של מוצרים שמעולם לא הוזמנו
SELECT *
FROM (
    SELECT products.product_id, order_details.product_id AS ordered_product
    FROM products
    LEFT JOIN order_details
    ON products.product_id = order_details.product_id
)
WHERE ordered_product IS NULL

-- החזר רשימה של מדינות היכן שלפחות 5 לקוחות ממוקמים
SELECT * 
FROM (
    SELECT city, COUNT(customer_id) AS num_of_customers
    FROM customers 
    GROUP BY city
)
WHERE num_of_customers >= 5

-- החזר רשימה של לקוחות שלא ביצעו אף הזמנה בשנת 1998
SELECT *
FROM customers
WHERE customers.customer_id NOT IN (
    SELECT customers.customer_id
    FROM customers
    LEFT JOIN orders
    ON customers.customer_id = orders.customer_id
    WHERE EXTRACT(YEAR FROM orders.order_date) = 1998
) 

-- החזר לקוחות ממדינה ספציפית (לדוג’ “גרמניה”) שלא ביצעו אף הזמנה אחרי הראשון בינואר 1998

SELECT *  
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = 'France'
AND customers.customer_id NOT IN (
    SELECT customers.customer_id  
    FROM customers
    JOIN orders
    ON customers.customer_id = orders.customer_id
    WHERE EXTRACT(YEAR FROM orders.order_date) >= 1998
);

-- testing on VINET
SELECT * 
FROM orders
WHERE customer_id = 'VINET'

-- החזר רשימת לקוחות שביצעו בדיוק 3 הזמנות

SELECT contact_name
FROM(
    SELECT customers.contact_name, COUNT(orders.order_id) as amount_of_orders
    FROM customers
    JOIN orders
    ON orders.customer_id = customers.customer_id  
    GROUP BY customers.contact_name
)
WHERE amount_of_orders = 3

-- test with Elizabeth Brown
SELECT *
FROM orders
JOIN customers
ON customers.customer_id = orders.customer_id
WHERE customers.contact_name = 'Elizabeth Brown' -- returning 3 rows

-- החזר את המוצר האחרון שהוסף מבחינת תאריך

-- there's no date for added products 

-- החזר ספק ממדינה ספציפית (לדוג’ “ארה”ב) שלהם יותר ממוצר אחד שסופק

SELECT supplier_id, amount_of_products
FROM (
select suppliers.supplier_id, suppliers.country, COUNT(products.product_id) amount_of_products
FROM suppliers
JOIN products
ON products.supplier_id = suppliers.supplier_id
WHERE country = 'France'
GROUP BY suppliers.supplier_id
)
WHERE amount_of_products > 1

