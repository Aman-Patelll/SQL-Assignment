-- Orders Without Picklist  
SELECT  
    OH.order_id,  
    OH.order_date,  
    OH.status_id AS order_status,  
    OISG.facility_id,  
    hour(OH.order_date - OISG.created_stamp) AS duration  
FROM order_header AS OH  
JOIN order_item_ship_group AS OISG ON OH.order_id = OISG.order_id  
LEFT JOIN picklist_bin AS PB ON OH.order_id = PB.primary_order_id  -- Check if a picklist exists  
WHERE PB.picklist_bin_id IS NULL;  
