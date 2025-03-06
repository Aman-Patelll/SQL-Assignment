-- 12 Orders Without Picklist
-- Business Problem:
-- A picklist is necessary for warehouse staff to gather items. Orders missing a picklist might be delayed and need attention.

-- Fields to Retrieve:

-- ORDER_ID
-- ORDER_DATE
-- ORDER_STATUS
-- FACILITY_ID
-- DURATION (How long has the order been assigned at the facility)

SELECT  
    OI.order_id,  
    OH.order_date,  
    OI.status_id,  
    OISG.facility_id,  
    CONCAT(MIN(OISGIR.reserved_datetime), ' to ', MAX(OISGIR.reserved_datetime)) AS duration  
FROM order_item OI  
JOIN order_item_ship_group OISG ON OISG.order_id = OI.order_id  
JOIN order_item_ship_grp_inv_res OISGIR  
    ON OISGIR.order_id = OI.order_id  
    AND OISGIR.order_item_seq_id = OI.order_item_seq_id  
    AND OISGIR.ship_group_seq_id = OISG.ship_group_seq_id  
JOIN order_header OH ON OH.order_id = OI.order_id  
LEFT JOIN picklist_item PLI  
    ON PLI.order_id = OI.order_id  
    AND PLI.order_item_seq_id = OI.order_item_seq_id  
    AND PLI.ship_group_seq_id = OISGIR.ship_group_seq_id  
    AND PLI.inventory_item_id = OISGIR.inventory_item_id  
WHERE PLI.picklist_bin_id IS NULL  
GROUP BY OI.order_id, OH.order_date, OI.status_id, OISG.facility_id;
