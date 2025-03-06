-- 4 Returns and Appeasements
-- Business Problem:
-- The retailer needs the total amount of items, were returned as well as how many appeasements were issued.

-- Fields to Retrieve:

-- TOTAL RETURNS
-- RETURN $ TOTAL
-- TOTAL APPEASEMENTS
-- APPEASEMENTS $ TOTAL
    
SELECT  
    COUNT(RI.return_id) AS Total_Return,  
    SUM(RI.return_price * RI.return_quantity) AS Return_Total,  
    COUNT(A.return_id) AS Total_appeasement,  
    SUM(A.amount) AS appeasement_Total  
FROM return_item RI  
LEFT JOIN return_adjustment A ON A.return_id = RI.return_id  AND A.return_adjustment_type_id = 'APPEASEMENT';
