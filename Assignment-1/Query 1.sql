-- Query 1
-- New Customers Acquired in June 2023
select 
PER.party_id, 
PER.first_name, 
PER.last_name, 
PTYRL.role_type_id, 
info_string as email_address, 
TN.contact_number, 
PER.created_stamp as entry_date
from person as PER inner join party_role as PTYRL on PER.party_id = PTYRL.party_id 
left join party_contact_mech as PCM on PER.party_id = PCM.party_id 
left join contact_mech as CM on PCM.contact_mech_id = CM.contact_mech_id 
left join telecom_number as TN on PCM.contact_mech_id = TN.contact_mech_id
where PTYRL.role_type_id = "CUSTOMER" and (PER.created_stamp between "2023-06-01" and "2023-06-30");

SELECT 
    PER.PARTY_ID, 
    PER.FIRST_NAME, 
    PER.LAST_NAME, 
    PTYRL.ROLE_TYPE_ID, 
    CM.INFO_STRING AS EMAIL_ADDRESS, 
    TN.CONTACT_NUMBER, 
    PER.CREATED_STAMP AS ENTRY_DATE
FROM PERSON AS PER 
INNER JOIN PARTY_ROLE AS PTYRL ON PER.PARTY_ID = PTYRL.PARTY_ID 
LEFT JOIN PARTY_CONTACT_MECH AS PCM ON PER.PARTY_ID = PCM.PARTY_ID 
LEFT JOIN CONTACT_MECH AS CM ON PCM.CONTACT_MECH_ID = CM.CONTACT_MECH_ID 
LEFT JOIN TELECOM_NUMBER AS TN ON PCM.CONTACT_MECH_ID = TN.CONTACT_MECH_ID
WHERE PTYRL.ROLE_TYPE_ID = 'CUSTOMER' 
AND PER.CREATED_STAMP BETWEEN '2023-06-01' AND '2023-06-30';


-- Query 2
-- List All Active Physical Products
select P.product_id, P.product_type_id, P.internal_name
from product as P inner join product_type as PT on P.product_type_id = PT.product_type_id 
where PT.is_physical = 'Y' and P.sales_discontinuation_date is null;

-- Query 3
-- Products Missing NetSuite ID
select 
P.product_id, 
P.internal_name, 
P.product_type_id, 
GI.id_value as netsuit_id 
from product as P join good_identification GI on P.product_id = GI.product_id
where GI.good_identification_type_id="ERP_ID" and GI.id_value is null;


--  Query 4
select 
GI.product_id,
(case when GI.good_identification_type_id = "SHOPIFY_PROD_ID" then GI.id_value end) as shopify_id,
(case when GI.good_identification_type_id = "ERP_ID" then GI.id_value end) as netsuite_id,
(case when GI.good_identification_type_id = "HC_GOOD_ID_TYPE" then GI.id_value end) as hotwax_id
from good_identification GI where GI.good_identification_type_id in ("SHOPIFY_PROD_ID", "ERP_ID", "HC_GOOD_ID_TYPE") 
group by GI.product_id, shopify_id, netsuite_id, hotwax_id
order by product_id;


-- Query 5
select P.product_id,
	   P.product_type_id,
	   OH.product_store_id,
       OI.quantity as TOTAL_QUANTITY,
       P.internal_name,
       F.facility_id,
       OH.external_id,
       F.facility_type_id,
       OHI.order_history_id,
	   OH.order_id,
       OI.order_item_seq_id,
       OISG.ship_group_seq_id
from order_header OH
join order_item OI on OI.order_id = OH.order_id
join order_status OS on OS.order_id = OH.order_id and OH.STATUS_ID = 'order_completed' and OS.STATUS_ID = 'order_completed'
join product P on P.product_id = OI.product_id
join order_item_ship_group OISG on OI.order_id = OISG.order_id and OI.SHIP_GROUP_SEQ_ID = OISG.SHIP_GROUP_SEQ_ID
join facility F on F.facility_id = OISG.facility_id
join order_history OHI on OH.order_id = OHI.order_id and oi.ORDER_ITEM_SEQ_ID = OHI.ORDER_ITEM_SEQ_ID
where OS.status_datetime BETWEEN '2023-08-01' and '2023-08-30';


