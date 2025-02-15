-- Products Missing NetSuite ID  
SELECT  
    P.product_id,  
    P.internal_name,  
    P.product_type_id,  
    GI.id_value AS netsuite_id  
FROM product AS P  
JOIN good_identification AS GI ON P.product_id = GI.product_id  
WHERE GI.good_identification_type_id = 'ERP_ID'  
AND (GI.id_value IS NULL OR GI.id_value = '');  
