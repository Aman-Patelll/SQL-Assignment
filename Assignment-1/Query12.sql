-- Product Threshold Value  
SELECT  
    PF.product_id,  
    PF.minimum_stock AS threshold  
FROM product_facility AS PF  
JOIN facility AS F ON F.facility_id = PF.facility_id  
WHERE F.facility_type_id = 'CONFIGURATION'  
AND PF.minimum_stock IS NOT NULL  
ORDER BY threshold DESC;  
