-- DROP PROCEDURE silver.load_silver();

CREATE OR REPLACE PROCEDURE silver.load_silver()
 LANGUAGE plpgsql
AS $$
DECLARE
	updated_rows INT;
	start_time TIMESTAMP; --
	start_time_overall TIMESTAMP;
BEGIN
	start_time_overall := clock_timestamp();
	RAISE NOTICE '========================';
	RAISE NOTICE 'Loading the silver Layer';
	RAISE NOTICE '========================';
	RAISE NOTICE '';
	RAISE NOTICE '==================';
	RAISE NOTICE 'Loading CRM Tables';
	RAISE NOTICE '==================';
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading silver.crm_cust_info';
		TRUNCATE TABLE silver.crm_cust_info;
		INSERT INTO silver.crm_cust_info
		SELECT
			cst_id,
			cst_key,
			TRIM(cst_firstname) cst_firstname,
			TRIM(cst_lastname) cst_lastname,
			CASE UPPER(TRIM(cst_marital_status))
				WHEN 'M' THEN 'Married'
				WHEN 'S' THEN 'Single'
				ELSE 'N/A'
			END cst_marital_status,
			CASE UPPER(TRIM(cst_gndr))
				WHEN 'M' THEN 'Male'
				WHEN 'F' THEN 'Female'
				ELSE 'N/A'
			END cst_gndr, 
			cst_create_date
		FROM (SELECT 
			*,
			ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) flag_last
		FROM bronze.CRM_CUST_INFO)
		WHERE flag_last = 1 AND cst_id IS NOT NULL;
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading silver.crm_prd_info';
		TRUNCATE TABLE silver.crm_prd_info;
		INSERT INTO silver.crm_prd_info
		SELECT *
		FROM (SELECT 
			prd_id,
			SUBSTRING(prd_key FROM 7 FOR LENGTH(prd_key)) prd_key,
			SUBSTRING(prd_key FROM 1 FOR 5) cat_id,
			prd_nm,
			COALESCE(prd_cost, 0) prd_cost,
			CASE UPPER(TRIM(prd_line))
				WHEN 'M' THEN 'Mountain'
				WHEN 'R' THEN 'Road'
				WHEN 'T' THEN 'Touring'
				WHEN 'S' THEN 'Other Sales'
				ELSE 'N/A'
			END prd_line,
			prd_start_dt,
			lead(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt ASC) - 1 prd_end_dt
		FROM bronze.CRM_prd_info)
		WHERE prd_end_dt IS NULL;
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading silver.crm_sales_details';
		TRUNCATE TABLE silver.crm_sales_details;
		INSERT INTO silver.crm_sales_details
		SELECT 
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			CASE
				WHEN LENGTH(sls_order_dt::VARCHAR) != 8 THEN TO_DATE(sls_ship_dt::VARCHAR, 'YYYYMMDD') - 7
				ELSE TO_DATE(sls_order_dt::VARCHAR, 'YYYYMMDD')
			END sls_order_dt,
			CASE
				WHEN LENGTH(sls_ship_dt::VARCHAR) != 8 THEN NULL
				ELSE TO_DATE(sls_ship_dt::VARCHAR, 'YYYYMMDD')
			END sls_ship_dt,
			CASE
				WHEN LENGTH(sls_due_dt::VARCHAR) != 8 THEN NULL
				ELSE TO_DATE(sls_due_dt::VARCHAR, 'YYYYMMDD')
			END sls_due_dt,
			CASE 
				WHEN sls_sales != (sls_quantity * sls_price) OR sls_sales IS NULL THEN (sls_quantity * ABS(sls_price))
				ELSE ABS(sls_sales)
			END sls_sales,
			sls_quantity,
			CASE
				WHEN sls_price IS NULL THEN ABS(sls_sales)/sls_quantity
				ELSE ABS(sls_price)
			END sls_price
		FROM bronze.crm_sales_details;
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	
	RAISE NOTICE '==================';
	RAISE NOTICE 'Loading ERP Tables';
	RAISE NOTICE '==================';
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading silver.erp_CUST_AZ12';
		TRUNCATE TABLE silver.ERP_CUST_AZ12;
		INSERT INTO silver.ERP_CUST_AZ12
		SELECT 
			CASE
				WHEN LENGTH(cid) > 10 THEN SUBSTRING(cid FROM 4 FOR LENGTH(cid))
				ELSE cid
			END,
			CASE 
				WHEN bdate < '1925-08-19' or bdate > '2025-08-19' THEN NULL 
				ELSE bdate
			END,
			CASE 
				WHEN UPPER(gen) LIKE 'F%' THEN 'Female'
				WHEN UPPER(gen) LIKE 'M%' THEN 'Male'
				ELSE 'N/A'
			END gen
		FROM bronze.ERP_CUST_AZ12 ECA;
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading silver.erp_LOC_A101';
		TRUNCATE TABLE silver.erp_loc_a101;
		INSERT INTO silver.erp_loc_a101
		SELECT 
			REPLACE(cid, '-', '') cid,
			CASE 
				WHEN UPPER(TRIM(cntry)) IN ('US', 'USA') THEN 'United States'
				WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
				WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'N/A'
				ELSE cntry
			END
		FROM bronze.erp_loc_a101;
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading silver.erp_PX_CAT_G1V2';
		TRUNCATE TABLE silver.erp_px_cat_g1v2;
		INSERT INTO silver.erp_px_cat_g1v2
		SELECT 
			REPLACE(id, '_', '-') id,
			cat,
			subcat,
			maintenance
		FROM bronze.erp_px_cat_g1v2;
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	RAISE NOTICE 'Total Execution Time: % ms', EXTRACT(EPOCH FROM (clock_timestamp() - start_time_overall)) * 1000;
END;
$$
;