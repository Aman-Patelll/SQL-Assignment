-- Store with Most One-Day Shipped Orders (Last Month)  
SELECT  
    F.facility_id,  
    F.facility_name,  
    COUNT(OISG.order_id) AS total_one_day_shipped_orders,  
    CONCAT(MIN(OISG.estimated_ship_date), ' to ', MAX(OISG.estimated_ship_date)) AS reporting_period  
FROM order_item_ship_group AS OISG  
JOIN order_shipment AS OS ON OS.order_id = OISG.order_id  
JOIN shipment AS S ON S.shipment_id = OS.shipment_id  
JOIN facility AS F ON F.facility_id = OISG.facility_id  
WHERE OISG.shipment_method_type_id = 'NEXT_DAY'  
AND S.status_id = 'SHIPMENT_SHIPPED'  
AND OISG.created_stamp BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01')  
    AND LAST_DAY(CURDATE() - INTERVAL 1 MONTH)  
GROUP BY F.facility_id
ORDER BY total_one_day_shipped_orders DESC  
LIMIT 1;  
