-- 8 List of Warehouse Pickers
-- Business Problem:
-- Warehouse managers need a list of employees responsible for picking and packing orders to manage shifts, productivity, and training needs.

-- Fields to Retrieve:

-- PARTY_ID (or Employee ID)
-- NAME (First/Last)
-- ROLE_TYPE_ID (e.g., “WAREHOUSE_PICKER”)
-- FACILITY_ID (assigned warehouse)
-- STATUS (active or inactive employee)


SELECT DISTINCT PLR.party_id,  
       PER.first_name,  
       PLR.role_type_id,  
       PL.facility_id,  
       P.status_id AS User_Status  
FROM picklist_role PLR  
JOIN person PER ON PER.party_id = PLR.party_id  
JOIN picklist PL ON PL.picklist_id = PLR.picklist_id  
JOIN party P ON P.party_id = PLR.party_id;
