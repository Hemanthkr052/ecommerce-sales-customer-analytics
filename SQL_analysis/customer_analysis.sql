
USE ecommerce_analytics;

-- 1. Total Unique Customers
SELECT
    COUNT(DISTINCT c.customer_unique_id) AS total_customers
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered';


-- 2. One-time vs Repeat Customers
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time Customers'
        ELSE 'Repeat Customers'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY customer_type;


-- 3. Repeat Purchase Rate
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(CASE WHEN total_orders > 1 THEN 1 END) AS repeat_customers,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(CASE WHEN total_orders > 1 THEN 1 END)
        * 100.0 / COUNT(*), 2
    ) AS repeat_purchase_rate
FROM customer_orders;


-- 4. Average Customer Lifetime Revenue
WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS lifetime_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    ROUND(AVG(lifetime_revenue), 2) AS average_lifetime_revenue,
    ROUND(MAX(lifetime_revenue), 2) AS highest_customer_revenue
FROM customer_revenue;


-- 5. Top 10 Customers by Revenue
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY total_revenue DESC
LIMIT 10;


-- 6. Customer Revenue Segmentation
WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS lifetime_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    CASE
        WHEN lifetime_revenue < 500 THEN 'Low Value'
        WHEN lifetime_revenue < 1000 THEN 'Medium Value'
        ELSE 'High Value'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(lifetime_revenue), 2) AS average_revenue,
    ROUND(SUM(lifetime_revenue), 2) AS total_revenue
FROM customer_revenue
GROUP BY customer_segment
ORDER BY total_revenue DESC;
