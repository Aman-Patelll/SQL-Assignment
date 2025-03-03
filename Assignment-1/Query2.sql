-- 2 List All Active Physical Products
-- Business Problem:
-- Merchandising teams often need a list of all physical products to manage logistics, warehousing, and shipping.

-- Fields to Retrieve:

-- PRODUCT_ID
-- PRODUCT_TYPE_ID
-- INTERNAL_NAME

SELECT  
    P.product_id,  
    P.product_type_id,  
    P.internal_name  
FROM product AS P  
INNER JOIN product_type AS PT ON P.product_type_id = PT.product_type_id  
WHERE PT.is_physical = 'Y'  
AND P.sales_discontinuation_date IS NULL;  
