-- 5 Detailed Return Information
-- Business Problem:
-- Certain teams need granular return data (reason, date, refund amount) for analyzing return rates, identifying recurring issues, or updating policies.

-- Fields to Retrieve:

-- RETURN_ID
-- ENTRY_DATE
-- RETURN_ADJUSTMENT_TYPE_ID (refund type, store credit, etc.)
-- AMOUNT
-- COMMENTS
-- ORDER_ID
-- ORDER_DATE
-- RETURN_DATE
-- PRODUCT_STORE_ID
    
SELECT  
    RH.return_id,  
    RH.entry_date,  
    RA.return_adjustment_type_id,  
    RA.amount,  
    RA.comments,  
    OH.order_id,  
    OH.order_date,  
    RH.return_date,  
    OH.product_store_id  
FROM return_header AS RH  
JOIN return_item AS RI ON RH.return_id = RI.return_id  
JOIN return_adjustment AS RA ON RH.return_id = RA.return_id  
JOIN order_header AS OH ON RI.order_id = OH.order_id;  
