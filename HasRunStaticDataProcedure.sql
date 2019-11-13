﻿
CREATE PROCEDURE [dbo].[HasRunStaticDataProcedure]
	@full_path varchar(1000),
	@Environment varchar(10),
	@HasRunBefore BIT OUTPUT
AS
	DECLARE @ScriptName VARCHAR(150)
	DECLARE @number varchar(15)

	-- Get the filename
	SELECT @ScriptName = RIGHT(@full_path, CHARINDEX('\', REVERSE(@full_path)) -1)

	-- Get the number (yearMonthDayHourMin) of the script . We don't care about the name so you can change that as you like!
	SELECT @number = SUBSTRING(@ScriptName, 1, 12);
	
	-- Has the script with this number and environment been run before?
	SELECT @HasRunBefore = CAST(COUNT(1) AS BIT) FROM [dbo].[StaticDataHistoryTable] WHERE [ScriptName] LIKE '%' + LTRIM(RTRIM(@number)) + '%' AND [Environment] = @Environment

RETURN 