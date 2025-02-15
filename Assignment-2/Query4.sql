-- Store-Specific (Facility-Wise) Revenue  
SELECT  
    F.facility_id,  
    F.facility_name,  
    COUNT(DISTINCT OH.order_id) AS total_orders,  
    SUM(OH.grand_total) AS total_revenue,  
    CONCAT(MIN(OH.order_date), ' to ', MAX(OH.order_date)) AS date_range  
FROM order_header AS OH  
JOIN order_item AS OI ON OH.order_id = OI.order_id  
JOIN order_item_ship_group AS OISG ON OI.order_id = OISG.order_id  
JOIN facility AS F ON OISG.facility_id = F.facility_id  
GROUP BY F.facility_id, F.facility_name  
ORDER BY total_revenue DESC;  
