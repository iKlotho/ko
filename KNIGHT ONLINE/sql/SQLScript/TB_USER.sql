if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TB_USER]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TB_USER]
GO

CREATE TABLE [dbo].[TB_USER] (
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

ALTER TABLE [dbo].[TB_USER] WITH NOCHECK ADD 
	CONSTRAINT [PK_TB_USER] PRIMARY KEY  CLUSTERED 
	(
		[strAccountID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TB_USER] WITH NOCHECK ADD 
	CONSTRAINT [DF_TB_USER_RegisterTime] DEFAULT (getdate()) FOR [RegisterTime]
GO

 CREATE  INDEX [IX_TB_USER] ON [dbo].[TB_USER]([RegisterTime]) ON [PRIMARY]
GO

