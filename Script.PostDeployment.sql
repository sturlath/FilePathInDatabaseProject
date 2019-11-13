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
DECLARE @HasRunBefore BIT
DECLARE @ScriptName NCHAR(100)
DECLARE @Environment NCHAR(10)
DECLARE @theContentOfTheScriptFile varchar(max)  
DECLARE @SQL nvarchar(max);
DECLARE @ParmDef nvarchar(50);
-- Path to the solution file. 
-- Used to be able to navigate to the content of the script files.
DECLARE @solutionDir VARCHAR(max),@File VARCHAR(max)
SELECT @solutionDir = REPLACE('$(SolutionPath)','SQLCMDExample.sln','');

-- Environments are ALWAYS/DEV/UAT/PROD
-- But here I only show the one that needs to be run in every environment
IF '$(Environment)' = 'ALWAYS'
BEGIN
	:r Always.sql
END