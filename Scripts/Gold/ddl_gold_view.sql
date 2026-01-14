/*
  =====================================
         DDL: Create Gold Views
  =====================================
 
This script creates views for the gold layer.

Each view performs transformations and combines data from the silver layer
into a clean, enriched and business-ready dataset  

*/

DROP VIEW IF EXISTS gold.dim_customers CASCADE;
CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY cst_id ASC) customer_key, --Surrogate key
	c1.cst_id customer_id,
	c1.cst_firstname || ' ' || c1.cst_lastname customer_name,
	CASE 
		WHEN c1.cst_gndr = 'N/A' THEN c3.gen 
		ELSE c1.cst_gndr
	END gender,
	c2.cntry country,
	c1.cst_marital_status marital_status,
	c3.bdate birthdate,
	c1.cst_create_date create_date
FROM silver.CRM_CUST_INFO c1
LEFT JOIN silver.erp_loc_a101 c2
	ON c1.cst_key = c2.cid
LEFT JOIN silver.ERP_CUST_AZ12 c3
	ON c1.cst_key = c3.cid;

DROP VIEW IF EXISTS gold.dim_products CASCADE;
CREATE VIEW gold.dim_products AS
SELECT 
	product_key,
	product_number,
	product_line,
	CASE 
		WHEN category IS NULL THEN 'Components'
		ELSE category
	END,
	CASE 
		WHEN subcategory IS NULL THEN 'Wheels'
		ELSE subcategory
	END,
	product_name,
	CASE
		WHEN maintenance IS NULL THEN 'No'
		ELSE maintenance
	END,
	cost,
	start_date
FROM (SELECT 
	ROW_NUMBER() OVER(ORDER BY prd_id) product_key,
	p1.prd_key product_number,
	p1.prd_line product_line,
	p2.cat category,
	p2.subcat subcategory,
	p1.prd_nm product_name,
	p2.maintenance maintenance,
	p1.prd_cost cost,
	p1.prd_start_dt start_date
FROM silver.CRM_prd_info p1
LEFT JOIN silver.erp_px_cat_g1v2 p2
	ON p1.cat_id = p2.id
);

DROP VIEW IF EXISTS gold.fact_sales CASCADE;
CREATE VIEW gold.fact_sales AS
SELECT 
	sa.sls_ord_num order_number,
	cu.customer_key,
	pr.product_key,
	sa.sls_order_dt order_date,
	sa.sls_ship_dt shipping_date,
	sa.sls_due_dt due_date,
	sls_quantity quantity,
	sls_price price,
	sa.sls_sales sales_amount
FROM silver.crm_sales_details sa
LEFT JOIN gold.dim_products pr
	ON sa.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
	ON sa.sls_cust_id = cu.customer_id;
