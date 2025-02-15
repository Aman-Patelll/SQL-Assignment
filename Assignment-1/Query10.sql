-- BOPIS Orders Revenue (Last Year)  
SELECT  
    COUNT(OH.order_id) AS total_orders,  
    SUM(OH.grand_total) AS total_revenue  
FROM order_header AS OH  
JOIN order_item_ship_group AS OISG ON OH.order_id = OISG.order_id  
WHERE OISG.shipment_method_type_id = 'STOREPICKUP'  
AND OH.order_date BETWEEN '2024-02-11' AND '2025-02-11';  
