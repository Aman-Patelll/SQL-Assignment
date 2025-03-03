-- 3 Products Missing NetSuite ID
-- Business Problem:
-- A product cannot sync to NetSuite unless it has a valid NetSuite ID. The OMS needs a list of all products that still need to be created or updated in NetSuite.

-- Fields to Retrieve:

-- PRODUCT_ID
-- INTERNAL_NAME
-- PRODUCT_TYPE_ID
-- NETSUITE_ID (or similar field indicating the NetSuite ID; may be NULL or empty if missing)
    
SELECT  
    P.product_id,  
    P.internal_name,  
    P.product_type_id,  
    GI.id_value AS netsuite_id  
FROM product AS P  
LEFT JOIN good_identification AS GI ON P.product_id = GI.product_id  
WHERE GI.good_identification_type_id = 'ERP_ID'  
AND (GI.id_value IS NULL OR GI.id_value = '');  
