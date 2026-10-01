
-- Query 3: Correlation Between Late Delivery & Poor Customer Ratings
SELECT 
    CASE WHEN f.is_late = 1 THEN 'Late Delivery' ELSE 'On-Time Delivery' END AS delivery_status,
    COUNT(f.order_id) AS total_orders,
    ROUND(AVG(f.avg_review_score), 2) AS avg_review_score,
    ROUND((SUM(CASE WHEN f.avg_review_score <= 2 THEN 1 ELSE 0 END)::NUMERIC / COUNT(f.order_id)) * 100, 2) AS poor_review_pct
FROM fact_orders f
WHERE f.avg_review_score IS NOT NULL
GROUP BY f.is_late;