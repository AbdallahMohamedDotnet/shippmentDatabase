# Shipping Database - SQL Server Setup

This repository contains the SQL Server database schema for a shipping management system.

## Prerequisites

- **SQL Server 2019 or later** (Express Edition or higher)
- **SQL Server Management Studio (SSMS)** or **Azure Data Studio**
- **Appropriate database permissions** to create databases and execute DDL statements

## Database Schema Overview

The database includes the following main components:

### Core Tables
- **TbCarriers** - Shipping carrier information
- **TbCountries** - Country master data
- **TbCities** - City master data (linked to countries)
- **TbShippingTypes** - Different types of shipping services
- **TbPaymentMethods** - Available payment methods
- **TbShippments** - Main shipment records
- **TbShippmentStatus** - Shipment status tracking
- **TbUserSebders** - Sender user information
- **TbUserReceivers** - Receiver user information
- **TbSubscriptionPackages** - Subscription plan information
- **TbUserSubscriptions** - User subscription records

### ASP.NET Identity Tables
- **AspNetUsers** - User accounts
- **AspNetRoles** - User roles
- **AspNetUserRoles** - User-role relationships
- **AspNetUserClaims** - User claims
- **AspNetRoleClaims** - Role claims
- **AspNetUserLogins** - External login providers
- **AspNetUserTokens** - User tokens

### System Tables
- **__EFMigrationsHistory** - Entity Framework migration history
- **Log** - Application logging
- **TbSetting** - Application settings

## Installation Instructions

### Option 1: Using SQL Server Management Studio (SSMS)

1. **Open SQL Server Management Studio**
2. **Connect to your SQL Server instance**
3. **Open the Database.sql file**
   - File → Open → File
   - Select `Database.sql` from this repository
4. **Update file paths** (if necessary)
   - Modify the file paths in lines 7 and 9 to match your SQL Server installation
   - Default paths are for SQL Server Express (SQLEXPRESS01)
5. **Execute the script**
   - Click Execute (F5) or press the Execute button
   - The script will create the database and all tables

### Option 2: Using Azure Data Studio

1. **Open Azure Data Studio**
2. **Connect to your SQL Server instance**
3. **Create a new query**
4. **Copy and paste the contents of Database.sql**
5. **Update file paths** as needed
6. **Execute the script**

### Option 3: Using Command Line (sqlcmd)

```bash
# Connect and execute the script
sqlcmd -S your_server_name -d master -i Database.sql

# For Windows Authentication
sqlcmd -S your_server_name -E -d master -i Database.sql

# For SQL Server Authentication
sqlcmd -S your_server_name -U your_username -P your_password -d master -i Database.sql
```

## Configuration Notes

### File Paths
The script contains hardcoded file paths for the database files:
```sql
( NAME = N'Shipping', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\Shipping.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
```

**You may need to update these paths** based on your SQL Server installation:
- **SQL Server Express**: Usually `C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\`
- **SQL Server Developer/Standard**: Usually `C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\`
- **Custom installations**: Check your SQL Server configuration

### Alternative: Create Database Without File Paths
If you prefer to let SQL Server use default locations, you can replace the CREATE DATABASE statement with:
```sql
CREATE DATABASE [Shipping]
GO
```

## Connection String Examples

### .NET Connection Strings

**Windows Authentication:**
```
Server=your_server_name;Database=Shipping;Trusted_Connection=true;
```

**SQL Server Authentication:**
```
Server=your_server_name;Database=Shipping;User Id=your_username;Password=your_password;
```

**Local SQL Server Express:**
```
Server=.\\SQLEXPRESS;Database=Shipping;Trusted_Connection=true;
```

### Entity Framework Core
```csharp
"ConnectionStrings": {
  "DefaultConnection": "Server=your_server_name;Database=Shipping;Trusted_Connection=true;"
}
```

## Troubleshooting

### Common Issues

1. **File path errors**
   - Update the database file paths in the CREATE DATABASE statement
   - Or remove the file path specifications to use default locations

2. **Permission errors**
   - Ensure your user has `dbcreator` and `sysadmin` privileges
   - Or have a database administrator execute the script

3. **SQL Server version compatibility**
   - This script is compatible with SQL Server 2016 and later
   - For older versions, you may need to remove newer syntax features

4. **Database already exists**
   - Drop the existing database first: `DROP DATABASE [Shipping]`
   - Or modify the script to use a different database name

### Script Validation
To validate the script without creating the database:
```sql
-- Add this at the beginning to parse without execution
SET PARSEONLY ON
-- Your script content here
SET PARSEONLY OFF
```

## Database Features

- **Unicode support** - Uses NVARCHAR for international text
- **GUID primary keys** - Most tables use UNIQUEIDENTIFIER for distributed scenarios
- **Audit fields** - CreatedDate, CreatedBy, UpdatedDate, UpdatedBy
- **Referential integrity** - Proper foreign key constraints
- **Indexes** - Optimized for common query patterns
- **ASP.NET Identity integration** - Full user management support
- **Entity Framework ready** - Compatible with EF Core migrations

## Support

For issues related to:
- **SQL Server installation**: Consult Microsoft SQL Server documentation
- **Database schema**: Review the table definitions in the script
- **Application integration**: Check your application's connection string and Entity Framework configuration

## License

This database schema is provided as-is for educational and development purposes.