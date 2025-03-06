-- 5.3 Top-Selling Product in New York
-- Business Problem:
-- Merchandising teams need to identify the best-selling product(s) in a specific region (New York) for targeted restocking or promotions.

-- Fields to Retrieve:

-- PRODUCT_ID
-- INTERNAL_NAME
-- TOTAL_QUANTITY_SOLD
-- CITY / STATE (within New York region)
-- REVENUE (optionally, total sales amount)
    
SELECT  
    P.product_id,  
    P.internal_name,  
    SUM(OI.quantity) AS total_quantity_sold,  
    SUM(OI.unit_price * OI.quantity) AS revenue,  
    PA.city,  
    PA.state_province_geo_id AS state  
FROM order_item AS OI  
JOIN product AS P ON P.product_id = OI.product_id   
JOIN order_contact_mech AS OCM ON OCM.order_id = OI.order_id  
JOIN postal_address AS PA ON PA.contact_mech_id = OCM.contact_mech_id  
WHERE PA.city = 'New York'  
GROUP BY P.product_id, P.internal_name, PA.city, PA.state_province_geo_id  
ORDER BY total_quantity_sold DESC;
