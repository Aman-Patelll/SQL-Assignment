-- Items Where QOH and ATP Differ
-- Business Problem:
-- Sometimes the Quantity on Hand (QOH) doesn’t match the Available to Promise (ATP) due to pending orders, reservations, or data discrepancies. This needs review for accurate fulfillment planning.

-- Fields to Retrieve:

-- PRODUCT_ID
-- FACILITY_ID
-- QOH (Quantity on Hand)
-- ATP (Available to Promise)
-- DIFFERENCE (QOH - ATP)
    
SELECT  
    product_id,  
    facility_id,  
    quantity_on_hand_total AS qoh,  
    available_to_promise_total AS atp,  
    (quantity_on_hand_total - available_to_promise_total) AS difference  
FROM inventory_item  
WHERE quantity_on_hand_total != available_to_promise_total  
ORDER BY difference DESC;  
