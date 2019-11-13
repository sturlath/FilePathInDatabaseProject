CREATE PROCEDURE [dbo].[InsertStaticDataProcedure]
	@full_path varchar(1000),
	@Environment varchar(10),
	@Data nvarchar(max)
AS
	DECLARE @ScriptName VARCHAR(150)
	DECLARE @Path VARCHAR(256)
	DECLARE @currentUser varchar(50)

	SELECT @currentUser = CURRENT_USER; 

	-- Get the filename
	SELECT @ScriptName = RIGHT(@full_path, CHARINDEX('\', REVERSE(@full_path)) -1)
	SELECT @Path = LEFT(@full_path,LEN(@full_path) - charindex('\',reverse(@full_path),1) + 1) 


	INSERT INTO StaticDataHistoryTable(ScriptName,Path,Environment,Created,CreatedBy,[Data]) VALUES (@ScriptName,@Path,@Environment,GETDATE(),@currentUser,@Data)

RETURN 