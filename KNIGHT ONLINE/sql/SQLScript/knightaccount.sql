IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Knight_Account')
	DROP DATABASE [Knight_Account]
GO

CREATE DATABASE [Knight_Account]  ON (NAME = N'Knight_Account_Data', FILENAME = N'D:\Data\Knight_Account_Data.MDF' , SIZE = 38, FILEGROWTH = 10%) LOG ON (NAME = N'Knight_Account_Log', FILENAME = N'D:\Data\Knight_Account_Log.LDF' , SIZE = 38, FILEGROWTH = 10%)
 COLLATE Korean_Wansung_CI_AS
GO

exec sp_dboption N'Knight_Account', N'autoclose', N'false'
GO

exec sp_dboption N'Knight_Account', N'bulkcopy', N'false'
GO

exec sp_dboption N'Knight_Account', N'trunc. log', N'false'
GO

exec sp_dboption N'Knight_Account', N'torn page detection', N'true'
GO

exec sp_dboption N'Knight_Account', N'read only', N'false'
GO

exec sp_dboption N'Knight_Account', N'dbo use', N'false'
GO

exec sp_dboption N'Knight_Account', N'single', N'false'
GO

exec sp_dboption N'Knight_Account', N'autoshrink', N'false'
GO

exec sp_dboption N'Knight_Account', N'ANSI null default', N'false'
GO

exec sp_dboption N'Knight_Account', N'recursive triggers', N'false'
GO

exec sp_dboption N'Knight_Account', N'ANSI nulls', N'false'
GO

exec sp_dboption N'Knight_Account', N'concat null yields null', N'false'
GO

exec sp_dboption N'Knight_Account', N'cursor close on commit', N'false'
GO

exec sp_dboption N'Knight_Account', N'default to local cursor', N'false'
GO

exec sp_dboption N'Knight_Account', N'quoted identifier', N'false'
GO

exec sp_dboption N'Knight_Account', N'ANSI warnings', N'false'
GO

exec sp_dboption N'Knight_Account', N'auto create statistics', N'true'
GO

exec sp_dboption N'Knight_Account', N'auto update statistics', N'true'
GO

use [Knight_Account]
GO

if not exists (select * from master.dbo.syslogins where loginname = N'DBDB\Administrator')
	exec sp_grantlogin N'DBDB\Administrator'
	exec sp_defaultdb N'DBDB\Administrator', N'master'
	exec sp_defaultlanguage N'DBDB\Administrator', N'한국어'
GO

if not exists (select * from master.dbo.syslogins where loginname = N'Knight')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'Knight_Account', @loginlang = N'한국어'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'Knight', null, @logindb, @loginlang
END
GO

if not exists (select * from master.dbo.syslogins where loginname = N'Repent')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'Repent_Account', @loginlang = N'한국어'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'Repent', null, @logindb, @loginlang
END
GO

exec sp_addsrvrolemember N'DBDB\Administrator', sysadmin
GO

exec sp_addsrvrolemember N'Knight', sysadmin
GO

if not exists (select * from dbo.sysusers where name = N'Knight' and uid < 16382)
	EXEC sp_grantdbaccess N'Knight', N'Knight'
GO

exec sp_addrolemember N'db_owner', N'Knight'
GO

