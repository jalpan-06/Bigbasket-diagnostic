-- Task 3: Foundational queries
-- BigBasket Category Performance Diagnostic — Part 1

-- 1. SELECT / WHERE: orders placed by customers in a specific city (via join to customers)
SELECT o.*
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.city = 'Mumbai';

-- 2. DISTINCT: every distinct category
SELECT DISTINCT category
FROM products;

-- 3. ORDER BY + LIMIT: 5 highest-value orders by amount_inr
SELECT order_id, amount_inr
FROM orders
ORDER BY amount_inr DESC
LIMIT 5;

-- 4. Alias (AS): rename an aggregate in output
SELECT COUNT(*) AS total_orders
FROM orders;

-- 5. IN: orders whose payment_mode is in a 2-mode list
SELECT order_id, payment_mode
FROM orders
WHERE payment_mode IN ('UPI', 'Wallet');

-- 6. BETWEEN: orders with amount_inr in a stated range
SELECT order_id, amount_inr
FROM orders
WHERE amount_inr BETWEEN 100 AND 500;

-- 6b. NOT BETWEEN: orders with amount_inr outside that range
SELECT order_id, amount_inr
FROM orders
WHERE amount_inr NOT BETWEEN 100 AND 500;

-- 7. IS NULL: orders with no rating recorded
-- (these should be exactly the Cancelled/Pending orders: 42 + 24 = 66 rows)
SELECT order_id, status, rating
FROM orders
WHERE rating IS NULL;
