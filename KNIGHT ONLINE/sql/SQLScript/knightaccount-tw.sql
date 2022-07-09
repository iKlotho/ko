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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ACCOUNT_LOGIN]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ACCOUNT_LOGIN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MGAME_LOGIN]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[MGAME_LOGIN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Knight].[CONCURRENT]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Knight].[CONCURRENT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Knight_EmailRefuse]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Knight_EmailRefuse]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Knight].[TB_USER]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Knight].[TB_USER]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Knight].[VERSION]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Knight].[VERSION]
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

CREATE TABLE [Knight].[CONCURRENT] (
	[ServerID] [tinyint] NOT NULL ,
	[zone1_count] [smallint] NOT NULL ,
	[zone2_count] [smallint] NOT NULL ,
	[zone3_count] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Knight_EmailRefuse] (
	[Nid] [int] NULL ,
	[id] [char] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[email] [char] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[regDate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [Knight].[TB_USER] (
	[strAccountID] [char] (21) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[strPasswd] [char] (12) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[strName] [char] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[strSocNo] [char] (14) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[strPhone] [char] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[strZipCode] [char] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[strAddress] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[strEmail] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[RegisterTime] [smalldatetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [Knight].[VERSION] (
	[sVersion] [smallint] NOT NULL ,
	[strFileName] [char] (255) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[strCompressName] [char] (255) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[sHistoryVersion] [smallint] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [Knight].[TB_USER] WITH NOCHECK ADD 
	CONSTRAINT [PK_TB_USER] PRIMARY KEY  CLUSTERED 
	(
		[strAccountID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [Knight].[VERSION] WITH NOCHECK ADD 
	CONSTRAINT [PK_VERSION] PRIMARY KEY  CLUSTERED 
	(
		[strFileName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [Knight].[CONCURRENT] WITH NOCHECK ADD 
	CONSTRAINT [DF_CONCURRENT_zone2_count] DEFAULT (0) FOR [zone2_count],
	CONSTRAINT [DF_CONCURRENT_zone3_count] DEFAULT (0) FOR [zone3_count]
GO

ALTER TABLE [Knight].[TB_USER] WITH NOCHECK ADD 
	CONSTRAINT [DF_TB_USER_RegisterTime] DEFAULT (getdate()) FOR [RegisterTime]
GO

 CREATE  INDEX [IX_TB_USER] ON [Knight].[TB_USER]([RegisterTime]) ON [PRIMARY]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [Knight].[CONCURRENT]  TO [public]
GO

GRANT  SELECT  ON [Knight].[TB_USER]  TO [public]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [Knight].[VERSION]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

-- Created by Samma
-- 2002.01.18

CREATE PROCEDURE ACCOUNT_LOGIN
@AccountID	varchar(20),
@Password	varchar(20),
@nRet		smallint	OUTPUT

AS

declare @pwd varchar(20)

SET @pwd = null

SELECT @pwd = strPasswd FROM  knight.TB_USER WHERE strAccountID = @AccountID
IF @pwd IS null
BEGIN
	SET @nRet = 2
	RETURN
END

ELSE IF @pwd <> @Password
BEGIN
	SET @nRet = 3
	RETURN
END

SET @nRet = 1
RETURN
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE MGAME_LOGIN
@AccountID	varchar(20),
@Password	varchar(20),
@nRet		smallint	OUTPUT

AS

declare @pwd char(12)
declare @name char(20)
declare @socno char(14)
declare @phone char(20)
declare @zipcode char(10)
declare @address varchar(100)
declare @email varchar(50)

SET @pwd = null
---------------------------------------------------------------------------- User Count Limit
--declare @usercount smallint
--SET @usercount = 0
--SELECT @usercount = count(*) from TB_USER
--IF @usercount > 10000
--BEGIN
--	SET	@nRet = 2
--	RETURN
--END
-----------------------------------------------------------------------------
SELECT @pwd = password, @name = name, @socno = socno, @phone = phone, @zipcode = zipcode, @address = address, @email = email FROM [218.50.4.13].[mgame].[dbo].[tb_user] WHERE Id = @AccountID
IF @pwd IS null
BEGIN
	SET @nRet = 2
	RETURN	-- 아이디가 없음
END
ELSE IF @pwd <> @Password
BEGIN
	SET @nRet = 3	-- 패스워드 틀림
	RETURN
END
BEGIN
	INSERT INTO [knight].TB_USER ( strAccountID, strPasswd, strName, strSocNo, strPhone, strZipCode, strAddress, strEmail )
		VALUES ( @AccountID, @pwd, @name, @socno, @phone, @zipcode, @address, @email )

	IF @@ERROR <> 0
	BEGIN	 
		SET @nRet =  3
		RETURN
	END
END

SET @nRet = 1
RETURN
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

