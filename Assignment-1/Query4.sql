-- 4 Product IDs Across Systems
-- Business Problem:
-- To sync an order or product across multiple systems (e.g., Shopify, HotWax, ERP/NetSuite), the OMS needs to know each system’s unique identifier for that product. This query retrieves the Shopify ID, HotWax ID, and ERP ID (NetSuite ID) for all products.

-- Fields to Retrieve:

-- PRODUCT_ID (internal OMS ID)
-- SHOPIFY_ID
-- HOTWAX_ID
-- ERP_ID or NETSUITE_ID (depending on naming)

SELECT 
    DISTINCT P.product_id AS Hotwax_id,
    GI_ERP.id_value as NetsuitId,
    GI_SHOPIFY.id_value as ShopifyId
FROM product P
JOIN (SELECT id_value, product_id FROM good_identification GI WHERE GI.good_identification_type_id='ERP_ID') AS GI_ERP ON GI_ERP.product_id = P.product_id
JOIN (SELECT id_value, product_id FROM good_identification GI WHERE GI.good_identification_type_id='SHOPIFY_PROD_ID') AS GI_SHOPIFY ON GI_SHOPIFY.product_id = P.product_id;
