-- 1 New Customers Acquired in June 2023
-- Business Problem:
-- The marketing team ran a campaign in June 2023 and wants to see how many new customers signed up during that period.

-- Fields to Retrieve:

-- PARTY_ID
-- FIRST_NAME
-- LAST_NAME
-- EMAIL
-- PHONE
-- ENTRY_DATE

SELECT 
    PER.party_id, 
    PER.first_name, 
    PER.last_name, 
    CM.info_string AS email,
    TN.contact_number AS phone
FROM person PER
JOIN party PTY ON PTY.party_id=PER.party_id 
    AND PTY.created_date BETWEEN '2023-06-01' AND '2023-07-01'
JOIN party_role PR ON PR.party_id=PER.party_id 
    AND PR.role_type_id='CUSTOMER'
LEFT JOIN party_contact_mech PCM ON PCM.party_id = PER.party_id
LEFT JOIN contact_mech CM ON CM.contact_mech_id = PCM.contact_mech_id
LEFT JOIN telecom_number TN ON TN.contact_mech_id = CM.contact_mech_id;
