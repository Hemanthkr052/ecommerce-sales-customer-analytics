
USE ecommerce_analytics;

-- 1. Payment Method Distribution
SELECT
    payment_type,
    COUNT(*) AS total_payment_records,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS average_payment_value
FROM payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- 2. Payment Method Analysis at Order Level
WITH order_payment AS (
    SELECT
        order_id,
        CASE
            WHEN COUNT(DISTINCT payment_type) > 1
                THEN 'Multiple'
            ELSE MAX(payment_type)
        END AS payment_method
    FROM payments
    GROUP BY order_id
)
SELECT
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS total_payment,
    ROUND(SUM(p.payment_value) / COUNT(*), 2) AS average_order_payment
FROM order_payment op
JOIN payments p
    ON op.order_id = p.order_id
GROUP BY payment_method
ORDER BY total_payment DESC;


-- 3. Installment Distribution
SELECT
    payment_installments,
    COUNT(*) AS total_records,
    ROUND(SUM(payment_value), 2) AS total_payment
FROM payments
WHERE payment_type = 'credit_card'
GROUP BY payment_installments
ORDER BY total_records DESC;


-- 4. Monthly Payment Trends
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    p.payment_type,
    ROUND(SUM(p.payment_value), 2) AS monthly_payment
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY month, p.payment_type
ORDER BY month, monthly_payment DESC;
