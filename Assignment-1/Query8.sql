-- Payment Captured but Not Shipped  
SELECT  
    OH.order_id,  
    OH.status_id AS order_status,  
    OPP.status_id AS payment_status,  
    S.status_id AS shipment_status  
FROM order_header AS OH  
JOIN order_payment_preference AS OPP ON OH.order_id = OPP.order_id  
JOIN order_shipment AS OS ON OH.order_id = OS.order_id  
JOIN shipment AS S ON OS.shipment_id = S.shipment_id  
WHERE S.status_id != 'SHIPMENT_SHIPPED'  
AND OPP.status_id = 'PAYMENT_RECEIVED';  