-- Query 7
select distinct 
OH.order_id, 
OH.grand_total as total_amount, 
OPP.payment_method_type_id as payment_method, 
OI.external_id as shopify_id  
from order_header OH 
join order_item OI on OH.order_id = OI.order_id 
left join order_payment_preference OPP on OPP.order_id = OH.order_id 
where OH.status_id = "ORDER_CREATED" and OH.order_type_id = "SALES_ORDER";

-- Query 8
select 
OH.order_id,
OH.status_id as order_status,
OPP.status_id as payment_method,
S.status_id as shipment_status
from order_header OH
join order_payment_preference OPP on OH.order_id = OPP.order_id
join order_shipment OS on OH.order_id = OS.order_id
join shipment S on OS.shipment_id = S.shipment_id 
where S.status_id != "SHIPMENT_SHIPPED" and OPP.status_id="PAYMENT_RECEIVED";

-- Query 9
select 
count(order_id) as total_order, 
hour(Status_Datetime) as hr 
from order_status 
where status_id = "order_completed" 
group by hr;

-- Query 10
select 
count(OH.order_id) as total_order, 
sum(OH.grand_total) 
from order_header OH 
join order_item_ship_group OISG on OH.order_id = OISG.order_id 
where OISG.shipment_method_type_id = "STOREPICKUP" 
and OH.order_date between "2024-02-11" and "2025-02-11";

-- Query 11
select 
count(OS.order_id),
OS.change_reason
from order_status OS 
where OS.status_id = "ORDER_CANCELLED" and OS.status_datetime between "2025-01-01" and "2025-01-31" 
group by OS.change_reason;


-- Query 12
select PF.PRODUCT_ID, PF.FACILITY_ID, PF.minimum_stock as threshold
from product_facility PF 
join facility F on F.facility_id=PF.FACILITY_ID
where F.FACILITY_TYPE_ID = 'CONFIGURATION' and PF.MINIMUM_STOCK is not null order by threshold DESC;



-- Query 1
select 
OH.order_id, 
P.party_id, 
P.first_name, 
P.last_name, 
PA.address1, 
PA.city, 
PA.state_province_geo_id, 
PA.postal_code, 
PA.country_geo_id, 
OH.status_id, 
OH.order_date 
from order_contact_mech OCM 
join order_header OH on OCM.order_id = OH.order_id
join party_contact_mech PCM on PCM.contact_mech_id = OCM.contact_mech_id
join person P on P.party_id = PCM.party_id
join postal_address PA on PA.contact_mech_id = PCM.contact_mech_id
where OCM.contact_mech_purpose_type_id = "SHIPPING_LOCATION"
or OCM.contact_mech_purpose_type_id = "ORDER_CREATED"
and OH.status_id = "ORDER_COMPLETED" 
and OH.order_date > "2023-10-01";

-- Query 2
select 
OH.order_id, 
P.first_name, 
P.last_name, 
PA.address1, 
PA.city, 
PA.state_province_geo_id, 
PA.postal_code, 
OH.grand_total as total_amount, 
OH.status_id as order_status, 
OH.order_date 
from order_contact_mech OCM 
join order_header OH on OCM.order_id = OH.order_id
join party_contact_mech PCM on PCM.contact_mech_id = OCM.contact_mech_id
join person P on P.party_id = PCM.party_id
join postal_address PA on PA.contact_mech_id = PCM.contact_mech_id
where OCM.contact_mech_purpose_type_id = "SHIPPING_LOCATION"
and PA.city = "New York";

-- Query 3 
select 
P.product_id, 
P.internal_name, 
sum(OI.quantity) as total_quantity_sold, 
OH.grand_total as revenue 
from order_item OI join product P on P.product_id = OI.order_id
join order_header OH on OH.order_id = OI.order_id
join order_contact_mech OCM on OCM.order_id = OI.order_id
join postal_address PA on PA.contact_mech_id = OCM.contact_mech_id 
where PA.city = "New York" 
group by P.product_id;


