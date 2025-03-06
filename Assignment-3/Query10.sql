-- 10 Total Items in Various Virtual Facilities
-- Business Problem:
-- Retailers need to study the relation of inventory levels of products to the type of facility it's stored at. Retrieve all inventory levels for products at locations and include the facility type Id. Do not retrieve facilities that are of type Virtual.

-- Fields to Retrieve:

-- PRODUCT_ID
-- FACILITY_ID
-- FACILITY_TYPE_ID
-- QOH (Quantity on Hand)
-- ATP (Available to Promise)

SELECT  
    II.product_id,  
    II.facility_id,  
    F.facility_type_id,  
    II.quantity_on_hand_total AS qoh,  
    II.available_to_promise_total AS atp  
FROM inventory_item AS II  
JOIN facility AS F ON II.facility_id = F.facility_id  
WHERE F.facility_type_id = 'VIRTUAL_FACILITY';  
