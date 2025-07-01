-- 8 Payment Captured but Not Shipped
-- Business Problem:
-- Finance teams want to ensure revenue is recognized properly. If payment is captured but no shipment has occurred, it warrants further review.

-- Fields to Retrieve:

-- ORDER_ID
-- ORDER_STATUS
-- PAYMENT_STATUS
-- SHIPMENT_STATUS

SELECT  
    OH.order_id,  
    OH.status_id AS order_status,  
    OPP.status_id AS payment_status,  
    S.status_id AS shipment_status  
FROM order_header AS OH  
JOIN order_payment_preference AS OPP ON OH.order_id = OPP.order_id  
LEFT JOIN order_shipment AS OS ON OH.order_id = OS.order_id  
LEFT JOIN shipment AS S ON OS.shipment_id = S.shipment_id  
WHERE S.status_id != 'SHIPMENT_SHIPPED' AND S.status_id != 'SHIPMENT_DELIVERED' 
AND OPP.status_id = 'PAYMENT_SETTLED'
ORDER BY OH.order_date;
