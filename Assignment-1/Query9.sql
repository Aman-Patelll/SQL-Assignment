-- 9 Orders Completed Hourly
-- Business Problem:
-- Operations teams may want to see how orders complete across the day to schedule staffing.

-- Fields to Retrieve:

-- TOTAL ORDERS
-- HOUR

SELECT  
	HOUR(status_datetime) + 1 AS hour,
    COUNT(order_id) AS total_orders
FROM order_status  
WHERE status_id = 'ORDER_COMPLETED'  
GROUP BY hour
ORDER BY hour;  
