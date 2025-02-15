-- Total Orders by Sales Channel  
SELECT  
    sales_channel_enum_id AS sales_channel,  
    COUNT(order_id) AS total_orders,  
    SUM(grand_total) AS total_revenue,  
    CONCAT(MIN(order_date), ' to ', MAX(order_date)) AS reporting_period  
FROM order_header  
GROUP BY sales_channel_enum_id  
ORDER BY total_orders DESC;  
