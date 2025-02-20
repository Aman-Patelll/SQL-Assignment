-- Retrieve the Current Facility (Physical or Virtual) of Open Orders  
SELECT  
    OH.order_id,  
    OH.status_id AS order_status,  
    F.facility_id,  
    F.facility_name,  
    F.facility_type_id  
FROM order_header AS OH  
JOIN order_item_ship_group AS OISG ON OH.order_id = OISG.order_id  
JOIN facility AS F ON OISG.facility_id = F.facility_id  
WHERE OH.status_id IN ('ORDER_APPROVED', 'ORDER_CREATED', 'ORDER_PROCESSING')  
ORDER BY OH.order_id;  
