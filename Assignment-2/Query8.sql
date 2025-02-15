-- Items Where QOH and ATP Differ  
SELECT  
    product_id,  
    facility_id,  
    quantity_on_hand_total AS qoh,  
    available_to_promise_total AS atp,  
    (quantity_on_hand_total - available_to_promise_total) AS difference  
FROM inventory_item  
WHERE quantity_on_hand_total != available_to_promise_total  
ORDER BY difference DESC;  
