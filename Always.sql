SET @Environment = 'ALWAYS'

--1. -----------------------------------------------------------------------------------------------------------------------------
:setvar  scriptPathWithName1 .\StaticDataInserts\ALWAYS\201911130001_Insert_some_data.sql 

EXEC dbo.HasRunStaticDataProcedure '$(scriptPathWithName1)', @Environment , @HasRunBefore OUTPUT

IF @HasRunBefore = '0'
BEGIN
	:r $(scriptPathWithName1)
	EXEC dbo.InsertStaticDataProcedure '$(scriptPathWithName1)', @Environment
END
------------------------------------------------------------------------------------------------------------------------------------

--2. -------------------------------------------------------------------------------------------------------------------------------

:setvar  scriptPathWithName2 .\StaticDataInserts\ALWAYS\2019151130002_Insert_more_data.sql 

EXEC dbo.HasRunStaticDataProcedure '$(scriptPathWithName2)', @Environment , @HasRunBefore OUTPUT

IF @HasRunBefore = '0'
BEGIN
	:r $(scriptPathWithName2)
	EXEC dbo.InsertStaticDataProcedure '$(scriptPathWithName2)', @Environment
END