-- Query 4
select
F.facility_id,
F.facility_name,
count(distinct OH.order_id) as total_orders,
sum(OH.grand_total) as total_revenue,
concat(min(OH.order_date), " to ", max(OH.order_date)) as date_range
from order_header OH
join order_item OI on OH.order_id = OI.order_id
join order_item_ship_group OISG on OI.order_id = OISG.order_id
join facility F on OISG.facility_id = F.facility_id
group by F.facility_id, F.facility_name;


-- Query 5
select 
    II.inventory_item_id,
    II.product_id,
    II.facility_id,
    abs(IID.quantity_on_hand_diff + IID.quantity_on_hand_diff) as quantity_lost_or_damaged,  
    IID.reason_enum_id as reason_code,  
    IID.effective_date as transaction_date
from INVENTORY_ITEM II
join INVENTORY_ITEM_DETAIL IID on II.inventory_item_id = IID.inventory_item_id
where IID.quantity_on_hand_diff < 0  and IID.quantity_on_hand_diff < 0 and IID.reason_enum_id in ("VAR_DAMAGED", "VAR_STOLEN", "VAR_LOST")
order by IID.effective_date desc;

-- Query 6
select 
    P.product_id,
    P.product_name,
    PF.facility_id,
    II.quantity_on_hand_total as qoh,  
    II.available_to_promise_total as atp,
    PF.minimum_stock as reorder_threshold,  
    current_date as date_checked  
from PRODUCT P
join INVENTORY_ITEM II on P.product_id = II.product_id
join PRODUCT_FACILITY PF on P.product_id = PF.product_id and II.facility_id = PF.facility_id
where II.quantity_on_hand_total <= PF.minimum_stock or II.available_to_promise_total <= PF.minimum_stock
order by PF.minimum_stock desc;

-- Query 7
select 
    OH.order_id,
    OH.status_id as order_status,
    F.facility_id,
    F.facility_name,
    F.facility_type_id
from ORDER_HEADER OH
join ORDER_ITEM_SHIP_GROUP OISG on OH.order_id = OISG.order_id
join FACILITY F on OISG.facility_id = F.facility_id
where OH.status_id IN ('ORDER_APPROVED', 'ORDER_CREATED', 'ORDER_PROCESSING')  
order by OH.order_id;

-- Query 8
select 
product_id, 
facility_id, 
quantity_on_hand_total as qoh, 
available_to_promise_total as atp, 
(quantity_on_hand_total - available_to_promise_total) as difference 
from inventory_item; 

-- Query 9
select 
order_id, 
order_item_seq_id, 
status_id as current_status_id, 
status_datetime as status_change_datetime, 
status_user_login as changed_by
from order_status;


-- Query 10
select 
sales_channel_enum_id, 
count(order_id) as total_orders, 
sum(grand_total) as total_revenue, 
concat(min(order_date), " to ", max(order_date)) 
from order_header 
group by sales_channel_enum_id;





-- Query 11
select 
    OH.order_id,
    OI.order_item_seq_id,
    OI.product_id,
    P.product_type_id,
    OH.sales_channel_enum_id,
    OH.order_date,
    OH.entry_date,
    OH.status_id,
    OS.status_datetime,
    OH.order_type_id,
    OH.product_store_id
from ORDER_HEADER OH
join ORDER_ITEM OI on OH.order_id = OI.order_id
join PRODUCT P on OI.product_id = P.product_id
join PRODUCT_TYPE PT on P.product_type_id = PT.product_type_id
join ORDER_STATUS OS on OH.order_id = OS.order_id and OH.status_id = OS.status_id
where OH.status_id = 'ORDER_COMPLETED'  
and PT.is_physical = 'Y'  
order by OH.order_date desc;


