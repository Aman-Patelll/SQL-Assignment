-- Orders Completed Hourly  
SELECT  
    COUNT(order_id) AS total_orders,  
    HOUR(status_datetime) AS hour  
FROM order_status  
WHERE status_id = 'ORDER_COMPLETED'  
GROUP BY hour;  
