-- Detailed Return Information  
SELECT  
    RH.return_id,  
    RH.entry_date,  
    RA.return_adjustment_type_id,  
    RA.amount,  
    RA.comments,  
    OH.order_id,  
    OH.order_date,  
    RH.return_date,  
    OH.product_store_id  
FROM return_header AS RH  
JOIN return_item AS RI ON RH.return_id = RI.return_id  
JOIN return_adjustment AS RA ON RH.return_id = RA.return_id  
JOIN order_header AS OH ON RI.order_id = OH.order_id;  
