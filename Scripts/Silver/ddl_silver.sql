/*
 ====================================
   DDL script: Create silver tables
 ====================================
 
 This script creates the tables in the silver schema, dropping existing 
 tables if they already exists.
 Run this script to redefine the DDL structure of silver tables
 */

DROP TABLE IF EXISTS silver.crm_cust_info CASCADE;
CREATE table silver.crm_cust_info (
	cst_id INT,
	cst_key	VARCHAR(15),
	cst_firstname VARCHAR(20),
	cst_lastname VARCHAR(20),	
	cst_marital_status	VARCHAR(10),
	cst_gndr VARCHAR(10),
	cst_create_date DATE,
	dwh_create_date TIMESTAMP DEFAULT CLOCK_TIMESTAMP()
);

DROP TABLE IF EXISTS silver.crm_prd_info CASCADE;
CREATE table silver.crm_prd_info (
	prd_id INT,
	prd_key	VARCHAR(10),
	cat_id VARCHAR(10),
	prd_nm VARCHAR(40),	
	prd_cost NUMERIC,
	prd_line VARCHAR(15),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date TIMESTAMP DEFAULT CLOCK_TIMESTAMP()
);

DROP TABLE IF EXISTS silver.crm_sales_details CASCADE;
CREATE table silver.crm_sales_details (
	sls_ord_num	VARCHAR(10),
	sls_prd_key VARCHAR(15),	
	sls_cust_id	INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales NUMERIC,
	sls_quantity INT,	
	sls_price NUMERIC,
	dwh_create_date TIMESTAMP DEFAULT CLOCK_TIMESTAMP()
);

DROP TABLE IF EXISTS silver.erp_CUST_AZ12 CASCADE;
CREATE table silver.erp_CUST_AZ12 (
	CID	VARCHAR(15),
	BDATE DATE,
	GEN VARCHAR(10),
	dwh_create_date TIMESTAMP DEFAULT CLOCK_TIMESTAMP()
);

DROP TABLE IF EXISTS silver.erp_LOC_A101 CASCADE;
CREATE table silver.erp_LOC_A101 (
	CID VARCHAR(15),
	CNTRY VARCHAR(20),
	dwh_create_date TIMESTAMP DEFAULT CLOCK_TIMESTAMP()
);

DROP TABLE IF EXISTS silver.erp_PX_CAT_G1V2 CASCADE;
CREATE table silver.erp_PX_CAT_G1V2 (
	ID VARCHAR(10),
	CAT VARCHAR(15),
	SUBCAT VARCHAR(20),
	MAINTENANCE VARCHAR(5),
	dwh_create_date TIMESTAMP DEFAULT CLOCK_TIMESTAMP()
);