-- Task 5: CASE WHEN tiering, monthly report, and variance queries
-- BigBasket Category Performance Diagnostic — Part 1

-- 5a. Tier every product by total Delivered revenue
WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(o.amount_inr) AS total_revenue
    FROM products p
    JOIN orders o ON p.product_id = o.product_id
    WHERE o.status = 'Delivered'
    GROUP BY p.product_id, p.product_name
)
SELECT
    product_id,
    product_name,
    total_revenue,
    CASE
        WHEN total_revenue >= 3000 THEN 'High'
        WHEN total_revenue >= 1000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_tier
FROM product_revenue
ORDER BY total_revenue DESC;

-- 5b. Monthly-by-category business report (Delivered only)
-- This is the exact query exported to monthly_category_revenue.csv
SELECT
    p.category,
    strftime('%Y-%m', o.order_date) AS month,
    COUNT(*) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category, strftime('%Y-%m', o.order_date)
ORDER BY p.category, month;

-- 5c. Derived fields: variance and percentage_variance vs category_targets
WITH category_revenue AS (
    SELECT
        p.category,
        SUM(o.amount_inr) AS total_revenue
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY p.category
)
SELECT
    cr.category,
    cr.total_revenue,
    ct.target_revenue_inr,
    (ct.target_revenue_inr - cr.total_revenue) AS variance,
    ((cr.total_revenue - ct.target_revenue_inr) * 100.0) / ct.target_revenue_inr AS percentage_variance,
    CASE
        WHEN cr.total_revenue >= ct.target_revenue_inr THEN 'Above Target'
        WHEN ((ct.target_revenue_inr - cr.total_revenue) * 100.0) / ct.target_revenue_inr <= 15 THEN 'Below Target - Watch'
        ELSE 'Below Target - Critical'
    END AS status_tag
FROM category_revenue cr
JOIN category_targets ct ON cr.category = ct.category
ORDER BY percentage_variance;
