
CREATE TABLE fact_orders AS
WITH item_aggregates AS (
    SELECT 
        order_id,
        COUNT(order_item_id) AS total_items,
        SUM(price) AS total_order_value,
        SUM(freight_value) AS total_freight_value,
        MAX(seller_id) AS seller_id,     -- Primary seller associated
        MAX(product_id) AS product_id   -- Primary product associated
    FROM staging_order_items
    GROUP BY order_id
),
review_aggregates AS (
    SELECT 
        order_id,
        AVG(review_score) AS avg_review_score
    FROM staging_order_reviews
    GROUP BY order_id
)
SELECT 
    o.order_id,
    o.customer_id,
    i.seller_id,
    i.product_id,
    o.order_status,
    o.order_purchase_timestamp::DATE AS order_date,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    
    -- Calculated Metrics & Flags
    EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) AS actual_delivery_days,
    EXTRACT(DAY FROM (o.order_delivered_carrier_date - o.order_purchase_timestamp)) AS processing_days,
    EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_delivered_carrier_date)) AS shipping_days,
    
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 
        ELSE 0 
    END AS is_late,
    
    i.total_items,
    i.total_order_value,
    i.total_freight_value,
    r.avg_review_score
FROM staging_orders o
JOIN item_aggregates i ON o.order_id = i.order_id
LEFT JOIN review_aggregates r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL;