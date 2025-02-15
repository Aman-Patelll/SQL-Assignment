-- Order Item Current Status Changed Date-Time  
SELECT  
    order_id,  
    order_item_seq_id,  
    status_id AS current_status_id,  
    status_datetime AS status_change_datetime,  
    status_user_login AS changed_by  
FROM order_status  
ORDER BY status_change_datetime DESC;  
