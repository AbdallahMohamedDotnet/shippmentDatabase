-- ========================================
-- Shipping Database Setup Script
-- ========================================
-- This script creates the Shipping database with customizable file paths
-- 
-- INSTRUCTIONS:
-- 1. Update the @DataPath and @LogPath variables below to match your SQL Server installation
-- 2. Execute this script in SQL Server Management Studio or Azure Data Studio
-- 3. The script will create the database and execute the main schema script
-- ========================================

USE [master]
GO

-- ========================================
-- CONFIGURATION SECTION - UPDATE THESE PATHS
-- ========================================
DECLARE @DataPath NVARCHAR(500) = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\'
DECLARE @LogPath NVARCHAR(500) = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\'

-- Alternative paths for different SQL Server installations:
-- SQL Server Developer/Standard: C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\
-- SQL Server 2019: Replace MSSQL16 with MSSQL15
-- SQL Server 2022: Replace MSSQL16 with MSSQL17

-- ========================================
-- DATABASE CREATION WITH DYNAMIC PATHS
-- ========================================
DECLARE @SQL NVARCHAR(MAX)
SET @SQL = N'
CREATE DATABASE [Shipping]
 CONTAINMENT = NONE
 ON PRIMARY 
( NAME = N''Shipping'', FILENAME = N''' + @DataPath + N'Shipping.mdf'' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N''Shipping_log'', FILENAME = N''' + @LogPath + N'Shipping_log.ldf'' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF'

-- Check if database exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Shipping')
BEGIN
    PRINT 'Database [Shipping] already exists. Please drop it first or use a different name.'
    PRINT 'To drop: DROP DATABASE [Shipping]'
END
ELSE
BEGIN
    PRINT 'Creating database [Shipping] with the following paths:'
    PRINT 'Data file: ' + @DataPath + 'Shipping.mdf'
    PRINT 'Log file: ' + @LogPath + 'Shipping_log.ldf'
    PRINT ''
    
    EXEC sp_executesql @SQL
    
    IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Shipping')
    BEGIN
        PRINT 'Database [Shipping] created successfully!'
        PRINT 'Now execute the main Database.sql script to create all tables and data.'
    END
    ELSE
    BEGIN
        PRINT 'Failed to create database. Please check the file paths and permissions.'
    END
END
GO