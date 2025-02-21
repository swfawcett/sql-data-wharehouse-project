-- Reshape/modify brz data for slvr table insertion
truncate dw_silver.crm_cust_info;
insert into dw_silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
select
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date
from (select
		cst_id,
		cst_key,
		trim(cst_firstname) cst_firstname,
		trim(cst_lastname) cst_lastname,
		case 
			when trim(upper(cst_marital_status)) = "M" then "Married"
			when trim(upper(cst_marital_status)) = "S" then "Single"
			else "n/a" end as cst_marital_status,
		case 
			when trim(upper(cst_gndr)) = "F" then "Female"
			when trim(upper(cst_gndr)) = "M" then "Male"
			else "n/a" end as cst_gndr,
            -- cst_create_date,
		case 
			when cst_create_date = 0000-00-00 then '1900-01-01'
			when cst_create_date is null then '1900-01-01'
			else cst_create_date end as cst_create_date,
            row_number()over(partition by cst_id order by cst_create_date desc) as flag_last
		from dw_bronze.crm_cust_info) t
where flag_last = 1 and cst_id !=0;

truncate dw_silver.crm_prd_info;
insert into dw_silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
select
prd_id,
replace(substring(prd_key, 1,5), '-', '_') as cat_id,
substring(prd_key, 7) as prd_key,
prd_nm,
ifnull(prd_cost, 0) as prd_cost, 
case upper(trim(prd_line)) 
	when 'M' then 'Mountain'
    when 'R' then 'Road'
    when 'S' then 'Other Sales'
    when 'T' then 'Touring'
    else 'n/a' end as prd_line,
prd_start_dt,
date_sub(lead(prd_start_dt)over(partition by prd_key order by prd_start_dt), interval 1 day) end_dt
from dw_bronze.crm_prd_info;

truncate dw_silver.crm_sales_details;
insert into dw_silver.crm_sales_details(
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
select
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt <=0 or length(sls_order_dt) < 8 then null
else cast(sls_order_dt as date) end as sls_order_dt,
case when sls_ship_dt <=0 or length(sls_ship_dt) < 8 then null
else cast(sls_ship_dt as date) end as sls_ship_dt,
case when sls_due_dt <=0 or length(sls_due_dt) < 8 then null
else cast(sls_due_dt as date) end as sls_due_dt,
case 
	when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity * abs(sls_price)
	then sls_quantity * abs(sls_price)
	else sls_sales end as sls_sales,
sls_quantity,
case 
	when sls_price is null or sls_price < 0
    then round(sls_sales / nullif(sls_quantity,0))
    else sls_price end as sls_price
from dw_bronze.crm_sales_details;

truncate dw_silver.erp_cust_az12;
insert into dw_silver.erp_cust_az12 (
	cid,
	bdate,
	gen
)
select
case when cid like "NAS%" then substr(cid,4)
else cid end as cid,
case 
	when bdate > now() then null
    else bdate end as bdate,
case 
	when replace(lower(trim(gen)), '\r', '') in ('m', 'male') then 'Male'
    when replace(lower(trim(gen)), '\r', '') in ('f', 'female') then 'Female'
    else 'n/a' end as gen
from dw_bronze.erp_cust_az12;

truncate dw_silver.erp_loc_a101;
insert into dw_silver.erp_loc_a101(
	cid,
	cntry
) 
SELECT
replace(cid,'-','') cid,
case replace(trim(cntry),'\r','') 
	when 'DE' then 'Germany'
	when 'US' then 'United States'
    WHEN 'USA' then 'United States'
    when '' then 'n/a'
    else replace(trim(cntry),'\r','') end as cntry
FROM dw_bronze.erp_loc_a101;

truncate dw_silver.erp_px_cat_g1v2;
insert into dw_silver.erp_px_cat_g1v2(
	id,
    cat,
    subcat,
    maintenance
)
select
id,
cat,
subcat,
replace(maintenance, '\r','') maintenance
from dw_bronze.erp_px_cat_g1v2;
