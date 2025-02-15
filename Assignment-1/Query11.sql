-- Canceled Orders (Last Month)  
SELECT  
    COUNT(OS.order_id) AS total_orders,  
    OS.change_reason  
FROM order_status AS OS  
WHERE OS.status_id = 'ORDER_CANCELLED'  
AND OS.status_datetime BETWEEN '2025-01-01' AND '2025-01-31'  
GROUP BY OS.change_reason;  
