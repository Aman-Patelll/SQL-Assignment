-- Product IDs Across Systems  
SELECT  
    GI.product_id,  
    MAX(CASE WHEN GI.good_identification_type_id = 'SHOPIFY_PROD_ID' THEN GI.id_value END) AS shopify_id,  
    MAX(CASE WHEN GI.good_identification_type_id = 'ERP_ID' THEN GI.id_value END) AS netsuite_id,  
    MAX(CASE WHEN GI.good_identification_type_id = 'HC_GOOD_ID_TYPE' THEN GI.id_value END) AS hotwax_id  
FROM good_identification AS GI  
WHERE GI.good_identification_type_id IN ('SHOPIFY_PROD_ID', 'ERP_ID', 'HC_GOOD_ID_TYPE')  
GROUP BY GI.product_id;  
