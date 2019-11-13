CREATE PROCEDURE [dbo].[InsertStaticDataProcedure]
	@ScriptName varchar(100),
	@Environment varchar(10),
	@Data nvarchar(max)
AS

	DECLARE @currentUser varchar(50)

	SELECT @currentUser = CURRENT_USER; 

	INSERT INTO StaticDataHistoryTable(ScriptName,Environment,Created,CreatedBy,[Data]) VALUES (@ScriptName,@Environment,GETDATE(),@currentUser,@Data)

RETURN 