drop table if exists dw_bronze.crm_cust_info;
create table dw_bronze.crm_cust_info (
cst_id INT,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date date
);

drop table if exists dw_bronze.crm_prd_info;
create table dw_bronze.crm_prd_info (
prd_id INT,
prd_key nvarchar(50),
prd_nm nvarchar(50),
prd_cost int,
prd_line nvarchar(50),
prd_start_dt date,
prd_end_dt date
);

drop table if exists dw_bronze.crm_sales_details;
create table dw_bronze.crm_sales_details (
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price int
);

drop table if exists dw_bronze.erp_cust_az12;
create table dw_bronze.erp_cust_az12 (
cid nvarchar(50),
bdate date,
gen nvarchar(50)
);

drop table if exists dw_bronze.erp_loc_a101;
create table dw_bronze.erp_loc_a101 (
cid nvarchar(50),
cntry nvarchar(50)
);

drop table if exists dw_bronze.erp_px_cat_g1v2;
create table dw_bronze.erp_px_cat_g1v2 (
id nvarchar(50),
cat nvarchar(50),
subcat nvarchar(50),
maintenance nvarchar(50)
);
