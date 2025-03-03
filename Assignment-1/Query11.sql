-- 11 Canceled Orders (Last Month)
-- Business Problem:
-- The merchandising team needs to know how many orders were canceled in the previous month and their reasons.

-- Fields to Retrieve:

-- TOTAL ORDERS
-- CANCELATION REASON
    
SELECT  
    COUNT(OS.order_id) AS total_orders,  
    OS.change_reason  
FROM order_status AS OS  
WHERE OS.status_id = 'ORDER_CANCELLED'  
AND month(OS.status_datetime) BETWEEN month(current_date)-1 AND month(current_date)
AND year(os.status_datetime)=year(current_date)
GROUP BY OS.change_reason;  
