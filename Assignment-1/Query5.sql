-- 5 Completed Orders in August 2023
-- Business Problem:
-- After running similar reports for a previous month, you now need all completed orders in August 2023 for analysis.

-- Fields to Retrieve:

-- PRODUCT_ID
-- PRODUCT_TYPE_ID
-- PRODUCT_STORE_ID
-- TOTAL_QUANTITY
-- INTERNAL_NAME
-- FACILITY_ID
-- EXTERNAL_ID
-- FACILITY_TYPE_ID
-- ORDER_HISTORY_ID
-- ORDER_ID
-- ORDER_ITEM_SEQ_ID
-- SHIP_GROUP_SEQ_ID


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
JOIN product AS P ON P.product_id = OI.product_id  
JOIN order_item_ship_group AS OISG ON OI.order_id = OISG.order_id  
JOIN facility AS F ON F.facility_id = OISG.facility_id  
JOIN order_history AS OHI ON OH.order_id = OHI.order_id  
JOIN order_status OS ON OH.status_id = OS.status_id
WHERE OH.status_id = 'ORDER_COMPLETED' AND OS.status_datetime BETWEEN '2023-08-01' AND '2023-08-31'; 
