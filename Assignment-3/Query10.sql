-- Total Items in Various Virtual Facilities  
SELECT  
    II.product_id,  
    II.facility_id,  
    F.facility_type_id,  
    II.quantity_on_hand_total AS qoh,  
    II.available_to_promise_total AS atp  
FROM inventory_item AS II  
JOIN facility AS F ON II.facility_id = F.facility_id  
WHERE F.facility_type_id = 'VIRTUAL_FACILITY';  