-- Query 2
select distinct
RH.return_id,
OH.order_id,
OH.product_store_id,
date(RS.status_datetime),
OH.order_name,
RH.from_party_id,
date(RH.return_date),
date(RH.entry_date),
RH.return_channel_enum_id
from 
return_header RH
join return_item RI on RH.return_id = RI.return_id
join return_status RS on RI.return_id = RS.return_id
join order_header OH on OH.order_id = RI.order_id
where RH.status_id = "RETURN_COMPLETED";


-- Query 3
select 
    P.party_id, 
    PER.first_name,
    RH.entry_date
from RETURN_HEADER RH
join PARTY P on RH.from_party_id = P.party_id
join PERSON PER on PER.party_id = P.party_id
join RETURN_ITEM RI on RI.return_id = RH.return_id
where RH.entry_date between "2025-01-12" and "2025-02-12" and (
    select count(*) 
    from RETURN_ITEM RI2 
    where RI2.order_id = RI.order_id
) = 1;  -- Ensures only one return per order


-- Query 4
select 
count(distinct RH.return_id) as total_returns, 
sum(RI.return_price * RI.return_quantity) as returns_total,
count(RA.return_id) as total_appreasements, 
sum(RA.amount) as appreasements_total 
from return_header RH 
left join return_adjustment RA on RH.return_id = RA.return_id
left join return_item RI on RH.return_id = RI.return_id;


-- Query 5
select 
RH.return_id, 
RH.entry_date, 
RA.return_adjustment_type_id, 
RA.amount, 
RA.comments, 
OH.order_id, 
OH.order_date, 
RH.return_date,
OH.product_store_id 
from return_header RH 
join return_item RI on RH.return_id = RI.return_id
join return_adjustment RA on RH.return_id = RA.return_id 
join order_header OH on RI.order_id = OH.order_id;


-- Query 6
select distinct
RI.order_id,
RI.return_id,
date(RH.return_date),
RI.reason,
RI.return_quantity
from return_header RH 
join return_item RI on RH.return_id = RI.return_id
where (
    select count(*) 
    from RETURN_ITEM RI2 
    where RI2.order_id = RI.order_id
) > 1;

-- Query 7
select 
F.facility_id, 
F.facility_name, 
count(OISG.order_id) as total_one_day_shiped_order,
concat(min(OISG.estimated_ship_date), " to ", max(OISG.estimated_ship_date)) as reporting_period
from order_item_ship_group OISG 
join order_shipment OS on OS.order_id = OISG.order_id
join shipment S on S.shipment_id = OS.shipment_id
join facility F on F.facility_id = OISG.facility_id
where OISG.shipment_method_type_id = "NEXT_DAY" and S.status_id = "SHIPMENT_SHIPPED"
group by OISG.facility_id
order by total_one_day_shiped_order desc;


-- Query 8
select 
P.party_id, 
concat(PER.first_name, " ", PER.last_name) as name, 
FP.role_type_id, 
FP.facility_id, 
P.status_id from party P 
join person PER on P.party_id = PER.party_id 
join facility_party FP on FP.party_id = P.party_id
where P.party_type_id = "PERSON" and FP.role_type_id = "WAREHOUSE_PICKER";

-- Query 9
select 
P.product_id,
p.product_name,
count(F.facility_id) as facility_count
from 
product P join inventory_item II on P.product_id = II.product_id
join facility F on F.facility_id = II.facility_id 
group by P.product_id, P.product_name order by facility_count desc;

-- Query 10
select 
    II.product_id,
    II.facility_id,
    F.facility_type_id,
    II.quantity_on_hand_total as qoh,  
    II.available_to_promise_total as atp
from INVENTORY_ITEM II
join FACILITY F on II.facility_id = F.facility_id
where F.facility_type_id = 'VIRTUAL_FACILITY';

-- Query 11



-- Query 12
select 
    OH.order_id,
    OH.order_date,
    OH.status_id as order_status,
    OISG.facility_id,
    day(OISG - OH.order_date) as duration
from ORDER_HEADER OH
join ORDER_ITEM_SHIP_GROUP OISG on OH.order_id = OISG.order_id
left join PICKLIST_BIN PB on OH.order_id = PB.primary_order_id  -- Check if a picklist exists
where PB.picklist_bin_id is null;









use smuat;
