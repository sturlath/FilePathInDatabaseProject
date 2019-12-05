/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
DECLARE @Environment NCHAR(10)
DECLARE @HasRunBefore BIT

-- Environments are ALWAYS/DEV/UAT/PROD
-- But here I only show the one that needs to be run in every environment
IF '$(Environment)' = 'ALWAYS'
BEGIN
	:r .\Always.sql
END