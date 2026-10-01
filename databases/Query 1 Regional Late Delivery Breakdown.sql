
-- Query 1: Regional Late Delivery Breakdown
SELECT 
    c.state AS customer_state,
    COUNT(f.order_id) AS total_orders,
    SUM(f.is_late) AS late_orders,
    ROUND((SUM(f.is_late)::NUMERIC / COUNT(f.order_id)) * 100, 2) AS late_delivery_pct,
    ROUND(AVG(f.actual_delivery_days), 1) AS avg_delivery_days
FROM fact_orders f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.state
HAVING COUNT(f.order_id) >= 500
ORDER BY late_delivery_pct DESC;