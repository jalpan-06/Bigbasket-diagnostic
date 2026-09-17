-- Verification results (run against bigbasket_capstone.db)
-- products:          31
-- customers:         50
-- orders:            500
-- category_targets:  6
-- orders GROUP BY status: Delivered=434, Cancelled=42, Pending=24

SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM category_targets;

SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status;
