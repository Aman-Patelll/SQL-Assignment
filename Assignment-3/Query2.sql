-- Completed Return Items  
SELECT DISTINCT  
    RH.return_id,  
    OH.order_id,  
    OH.product_store_id,  
    DATE(RS.status_datetime) AS status_datetime,  
    OH.order_name,  
    RH.from_party_id,  
    DATE(RH.return_date) AS return_date,  
    DATE(RH.entry_date) AS entry_date,  
    RH.return_channel_enum_id  
FROM return_header AS RH  
JOIN return_item AS RI ON RH.return_id = RI.return_id  
JOIN return_status AS RS ON RI.return_id = RS.return_id  
JOIN order_header AS OH ON OH.order_id = RI.order_id  
WHERE RH.status_id = 'RETURN_COMPLETED';  
