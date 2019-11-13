SET @Environment = 'ALWAYS'

--1. -----------------------------------------------------------------------------------------------------------------------------
SET @ScriptName = '201911130001_Insert_some_data.sql' -- Could I have this strongly type but also use it as string insert?

-- Check if this insert script has been run before
EXEC dbo.HasRunStaticDataProcedure @ScriptName, @Environment, @HasRunBefore OUTPUT

IF @HasRunBefore = '0'
	BEGIN
			
		-- Gets the content of the run (insert/update/delete) file. 
		SET @File = @solutionDir + 'StaticDataInserts\'+ LTRIM(RTRIM(@Environment)) + '\' + LTRIM(RTRIM(@ScriptName));
		SELECT @SQL = N'SELECT @retvalOUT = BulkColumn FROM OPENROWSET(BULK ''' + @File + ''', SINGLE_BLOB) AS x' ;   
		SET @ParmDef = N'@retvalOUT varchar(max) OUTPUT';
		EXEC sp_executesql @SQL, @ParmDef, @retvalOUT=@theContentOfTheScriptFile OUTPUT;

		-- Run the insert file			
		-- I would love to be able to use the @ScriptName set above in the following line also so I could only set it once.
		-- That way I could make a procedure (with all the code from BEGIN->END) that takes in the name of the insert script file.
		:r .\StaticDataInserts\ALWAYS\201911130001_Insert_some_data.sql

		-- Inserts the into the history table the script name, 'ALWAYS' and what was inserted
		EXEC dbo.InsertStaticDataProcedure @ScriptName, @Environment, @theContentOfTheScriptFile
END
------------------------------------------------------------------------------------------------------------------------------------

--2. -------------------------------------------------------------------------------------------------------------------------------
--.... and then another set of inserts that should go into every environment.