How to Import the Database into SSMS

Before running the SQL scripts, you need to set up the project database inside SQL Server Management Studio (SSMS).
There are three main ways to create or import a database in SSMS:

1️ Create a new database using a script

You can run a .sql script that creates all tables, relationships, and sample data.

CREATE DATABASE DataWarehouseAnalytics;
GO
USE DataWarehouseAnalytics;

2️ Import a flat file (CSV or Excel)

If your data is stored in a CSV or Excel file:

In SSMS, right-click Databases → Import Flat File

Follow the wizard to load your file into a new or existing table.

3️ Restore a database backup (.bak file)

This is the method used in this project.

Steps:

Open SSMS and connect to your SQL Server.

Right-click on Databases → Restore Database...

Select Device → Browse → Add

Locate and select the .bak file (e.g., DataWarehouseAnalytics.bak) located in your project folder.

Click OK, then OK again to begin restoring.

Once complete, verify the restored database under the Databases folder.
