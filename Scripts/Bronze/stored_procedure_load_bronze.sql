/*
 |======================================|
 | Stored Procedure: Load bronze layer  |
 |======================================|
 
This script create a stored procedure to load data into the bronze schema 
from csv files.
It truncates the bronze tables before loading data performing a full load (truncate and insert)
Use the COPY command to load data from csv files
It shows some statistics for every table load and an overall total execution time

Note:
This stored procedure does not accept any parameters or return any values
 */

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
	updated_rows INT;
	start_time TIMESTAMP; --
	start_time_overall TIMESTAMP;
BEGIN
	start_time_overall := clock_timestamp();
	RAISE NOTICE '========================';
	RAISE NOTICE 'Loading the Bronze Layer';
	RAISE NOTICE '========================';
	RAISE NOTICE '';
	RAISE NOTICE '==================';
	RAISE NOTICE 'Loading CRM Tables';
	RAISE NOTICE '==================';
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		COPY bronze.crm_cust_info
		FROM 'C:\Users\Oscar\OneDrive\PARA\1-Projects\Project #1\Creating a warehourse for the data\datasets\source_crm\cust_info.csv'
		WITH (FORMAT CSV, HEADER);
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		COPY bronze.crm_prd_info
		FROM 'C:\Users\Oscar\OneDrive\PARA\1-Projects\Project #1\Creating a warehourse for the data\datasets\source_crm\prd_info.csv'
		WITH (FORMAT CSV, HEADER);
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		COPY bronze.crm_sales_details
		FROM 'C:\Users\Oscar\OneDrive\PARA\1-Projects\Project #1\Creating a warehourse for the data\datasets\source_crm\sales_details.csv'
		WITH (FORMAT CSV, HEADER);
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
		RAISE NOTICE '>>Loading bronze.erp_CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		COPY bronze.erp_CUST_AZ12
		FROM 'C:\Users\Oscar\OneDrive\PARA\1-Projects\Project #1\Creating a warehourse for the data\datasets\source_erp\CUST_AZ12.csv'
		WITH (FORMAT CSV, HEADER);
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading bronze.erp_LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101;
		COPY bronze.erp_LOC_A101
		FROM 'C:\Users\Oscar\OneDrive\PARA\1-Projects\Project #1\Creating a warehourse for the data\datasets\source_erp\LOC_A101.csv'
		WITH (FORMAT CSV, HEADER);
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	
	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>>Loading bronze.erp_PX_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		COPY bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\Oscar\OneDrive\PARA\1-Projects\Project #1\Creating a warehourse for the data\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (FORMAT CSV, HEADER);
		GET DIAGNOSTICS updated_rows = ROW_COUNT;
		RAISE NOTICE 'Loading Duration: %ms', EXTRACT(EPOCH FROM(clock_timestamp() - start_time)) * 1000;
		RAISE NOTICE 'Updated % Rows', updated_rows;
	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'Error During Load';
	END;
	RAISE NOTICE 'Total Execution Time: % ms', EXTRACT(EPOCH FROM (clock_timestamp() - start_time_overall)) * 1000;
END;
$$;

