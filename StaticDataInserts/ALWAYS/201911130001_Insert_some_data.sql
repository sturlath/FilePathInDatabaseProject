PRINT 'This file then has some "If not exists" checks and then inserts/updates/deletes data from some table'

INSERT INTO StaticDataHistoryTable(ScriptName,[Path],Environment,Created,CreatedBy,[Data]) VALUES ('test','','xxx',GETDATE(),'','')