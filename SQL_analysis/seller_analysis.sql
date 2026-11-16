
USE ecommerce_analytics;

-- 1. Top 10 Sellers by Revenue
SELECT
    oi.seller_id,
    COUNT(*) AS total_items,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;


-- 2. Top 10 Sellers by Number of Items Sold
SELECT
    oi.seller_id,
    COUNT(*) AS total_items
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY total_items DESC
LIMIT 10;


-- 3. Total Revenue by Seller State
SELECT
    s.seller_state,
    COUNT(DISTINCT oi.seller_id) AS total_sellers,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_state
ORDER BY total_revenue DESC;


-- 4. Seller Revenue Contribution
SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS seller_revenue,
    ROUND(
        SUM(oi.price) * 100.0 /
        (SELECT SUM(oi2.price)
         FROM orders o2
         JOIN order_items oi2
             ON o2.order_id = oi2.order_id
         WHERE o2.order_status = 'delivered'),
        2
    ) AS revenue_percentage
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY seller_revenue DESC;
