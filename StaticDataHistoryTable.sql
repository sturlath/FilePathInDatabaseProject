CREATE TABLE [dbo].[StaticDataHistoryTable]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[Path] VARCHAR(256) NOT NULL, 
    [ScriptName] VARCHAR(100) NOT NULL, 
	[Environment] VARCHAR(10) NULL,
    [Data] NVARCHAR(MAX) NULL,
    [Created] DATETIME2 NULL, 
    [CreatedBy] VARCHAR(100) NULL
)