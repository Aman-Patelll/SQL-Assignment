-- Low Stock or Out of Stock Items Report  
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
    AND II.facility_id = PF.facility_id  
WHERE II.quantity_on_hand_total <= PF.minimum_stock  
   OR II.available_to_promise_total <= PF.minimum_stock  
ORDER BY PF.minimum_stock DESC;  
