CREATE PROCEDURE [dbo].[InsertStaticDataProcedure]
	@RelativeFullPathAndFileName varchar(1000),
	@Environment varchar(10)
AS
DECLARE @bulkSelect NVARCHAR(max)
		DECLARE @outParmeterDefinition NVARCHAR(50);
		DECLARE @theContentOfTheScriptFile NVARCHAR(max) 
		DECLARE @scriptName VARCHAR(150)
		DECLARE @path VARCHAR(256)
		DECLARE @currentUser varchar(50)
		DECLARE @number varchar(15)

		-- Current user to log
		SELECT @currentUser = CURRENT_USER; 

		-- Splits up the full path to path and file name
		SELECT @scriptName = RIGHT(@RelativeFullPathAndFileName, CHARINDEX('\', REVERSE(@RelativeFullPathAndFileName)) -1)
		SELECT @path = LEFT(@RelativeFullPathAndFileName,LEN(@RelativeFullPathAndFileName) - charindex('\',reverse(@RelativeFullPathAndFileName),1) + 1) 

		-- Get the number (yearMonthDayHourMin) of the script . We don't care about the name so you can change that as you like!
		SELECT @number = SUBSTRING(@scriptName, 1, 12);

		-- Without the following lines I get the following error
		-- Line 1 Cannot bulk load because the file ".\StaticDataInserts\ALWAYS\201911130001_Insert_some_data.sql" could not be opened. 
		-- Operating system error code 3(The system cannot find the path specified.).
		--
		-- DECLARE @solutionDir VARCHAR(max)
		-- SELECT @solutionDir = REPLACE('$(SolutionPath)','SQLCMDExample.sln','');
		-- SET @RelativeFullPathAndFileName = @solutionDir + SUBSTRING(@RelativeFullPathAndFileName, 3, LEN(@RelativeFullPathAndFileName));
		--
		-- Add the lines here above and everything works.


		print 'REL: ' +@RelativeFullPathAndFileName

		-- Get the data from the file we are going to run
		SELECT @bulkSelect = N'SELECT @retvalOUT = BulkColumn FROM OPENROWSET(BULK ''' + @RelativeFullPathAndFileName + ''', SINGLE_BLOB) AS x' ;   
		SET @outParmeterDefinition = N'@retvalOUT varchar(max) OUTPUT';
		EXEC sp_executesql @bulkSelect, @outParmeterDefinition, @retvalOUT=@theContentOfTheScriptFile OUTPUT;
			
		INSERT INTO StaticDataHistoryTable(ScriptName,[Path],Environment,Created,CreatedBy,[Data]) VALUES (@ScriptName,@path,@Environment,GETDATE(),@currentUser,@theContentOfTheScriptFile)
			
RETURN 