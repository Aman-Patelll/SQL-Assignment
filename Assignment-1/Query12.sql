-- 12 Product Threshold Value
-- Business Problem The retailer has set a threshild value for products that are sold online, in order to avoid over selling.

-- Fields to Retrieve:

-- PRODUCT ID
-- THRESHOLD
  
SELECT  
    PR.product_id,  
    PF.minimum_stock AS Threshold  
FROM product PR  
JOIN product_facility PF ON PR.product_id = PF.product_id  
JOIN facility F ON F.facility_id = PF.facility_id  
WHERE F.facility_type_id = 'CONFIGURATION'  
ORDER BY PF.minimum_stock DESC;
