/*
====================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
====================================================================
Script Purpose:
  This stored procedure loads data info the 'bronze' schema from external CSV files.
  It performs the following actions:
  - Truncates bronze tables before loading data.
  - Uses the 'BULK INSERT' command to load data from csv files to bronze tables.
Parameters:
   None.
  This stored procedure does not accept any parameters or return any values.
Usage Example:
  EXEC bronze.load_bronze;
====================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY -- TRY...CATCH: SQL runs the TRY block, and if fails, it runs the CATCH block to handle the error
		PRINT '==============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================================';

		PRINT '----------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info; -- TRUNCATE: delete all rows from a table, resetting it to an empty state

		PRINT '>> Inserting Data info: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\anaca\OneDrive\Área de Trabalho\Baraa\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR)+ 'seconds';
		-- DATEDIFF(): calculates the difference between dates, returns days, moneth or years


		-- SELECT * FROM bronze.crm_cust_info --check quality
		-- SELECT COUNT(*) FROM bronze.crm_cust_info

		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.crm_prd_infoo';
		TRUNCATE TABLE bronze.crm_prd_info; -- TRUNCATE: delete all rows from a table, resetting it to an empty state

		PRINT '>> Inserting Data info: bronze.crm_prd_infoo';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\anaca\OneDrive\Área de Trabalho\Baraa\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR)+ 'seconds';

		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details; -- TRUNCATE: delete all rows from a table, resetting it to an empty state

		PRINT '>> Inserting Data info: bronze.crm_prd_infoo';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\anaca\OneDrive\Área de Trabalho\Baraa\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR)+ 'seconds';


		PRINT '----------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------------------';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12; -- TRUNCATE: delete all rows from a table, resetting it to an empty state

		PRINT '>> Inserting Data info: bronze.crm_prd_infoo';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\anaca\OneDrive\Área de Trabalho\Baraa\SQL\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR)+ 'seconds';

		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101; -- TRUNCATE: delete all rows from a table, resetting it to an empty state

		PRINT '>> Inserting Data info: bronze.crm_prd_infoo';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\anaca\OneDrive\Área de Trabalho\Baraa\SQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR)+ 'seconds';

		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2; -- TRUNCATE: delete all rows from a table, resetting it to an empty state

		PRINT '>> Inserting Data info: bronze.crm_prd_infoo';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\anaca\OneDrive\Área de Trabalho\Baraa\SQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR)+ 'seconds';
	END TRY
	BEGIN CATCH
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Erros Message' + ERROR_MESSAGE();
		PRINT 'Erros Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Erros Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	END CATCH
END
