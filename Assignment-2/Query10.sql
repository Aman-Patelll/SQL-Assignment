--  Total Orders by Sales Channel
-- Business Problem:
-- Marketing and sales teams want to see how many orders come from each channel (e.g., web, mobile app, in-store POS, marketplace) to allocate resources effectively.

-- Fields to Retrieve:

-- SALES_CHANNEL
-- TOTAL_ORDERS
-- TOTAL_REVENUE
-- REPORTING_PERIOD
     
SELECT  
    sales_channel_enum_id AS sales_channel,  
    COUNT(order_id) AS total_orders,  
    SUM(grand_total) AS total_revenue,  
    CONCAT(MIN(order_date), ' to ', MAX(order_date)) AS reporting_period  
FROM order_header  
GROUP BY sales_channel_enum_id  
ORDER BY total_orders DESC;  
