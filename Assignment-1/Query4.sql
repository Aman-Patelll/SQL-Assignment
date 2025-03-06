-- 4 Product IDs Across Systems
-- Business Problem:
-- To sync an order or product across multiple systems (e.g., Shopify, HotWax, ERP/NetSuite), the OMS needs to know each system’s unique identifier for that product. This query retrieves the Shopify ID, HotWax ID, and ERP ID (NetSuite ID) for all products.

-- Fields to Retrieve:

-- PRODUCT_ID (internal OMS ID)
-- SHOPIFY_ID
-- HOTWAX_ID
-- ERP_ID or NETSUITE_ID (depending on naming)

SELECT  
    GI.product_id,  
    MAX(CASE WHEN GI.good_identification_type_id = 'SHOPIFY_PROD_ID' THEN GI.id_value END) AS shopify_id,  
    MAX(CASE WHEN GI.good_identification_type_id = 'ERP_ID' THEN GI.id_value END) AS netsuite_id,  
    MAX(CASE WHEN GI.good_identification_type_id = 'HC_GOOD_ID_TYPE' THEN GI.id_value END) AS hotwax_id  
FROM good_identification AS GI  
WHERE GI.good_identification_type_id IN ('SHOPIFY_PROD_ID', 'ERP_ID', 'HC_GOOD_ID_TYPE')  
GROUP BY GI.product_id;  

SELECT  
    P.product_id,  
    GI.id_value AS NetSuitId,  
    SP.shopify_product_id AS shopify_id  
FROM product P
LEFT JOIN good_identification GI ON P.product_id = GI.product_id  
JOIN shopify_product SP ON SP.product_id = P.product_id  
WHERE GI.id_value IS NOT NULL  
AND GI.good_identification_type_id = 'ERP_ID';
