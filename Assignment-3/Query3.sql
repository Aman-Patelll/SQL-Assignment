-- Single-Return Orders (Last Month)  
SELECT  
    P.party_id,  
    PER.first_name,  
    RH.entry_date  
FROM return_header AS RH  
JOIN party AS P ON RH.from_party_id = P.party_id  
JOIN person AS PER ON PER.party_id = P.party_id  
JOIN return_item AS RI ON RI.return_id = RH.return_id  
WHERE RH.entry_date BETWEEN '2025-01-12' AND '2025-02-12'  
AND (  
    SELECT COUNT(*)  
    FROM return_item AS RI2  
    WHERE RI2.order_id = RI.order_id  
) = 1;  -- Ensures only one return per order  
