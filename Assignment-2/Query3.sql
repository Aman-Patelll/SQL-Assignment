-- Top-Selling Product in New York  
SELECT  
    P.product_id,  
    P.internal_name,  
    SUM(OI.quantity) AS total_quantity_sold,  
    SUM(OI.unit_price * OI.quantity) AS revenue,  
    PA.city,  
    PA.state_province_geo_id AS state  
FROM order_item AS OI  
JOIN product AS P ON P.product_id = OI.product_id  
JOIN order_header AS OH ON OH.order_id = OI.order_id  
JOIN order_contact_mech AS OCM ON OCM.order_id = OI.order_id  
JOIN postal_address AS PA ON PA.contact_mech_id = OCM.contact_mech_id  
WHERE PA.city = 'New York'  
GROUP BY P.product_id, P.internal_name, PA.city, PA.state_province_geo_id  
ORDER BY total_quantity_sold DESC;
