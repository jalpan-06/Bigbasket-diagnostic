-- Task 4: Aggregation, joins, and HAVING
-- BigBasket Category Performance Diagnostic — Part 1

-- 4a. INNER JOIN orders->products, GROUP BY category, Delivered only, HAVING total_revenue > 10000
SELECT
    p.category,
    COUNT(*) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
HAVING total_revenue > 10000;

-- 4b. LEFT JOIN products->orders, COUNT(o.order_id) NOT COUNT(*), ascending
-- Premium Face Cream 50g must appear with count = 0
SELECT
    p.product_id,
    p.product_name,
    COUNT(o.order_id) AS total_orders
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_orders ASC;
