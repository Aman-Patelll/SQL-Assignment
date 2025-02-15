-- Total Facilities That Sell the Product  
SELECT  
    P.product_id,  
    P.product_name,  
    COUNT(DISTINCT F.facility_id) AS facility_count  
FROM product AS P  
JOIN inventory_item AS II ON P.product_id = II.product_id  
JOIN facility AS F ON F.facility_id = II.facility_id  
GROUP BY P.product_id, P.product_name  
ORDER BY facility_count DESC;  
