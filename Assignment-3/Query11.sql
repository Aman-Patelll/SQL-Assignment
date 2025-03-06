-- 11 Transfer Orders Without Inventory Reservation
-- Business Problem:
-- When transferring stock between facilities, the system should reserve inventory. If it isn’t reserved, the transfer may fail or oversell.

-- Fields to Retrieve:

-- TRANSFER_ORDER_ID
-- FROM_FACILITY_ID
-- TO_FACILITY_ID
-- PRODUCT_ID
-- REQUESTED_QUANTITY
-- RESERVED_QUANTITY
-- TRANSFER_DATE
-- STATUS


SELECT  
    IT.inventory_transfer_id,  
    IT.facility_id,  
    IT.facility_id_to,  
    II.product_id,  
    IT.quantity AS requested_quantity,  
    OISGIR.quantity AS reserved_quantity,  
    IT.send_date,  
    IT.status_id  
FROM inventory_transfer IT  
JOIN inventory_item II ON II.inventory_item_id = IT.inventory_item_id  
JOIN order_item_ship_grp_inv_res OISGIR ON OISGIR.inventory_item_id = IT.inventory_item_id;
