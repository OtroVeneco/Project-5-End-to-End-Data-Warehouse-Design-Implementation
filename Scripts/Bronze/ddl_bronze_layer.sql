/*
 ====================================
   DDL script: Create bronze tables
 ====================================
 
 This script creates the tables in the bronze schema, dropping existing 
 tables if they already exists.
 Run this script to redefine the DDL structure of bronze tables
 */

DROP TABLE IF EXISTS bronze.crm_cust_info;
CREATE table bronze.crm_cust_info (
	cst_id INT,
	cst_key	VARCHAR(15),
	cst_firstname VARCHAR(20),
	cst_lastname VARCHAR(20),	
	cst_marital_status	VARCHAR(10),
	cst_gndr VARCHAR(10),
	cst_create_date DATE
);

DROP TABLE IF EXISTS bronze.crm_prd_info;
CREATE table bronze.crm_prd_info (
	prd_id INT,
	prd_key	VARCHAR(20),
	prd_nm VARCHAR(40),	
	prd_cost NUMERIC,
	prd_line VARCHAR(10),
	prd_start_dt DATE,
	prd_end_dt DATE
);

DROP TABLE IF EXISTS bronze.crm_sales_details;
CREATE table bronze.crm_sales_details (
	sls_ord_num	VARCHAR(10),
	sls_prd_key VARCHAR(15),	
	sls_cust_id	INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales NUMERIC,
	sls_quantity INT,	
	sls_price NUMERIC
);

DROP TABLE IF EXISTS bronze.erp_CUST_AZ12;
CREATE table bronze.erp_CUST_AZ12 (
	CID	VARCHAR(15),
	BDATE DATE,
	GEN VARCHAR(10)
);

DROP TABLE IF EXISTS bronze.erp_LOC_A101;
CREATE table bronze.erp_LOC_A101 (
	CID VARCHAR(15),
	CNTRY VARCHAR(20)
);

DROP TABLE IF EXISTS bronze.erp_PX_CAT_G1V2;
CREATE table bronze.erp_PX_CAT_G1V2 (
	ID VARCHAR(10),
	CAT VARCHAR(15),
	SUBCAT VARCHAR(20),
	MAINTENANCE VARCHAR(5)
);


