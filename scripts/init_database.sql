/* =============================== 
Create Database ans Schemas
==================================
Script Purpose:
	This script creates a new database named 'DW_PROJECT' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
	within the database: 'bronze', 'silver', and 'gold'.
WARNING:
	Running this script will drop the entire 'DW_PROJECT' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution and
	ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DW_PROJECT' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DW_PROJECT')
BEGIN
	ALTER DATABASE DW_PROJECT SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DW_PROJECT;
END;
GO

-- Create Database 'DataWarehouse'
CREATE DATABASE DW_PROJECT
GO

USE DW_PROJECT;
GO

-- Create Schemas

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver; --GO: separate batches when working with multiple SQL statements
GO
CREATE SCHEMA gold;
GO
