
CREATE PROCEDURE [dbo].[HasRunStaticDataProcedure]
	@RelativeFullPathAndFileName varchar(1000),
	@Environment varchar(10),
	@scriptHasBeenRunBefore BIT OUTPUT
AS
	DECLARE @scriptName VARCHAR(150)
	DECLARE @number varchar(15)
	DECLARE @path VARCHAR(256)

	-- Splits up the full path to path and file name
	SELECT @scriptName = RIGHT(@RelativeFullPathAndFileName, CHARINDEX('\', REVERSE(@RelativeFullPathAndFileName)) -1)
	SELECT @path = LEFT(@RelativeFullPathAndFileName,LEN(@RelativeFullPathAndFileName) - charindex('\',reverse(@RelativeFullPathAndFileName),1) + 1) 

	-- Get the number (yearMonthDayHourMin) of the script . We don't care about the name so you can change that as you like!
	SELECT @number = SUBSTRING(@scriptName, 1, 12);

	-- Has the script with this number and environment been run before?
	SELECT @scriptHasBeenRunBefore = CAST(COUNT(1) AS BIT) FROM [dbo].[StaticDataHistoryTable] WHERE [ScriptName] LIKE '%' + LTRIM(RTRIM(@number)) + '%' AND [Environment] = @Environment

RETURN 