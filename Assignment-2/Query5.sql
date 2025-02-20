-- Lost and Damaged Inventory  
SELECT  
    II.inventory_item_id,  
    II.product_id,  
    II.facility_id,  
    ABS(IID.quantity_on_hand_diff) AS quantity_lost_or_damaged,  
    IID.reason_enum_id AS reason_code,  
    IID.effective_date AS transaction_date  
FROM inventory_item AS II  
JOIN inventory_item_detail AS IID ON II.inventory_item_id = IID.inventory_item_id  
WHERE IID.quantity_on_hand_diff < 0  
AND IID.reason_enum_id IN ('VAR_DAMAGED', 'VAR_STOLEN', 'VAR_LOST')  
ORDER BY IID.effective_date DESC;  
