
USE ecommerce_analytics;

-- 1. Top 10 Product Categories by Revenue
SELECT
    COALESCE(ct.product_category_name_english,
             p.product_category_name) AS category,
    COUNT(*) AS total_items,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 10;


-- 2. Top 10 Product Categories by Items Sold
SELECT
    COALESCE(ct.product_category_name_english,
             p.product_category_name) AS category,
    COUNT(*) AS items_sold
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY items_sold DESC
LIMIT 10;


-- 3. Top 10 Products by Revenue
SELECT
    oi.product_id,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.product_id
ORDER BY total_revenue DESC
LIMIT 10;


-- 4. Revenue Contribution by Product Category
SELECT
    COALESCE(ct.product_category_name_english,
             p.product_category_name) AS category,
    ROUND(SUM(oi.price), 2) AS revenue,
    ROUND(
        SUM(oi.price) * 100.0 /
        (SELECT SUM(oi2.price)
         FROM orders o2
         JOIN order_items oi2 ON o2.order_id = oi2.order_id
         WHERE o2.order_status = 'delivered'),
        2
    ) AS revenue_percentage
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY revenue DESC;