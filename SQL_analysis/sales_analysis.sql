
USE ecommerce_analytics;

-- 1. Total Sales Revenue (Delivered Orders)
SELECT
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


-- 2. Total Delivered Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
WHERE order_status = 'delivered';


-- 3. Average Order Value (AOV)
SELECT
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id), 2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


-- 4. Monthly Revenue Trend
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(oi.price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;


-- 5. Monthly Order Trend
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;


-- 6. Order Status Distribution
SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2
    ) AS percentage
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
```