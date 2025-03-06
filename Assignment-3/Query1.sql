-- Completed Sales Orders (Physical Items)  
SELECT  DISTINCT
    OH.order_id,  
    OI.order_item_seq_id,  
    OI.product_id,  
    P.product_type_id,  
    OH.sales_channel_enum_id,  
    OH.order_date,  
    OH.entry_date,  
    OH.status_id,  
    OS.status_datetime,  
    OH.order_type_id,  
    OH.product_store_id  
FROM order_header AS OH  
JOIN order_item AS OI ON OH.order_id = OI.order_id  
JOIN product AS P ON OI.product_id = P.product_id  
JOIN product_type AS PT ON P.product_type_id = PT.product_type_id  
JOIN order_status AS OS ON OH.order_id = OS.order_id  
WHERE OH.status_id = 'ORDER_COMPLETED'  
AND PT.is_physical = 'Y' 
AND oh.order_type_id = 'SALES_ORDER' 
ORDER BY OH.order_date DESC;  
