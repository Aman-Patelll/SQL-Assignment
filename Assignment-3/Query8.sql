-- List of Warehouse Pickers  
SELECT  
    P.party_id,  
    CONCAT(PER.first_name, ' ', PER.last_name) AS name,  
    FP.role_type_id,  
    FP.facility_id,  
    P.status_id AS status  
FROM party AS P  
JOIN person AS PER ON P.party_id = PER.party_id  
JOIN facility_party AS FP ON FP.party_id = P.party_id  
WHERE P.party_type_id = 'PERSON'  
AND FP.role_type_id = 'WAREHOUSE_PICKER';  
