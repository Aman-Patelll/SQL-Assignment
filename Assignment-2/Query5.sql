--  Lost and Damaged Inventory
-- Business Problem:
-- Warehouse managers need to track “shrinkage” such as lost or damaged inventory to reconcile physical vs. system counts.

-- Fields to Retrieve:

-- INVENTORY_ITEM_ID
-- PRODUCT_ID
-- FACILITY_ID
-- QUANTITY_LOST_OR_DAMAGED
-- REASON_CODE (Lost, Damaged, Expired, etc.)
-- TRANSACTION_DATE
     
SELECT  
    PR.product_id,  
    II.inventory_item_id,  
    IIV.variance_reason_id,  
    II.facility_id,  
    COUNT(PR.product_id) AS product_total  
FROM product PR  
JOIN inventory_item II ON II.product_id = PR.product_id  
JOIN inventory_item_variance IIV ON IIV.inventory_item_id = II.inventory_item_id  
WHERE IIV.variance_reason_id IS NOT NULL  
AND (IIV.variance_reason_id = 'VAR_LOST' OR IIV.variance_reason_id = 'VAR_DAMAGED')  
GROUP BY II.facility_id, PR.product_id, IIV.variance_reason_id, II.inventory_item_id;
