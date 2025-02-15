-- Returns and Appeasements  
SELECT  
    COUNT(DISTINCT RH.return_id) AS total_returns,  
    SUM(RI.return_price * RI.return_quantity) AS returns_total,  
    COUNT(RA.return_id) AS total_appeasements,  
    SUM(RA.amount) AS appeasements_total  
FROM return_header AS RH  
LEFT JOIN return_item AS RI ON RH.return_id = RI.return_id  
LEFT JOIN return_adjustment AS RA ON RH.return_id = RA.return_id;  
