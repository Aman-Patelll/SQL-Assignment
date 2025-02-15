-- Orders with Multiple Returns  
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
