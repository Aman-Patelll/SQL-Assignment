-- Shipping Addresses for October 2023 Orders  
SELECT  
    OH.order_id,  
    P.party_id,  
    P.first_name,  
    P.last_name,  
    PA.address1 AS street_address,  
    PA.city,  
    PA.state_province_geo_id AS state_province,  
    PA.postal_code,  
    PA.country_geo_id AS country_code,  
    OH.status_id AS order_status,  
    OH.order_date  
FROM order_contact_mech AS OCM  
JOIN order_header AS OH ON OCM.order_id = OH.order_id  
JOIN party_contact_mech AS PCM ON PCM.contact_mech_id = OCM.contact_mech_id  
JOIN person AS P ON P.party_id = PCM.party_id  
JOIN postal_address AS PA ON PA.contact_mech_id = PCM.contact_mech_id  
WHERE OCM.contact_mech_purpose_type_id = 'SHIPPING_LOCATION'  
And OH.status_id = 'ORDER_COMPLETED'
AND OH.order_date BETWEEN '2023-10-01' AND '2023-10-31';  
