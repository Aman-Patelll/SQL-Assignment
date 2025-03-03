-- Order Item Current Status Changed Date-Time
-- Business Problem:
-- Operations teams need to audit when an order item’s status (e.g., from “Pending” to “Shipped”) was last changed, for shipment tracking or dispute resolution.

-- Fields to Retrieve:

-- ORDER_ID
-- ORDER_ITEM_SEQ_ID
-- CURRENT_STATUS_ID
-- STATUS_CHANGE_DATETIME
-- CHANGED_BY
    
SELECT  
    order_id,  
    order_item_seq_id,  
    status_id AS current_status_id,  
    status_datetime AS status_change_datetime,  
    status_user_login AS changed_by  
FROM order_status  
ORDER BY status_change_datetime DESC;  
