/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'Sys_Analysis' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called analyse
	
WARNING:
    Running this script will drop the entire 'Sys_Analysis' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'Sys_Analysis' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Sys_Analysis')
BEGIN
    ALTER DATABASE Sys_Analysis SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Sys_Analysis;
END;
GO

-- Create the 'Sys_Analysis' database
CREATE DATABASE Sys_Analysis;
GO

USE Sys_Analysis;
GO

-- Create Schemas

CREATE SCHEMA analyse;
GO

CREATE TABLE analyse.customers(
	customer_key int,
	customer_id int,
	customer_number nvarchar(50),
	first_name nvarchar(50),
	last_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);
GO

CREATE TABLE analyse.products(
	product_key int ,
	product_id int ,
	product_number nvarchar(50) ,
	product_name nvarchar(50) ,
	category_id nvarchar(50) ,
	category nvarchar(50) ,
	subcategory nvarchar(50) ,
	maintenance nvarchar(50) ,
	cost int,
	product_line nvarchar(50),
	start_date date 
);
GO

CREATE TABLE analyse.fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int 
);
GO

TRUNCATE TABLE analyse.customers;
GO

BULK INSERT analyse.customers
FROM 'C:\Users\Admin\Desktop\DATASETS\Practice Datasets\CRM_ERP_project\customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE analyse.products;
GO

BULK INSERT analyse.products
FROM 'C:\Users\Admin\Desktop\DATASETS\Practice Datasets\CRM_ERP_project\products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE analyse.fact_sales;
GO

BULK INSERT analyse.fact_sales
FROM 'C:\Users\Admin\Desktop\DATASETS\Practice Datasets\CRM_ERP_project\fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO
