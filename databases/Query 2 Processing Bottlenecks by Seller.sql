
-- Query 2: Processing Bottlenecks by Seller
SELECT 
    s.seller_id,
    s.state AS seller_state,
    COUNT(f.order_id) AS total_orders,
    ROUND(AVG(f.processing_days), 2) AS avg_processing_days,
    ROUND((SUM(f.is_late)::NUMERIC / COUNT(f.order_id)) * 100, 2) AS late_delivery_pct
FROM fact_orders f
JOIN dim_seller s ON f.seller_id = s.seller_id
GROUP BY s.seller_id, s.state
HAVING COUNT(f.order_id) >= 50
ORDER BY avg_processing_days DESC
LIMIT 10;