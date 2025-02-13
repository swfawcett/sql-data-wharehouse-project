truncate dw_bronze.crm_cust_info;
LOAD DATA local INFILE "\\cust_info.csv"
INTO TABLE dw_bronze.crm_cust_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

truncate dw_bronze.crm_prd_info;
load DATA local INFILE "\\prd_info.csv"
INTO TABLE dw_bronze.crm_prd_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

truncate dw_bronze.crm_sales_details;
LOAD DATA local INFILE "\\sales_details.csv"
INTO TABLE dw_bronze.crm_sales_details
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

truncate dw_bronze.erp_cust_az12;
LOAD DATA local INFILE "\\CUST_AZ12.csv"
INTO TABLE dw_bronze.erp_cust_az12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

truncate dw_bronze.erp_loc_a101;
LOAD DATA local INFILE "\\LOC_A101.csv"
INTO TABLE dw_bronze.erp_loc_a101
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

truncate dw_bronze.erp_px_cat_g1v2;
LOAD DATA local INFILE "\\PX_CAT_G1V2.csv"
INTO TABLE dw_bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 
