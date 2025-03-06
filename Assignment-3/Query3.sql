-- 3 Single-Return Orders (Last Month)
-- Business Problem:
-- The mechandising team needs a list of orders that only have one return.

-- Fields to Retrieve:

-- PARTY_ID
-- FIRST_NAME

SELECT  
    PER.first_name,  
    RH.from_party_id  
FROM return_item RI  
JOIN return_header RH ON RI.return_id = RH.return_id  
JOIN person PER ON PER.party_id = RH.from_party_id  
WHERE (RH.return_date >= DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01')  
AND RH.return_date < DATE_FORMAT(CURDATE(), '%Y-%m-01'))  
AND RI.order_id IN (  
    SELECT order_id  
    FROM return_item  
    GROUP BY order_id  
    HAVING COUNT(*) = 1  
)  
ORDER BY RH.from_party_id;
