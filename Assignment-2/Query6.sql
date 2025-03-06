-- Low Stock or Out of Stock Items Report
-- Business Problem:
-- Avoiding out-of-stock situations is critical. This report flags items that have fallen below a certain reorder threshold or have zero available stock.

-- Fields to Retrieve:

-- PRODUCT_ID
-- PRODUCT_NAME
-- FACILITY_ID
-- QOH (Quantity on Hand)
-- ATP (Available to Promise)
-- REORDER_THRESHOLD
-- DATE_CHECKED
    
SELECT  
    P.product_id,  
    P.product_name,  
    PF.facility_id,  
    II.quantity_on_hand_total AS qoh,  
    II.available_to_promise_total AS atp,  
    PF.minimum_stock AS reorder_threshold,  
    CURRENT_DATE AS date_checked  
FROM product AS P  
JOIN inventory_item AS II ON P.product_id = II.product_id  
JOIN product_facility AS PF ON P.product_id = PF.product_id  
WHERE II.quantity_on_hand_total <= PF.minimum_stock  
   OR II.available_to_promise_total <= PF.minimum_stock  
ORDER BY PF.minimum_stock DESC;  
