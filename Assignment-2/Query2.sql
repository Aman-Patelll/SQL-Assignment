-- 5.2 Orders from New York
-- Business Problem:
-- Companies often want region-specific analysis to plan local marketing, staffing, or promotions in certain areas—here, specifically, New York.

-- Fields to Retrieve:

-- ORDER_ID
-- CUSTOMER_NAME
-- STREET_ADDRESS (or shipping address detail)
-- CITY
-- STATE_PROVINCE
-- POSTAL_CODE
-- TOTAL_AMOUNT
-- ORDER_DATE
-- ORDER_STATUS
    
SELECT  
    OH.order_id,  
    P.first_name,  
    P.last_name,  
    PA.address1 AS street_address,  
    PA.city,  
    PA.state_province_geo_id AS state_province,  
    PA.postal_code,  
    OH.grand_total AS total_amount,  
    OH.status_id AS order_status,  
    OH.order_date  
FROM order_contact_mech AS OCM  
JOIN order_header AS OH ON OCM.order_id = OH.order_id  
JOIN party_contact_mech AS PCM ON PCM.contact_mech_id = OCM.contact_mech_id  
JOIN person AS P ON P.party_id = PCM.party_id  
JOIN postal_address AS PA ON PA.contact_mech_id = PCM.contact_mech_id  
WHERE PA.city = 'New York';  
