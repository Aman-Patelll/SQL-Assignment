--  Store-Specific (Facility-Wise) Revenue
-- Business Problem:
-- Different physical or online stores (facilities) may have varying levels of performance. The business wants to compare revenue across facilities for sales planning and budgeting.

-- Fields to Retrieve:

-- FACILITY_ID
-- FACILITY_NAME
-- TOTAL_ORDERS
-- TOTAL_REVENUE
-- DATE_RANGE
     
SELECT  
    F.facility_id,  
    F.facility_name,  
    COUNT(DISTINCT OH.order_id) AS total_orders,  
    SUM(OH.grand_total) AS total_revenue,  
    CONCAT(MIN(OH.order_date), ' to ', MAX(OH.order_date)) AS date_range  
FROM order_header AS OH  
JOIN order_item_ship_group AS OISG ON OH.order_id = OISG.order_id  
JOIN facility AS F ON OISG.facility_id = F.facility_id  
WHERE OH.status_id='ORDER_COMPLETED'
GROUP BY F.facility_id, F.facility_name  
ORDER BY total_revenue DESC; 
