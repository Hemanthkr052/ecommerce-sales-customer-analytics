
USE ecommerce_analytics;

-- 1. Overall Delivery Performance
SELECT
    COUNT(*) AS delivered_orders,
    ROUND(AVG(DATEDIFF(
        order_delivered_customer_date,
        order_purchase_timestamp
    )), 2) AS average_delivery_days
FROM orders
WHERE order_status = 'delivered';


-- 2. On-Time vs Late Deliveries
SELECT
    CASE
        WHEN order_delivered_customer_date >
             order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM orders
         WHERE order_status = 'delivered'),
        2
    ) AS percentage
FROM orders
WHERE order_status = 'delivered'
GROUP BY delivery_status;


-- 3. Late Delivery Rate
SELECT
    COUNT(CASE
        WHEN order_delivered_customer_date >
             order_estimated_delivery_date
        THEN 1
    END) AS late_orders,
    ROUND(
        COUNT(CASE
            WHEN order_delivered_customer_date >
                 order_estimated_delivery_date
            THEN 1
        END) * 100.0 / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM orders
WHERE order_status = 'delivered';


-- 4. Average Delivery Time by State
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(DATEDIFF(
        o.order_delivered_customer_date,
        o.order_purchase_timestamp
    )), 2) AS average_delivery_days
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY average_delivery_days DESC;


-- 5. Monthly Late Delivery Rate
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(*) AS total_orders,
    COUNT(CASE
        WHEN order_delivered_customer_date >
             order_estimated_delivery_date
        THEN 1
    END) AS late_orders,
    ROUND(
        COUNT(CASE
            WHEN order_delivered_customer_date >
                 order_estimated_delivery_date
            THEN 1
        END) * 100.0 / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM orders
WHERE order_status = 'delivered'
GROUP BY month
ORDER BY month;
