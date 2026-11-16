
USE ecommerce_analytics;

-- 1. Review Score Distribution
SELECT
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM reviews),
        2
    ) AS review_percentage
FROM reviews
GROUP BY review_score
ORDER BY review_score DESC;


-- 2. Average Review Score
SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM reviews;


-- 3. Review Score by Delivery Status
SELECT
    CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY delivery_status;


-- 4. Average Review Score by Product Category
SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name
    ) AS category,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
HAVING COUNT(*) >= 50
ORDER BY average_review_score DESC;


-- 5. Negative Reviews by Product Category
SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name
    ) AS category,
    COUNT(*) AS total_reviews,
    SUM(CASE
        WHEN r.review_score <= 2 THEN 1
        ELSE 0
    END) AS negative_reviews,
    ROUND(
        SUM(CASE
            WHEN r.review_score <= 2 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS negative_review_percentage
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
HAVING COUNT(*) >= 50
ORDER BY negative_review_percentage DESC;
