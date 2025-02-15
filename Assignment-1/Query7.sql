-- Newly Created Sales Orders and Payment Methods  
SELECT DISTINCT  
    OH.order_id,  
    OH.grand_total AS total_amount,  
    OPP.payment_method_type_id AS payment_method,  
    OI.external_id AS shopify_id  
FROM order_header AS OH  
JOIN order_item AS OI ON OH.order_id = OI.order_id  
LEFT JOIN order_payment_preference AS OPP ON OPP.order_id = OH.order_id  
WHERE OH.status_id = 'ORDER_CREATED'  
AND OH.order_type_id = 'SALES_ORDER';  

