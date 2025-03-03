-- 10 BOPIS Orders Revenue (Last Year)
-- Business Problem:
-- BOPIS (Buy Online, Pickup In Store) is a key retail strategy. Finance wants to know the revenue from BOPIS orders for the previous year.

-- Fields to Retrieve:

-- TOTAL ORDERS
-- TOTAL REVENUE

SELECT  
    COUNT(OH.order_id) AS total_orders,  
    SUM(OH.grand_total) AS total_revenue  
FROM order_header AS OH  
JOIN order_item_ship_group AS OISG ON OH.order_id = OISG.order_id  
WHERE OISG.shipment_method_type_id = 'STOREPICKUP'  
AND YEAR(OH.order_date) = YEAR(current_date()) - 1;  
