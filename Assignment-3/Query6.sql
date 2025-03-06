-- 6 Orders with Multiple Returns
-- Business Problem:
-- Analyzing orders with multiple returns can identify potential fraud, chronic issues with certain items, or inconsistent shipping processes.

-- Fields to Retrieve:

-- ORDER_ID
-- RETURN_ID
-- RETURN_DATE
-- RETURN_REASON
-- RETURN_QUANTITY
    
SELECT DISTINCT  
    RI.order_id,  
    RI.return_id,  
    DATE(RH.return_date) AS return_date,  
    RI.reason AS return_reason,  
    RI.return_quantity  
FROM return_header AS RH  
JOIN return_item AS RI ON RH.return_id = RI.return_id  
WHERE (  
    SELECT COUNT(*)  
    FROM return_item AS RI2  
    WHERE RI2.order_id = RI.order_id  
) > 1  
ORDER BY RI.order_id, return_date DESC;  
