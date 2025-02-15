-- Completed Orders in August 2023  
SELECT  
    P.product_id,  
    P.product_type_id,  
    OH.product_store_id,  
    OI.quantity AS total_quantity,  
    P.internal_name,  
    F.facility_id,  
    OH.external_id,  
    F.facility_type_id,  
    OHI.order_history_id,  
    OH.order_id,  
    OI.order_item_seq_id,  
    OISG.ship_group_seq_id  
FROM order_header AS OH  
JOIN order_item AS OI ON OI.order_id = OH.order_id  
JOIN order_status AS OS ON OS.order_id = OH.order_id  
    AND OH.status_id = 'ORDER_COMPLETED'  
    AND OS.status_id = 'ORDER_COMPLETED'  
JOIN product AS P ON P.product_id = OI.product_id  
JOIN order_item_ship_group AS OISG ON OI.order_id = OISG.order_id  
    AND OI.ship_group_seq_id = OISG.ship_group_seq_id  
JOIN facility AS F ON F.facility_id = OISG.facility_id  
JOIN order_history AS OHI ON OH.order_id = OHI.order_id  
    AND OI.order_item_seq_id = OHI.order_item_seq_id  
WHERE OS.status_datetime BETWEEN '2023-08-01' AND '2023-08-31';  
