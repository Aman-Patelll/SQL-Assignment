-- Retrieve the Current Facility (Physical or Virtual) of Open Orders
-- Business Problem:
-- The business wants to know where open orders are currently assigned, whether in a physical store or a virtual facility (e.g., a distribution center or online fulfillment location).

-- Fields to Retrieve:

-- ORDER_ID
-- ORDER_STATUS
-- FACILITY_ID
-- FACILITY_NAME
-- FACILITY_TYPE_ID
    
SELECT  
    OH.order_id,  
    OH.status_id AS order_status,  
    F.facility_id,  
    F.facility_name,  
    FT.parent_type_id  
FROM order_header AS OH  
JOIN order_item_ship_group AS OISG ON OH.order_id = OISG.order_id  
JOIN facility AS F ON OISG.facility_id = F.facility_id  
JOIN facility_type FT ON FT.facility_type_id = f.facility_type_id
WHERE OH.status_id NOT IN ('ORDER_COMPLETED', 'ORDER_CANCELLED')  AND FT.parent_type_id IN ("VIRTUAL_FACILITY", "PHYSICAL_STORE", "DISTRIBUTION_CENTER")
ORDER BY OH.order_id;  
