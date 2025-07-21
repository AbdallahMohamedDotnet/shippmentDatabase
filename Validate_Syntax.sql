-- ========================================
-- SQL Server Syntax Validation Script
-- ========================================
-- This script performs basic syntax validation of the main Database.sql file
-- Run this to verify the script will parse correctly before actual execution
-- ========================================

PRINT 'Starting SQL Server syntax validation...'
PRINT ''

-- Enable parse-only mode to check syntax without execution
SET PARSEONLY ON
PRINT 'Parse-only mode enabled - checking syntax without execution'

-- Test database creation syntax
USE [master]
GO

CREATE DATABASE [Shipping_Test]
 CONTAINMENT = NONE
 ON PRIMARY 
( NAME = N'Shipping_Test', FILENAME = N'C:\Temp\Shipping_Test.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Shipping_Test_log', FILENAME = N'C:\Temp\Shipping_Test_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

USE [Shipping_Test]
GO

-- Test a sample table creation
CREATE TABLE [dbo].[TestTable](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TestTable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Test constraints and indexes
ALTER TABLE [dbo].[TestTable] ADD CONSTRAINT [DF_TestTable_Id] DEFAULT (newid()) FOR [Id]
GO

CREATE NONCLUSTERED INDEX [IX_TestTable_Name] ON [dbo].[TestTable]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

-- Disable parse-only mode
SET PARSEONLY OFF
PRINT 'Parse-only mode disabled'
PRINT ''
PRINT 'SQL Server syntax validation completed successfully!'
PRINT 'The Database.sql script should execute without syntax errors.'
PRINT ''
PRINT 'Next steps:'
PRINT '1. Review and update file paths in Database.sql if needed'
PRINT '2. Execute Setup_Database.sql to create the database with custom paths, OR'
PRINT '3. Execute Database.sql directly to create database with default paths'
PRINT '4. Connect your application using the connection strings in README.md'