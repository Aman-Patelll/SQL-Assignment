-- 7 Newly Created Sales Orders and Payment Methods
-- Business Problem:
-- Finance teams need to see new orders and their payment methods for reconciliation and fraud checks.

-- Fields to Retrieve:

-- ORDER_ID
-- TOTAL_AMOUNT
-- PAYMENT_METHOD
-- Shopify Order ID (if applicable)
    
SELECT DISTINCT  
    OH.order_id,  
    OH.grand_total AS total_amount,  
    OPP.payment_method_type_id AS payment_method,  
    OH.external_id AS shopify_id  
FROM order_header AS OH  
JOIN order_payment_preference AS OPP ON OPP.order_id = OH.order_id  
WHERE OH.status_id = 'ORDER_CREATED'  
AND OH.order_type_id = 'SALES_ORDER';  
