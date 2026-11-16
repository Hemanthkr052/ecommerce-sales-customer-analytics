Use ecommerce_analytics;
-- CREATE OR REPLACE VIEW vw_rfm_dashboard AS
-- WITH customer_rfm AS (
--     SELECT
--         c.customer_unique_id,
--         DATEDIFF(
--             (SELECT MAX(o.order_purchase_timestamp)
--              FROM orders o
--              WHERE o.order_status = 'delivered'),
--             MAX(o.order_purchase_timestamp)
--         ) AS recency,
--         COUNT(DISTINCT o.order_id) AS frequency,
--         SUM(oi.price) AS monetary
--     FROM customers c
--     JOIN orders o
--         ON c.customer_id = o.customer_id
--     JOIN order_items oi
--         ON o.order_id = oi.order_id
--     WHERE o.order_status = 'delivered'
--     GROUP BY c.customer_unique_id
-- ),
-- rfm_scores AS (
--     SELECT *,
--         NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
--         NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
--         NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
--     FROM customer_rfm
-- ),
-- segments AS (
--     SELECT *,
--         CASE
--             WHEN r_score >= 4 AND f_score >= 4
--                  AND m_score >= 4 THEN 'Champions'
--             WHEN r_score >= 3 AND f_score >= 4
--                  THEN 'Loyal Customers'
--             WHEN r_score >= 4 AND f_score <= 2
--                  THEN 'Recent Customers'
--             WHEN r_score <= 2 AND f_score >= 3
--                  THEN 'At Risk'
--             WHEN r_score <= 2 AND f_score <= 2
--                  THEN 'Hibernating'
--             ELSE 'Potential Customers'
--         END AS customer_segment
--     FROM rfm_scores
-- )
-- SELECT
--     customer_segment,
--     COUNT(*) AS customer_count
-- FROM segments
-- GROUP BY customer_segment;

-- SELECT *
-- FROM vw_rfm_dashboard;

CREATE OR REPLACE VIEW vw_customer_acquisition AS
SELECT
    customer_unique_id,
    DATE_FORMAT(first_purchase, '%Y-%m') AS acquisition_month
FROM (
    SELECT
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_purchase
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
) AS first_orders;