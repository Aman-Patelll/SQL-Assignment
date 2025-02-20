-- New Customers Acquired in June 2023  
SELECT  
    PER.party_id,  
    PER.first_name,  
    PER.last_name,  
    PTYRL.role_type_id,  
    CM.info_string AS email_address,  
    TN.contact_number,  
    PER.created_stamp AS entry_date  
FROM person AS PER  
INNER JOIN party_role AS PTYRL ON PER.party_id = PTYRL.party_id  
LEFT JOIN party_contact_mech AS PCM ON PER.party_id = PCM.party_id  
LEFT JOIN contact_mech AS CM ON PCM.contact_mech_id = CM.contact_mech_id  
LEFT JOIN telecom_number AS TN ON PCM.contact_mech_id = TN.contact_mech_id  
WHERE PTYRL.role_type_id = 'CUSTOMER'  
AND PER.created_stamp BETWEEN '2023-06-01' AND '2023-06-30'
ORDER BY entry_date;  
