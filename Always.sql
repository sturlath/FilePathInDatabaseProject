SET @Environment = 'ALWAYS'

--1. -----------------------------------------------------------------------------------------------------------------------------
:setvar  scriptPathWithName .\StaticDataInserts\ALWAYS\201911130001_Insert_some_data.sql --< this is much cleaner now with this declared once and strongly.

-- Check if this insert script has been run before
EXEC dbo.HasRunStaticDataProcedure '$(scriptPathWithName)', @Environment, @HasRunBefore OUTPUT

IF @HasRunBefore = '0'
	BEGIN

		-- Gets the content of the run (insert/update/delete) file. 
		SET @File = @solutionDir + SUBSTRING('$(scriptPathWithName)', 2, LEN('$(scriptPathWithName)'));
		SELECT @SQL = N'SELECT @retvalOUT = BulkColumn FROM OPENROWSET(BULK ''' + @File + ''', SINGLE_BLOB) AS x' ;   
		SET @ParmDef = N'@retvalOUT varchar(max) OUTPUT';
		EXEC sp_executesql @SQL, @ParmDef, @retvalOUT=@theContentOfTheScriptFile OUTPUT;

		-- Run the insert file			
		:r $(scriptPathWithName)

		-- Inserts the into the history table the script name, 'ALWAYS' and what was inserted
		EXEC dbo.InsertStaticDataProcedure '$(scriptPathWithName)', @Environment, @theContentOfTheScriptFile
END
------------------------------------------------------------------------------------------------------------------------------------

--2. -------------------------------------------------------------------------------------------------------------------------------
--.... and then another set of inserts that should go into every environment.