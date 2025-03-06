-- 9 Total Facilities That Sell the Product
-- Business Problem:
-- Retailers want to see how many (and which) facilities (stores, warehouses, virtual sites) currently offer a product for sale.

-- Fields to Retrieve:

-- PRODUCT_ID
-- PRODUCT_NAME (or INTERNAL_NAME)
-- FACILITY_COUNT (number of facilities selling the product)
-- (Optionally) a list of FACILITY_IDs if more detail is needed

SELECT  
    P.product_id,  
    P.product_name,  
    COUNT(DISTINCT PF.facility_id) AS facility_count  
FROM product AS P  
JOIN product_facility AS PF ON PF.product_id = P.product_id  
GROUP BY P.product_id, P.product_name  
ORDER BY facility_count DESC;  
