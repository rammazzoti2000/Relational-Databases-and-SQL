-- -----------------------------------------------------
-- REMOVE ALL TABLES
-- -----------------------------------------------------
IF OBJECT_ID('TFilesIndex') IS NOT NULL DROP TABLE TFilesIndex
IF OBJECT_ID('TMirrorGeolocalizationLog') IS NOT NULL DROP TABLE TMirrorGeolocalizationLog
IF OBJECT_ID('TGeolocalizationLog') IS NOT NULL DROP TABLE TGeolocalizationLog
IF OBJECT_ID('TTicketMessage') IS NOT NULL DROP TABLE TTicketMessage
IF OBJECT_ID('TTicket') IS NOT NULL DROP TABLE TTicket
IF OBJECT_ID('TMirrorSysSetting') IS NOT NULL DROP TABLE TMirrorSysSetting
IF OBJECT_ID('TSysSetting') IS NOT NULL DROP TABLE TSysSetting
IF OBJECT_ID('TLogonHour') IS NOT NULL DROP TABLE TLogonHour
IF OBJECT_ID('TMirrorErrorLog') IS NOT NULL DROP TABLE TMirrorErrorLog
IF OBJECT_ID('TErrorLog') IS NOT NULL DROP TABLE TErrorLog
IF OBJECT_ID('TExecutedTask') IS NOT NULL DROP TABLE TExecutedTask
IF OBJECT_ID('TAutomaticTask') IS NOT NULL DROP TABLE TAutomaticTask
IF OBJECT_ID('TMirrorSysTransactionLog') IS NOT NULL DROP TABLE TMirrorSysTransactionLog
IF OBJECT_ID('TSysTransactionLog') IS NOT NULL DROP TABLE TSysTransactionLog
IF OBJECT_ID('TMirrorSysVisitLog') IS NOT NULL DROP TABLE TMirrorSysVisitLog
IF OBJECT_ID('TMirrorSessionLog') IS NOT NULL DROP TABLE TMirrorSessionLog
IF OBJECT_ID('TSysVisitLog') IS NOT NULL DROP TABLE TSysVisitLog
IF OBJECT_ID('TSessionLog') IS NOT NULL DROP TABLE TSessionLog
IF OBJECT_ID('TSysActionDetail') IS NOT NULL DROP TABLE TSysActionDetail
IF OBJECT_ID('TSysPermission') IS NOT NULL DROP TABLE TSysPermission
IF OBJECT_ID('TSysAction') IS NOT NULL DROP TABLE TSysAction
IF OBJECT_ID('TSysModule') IS NOT NULL DROP TABLE TSysModule
IF OBJECT_ID('TSysUser') IS NOT NULL DROP TABLE TSysUser
IF OBJECT_ID('TGroupSupervisor') IS NOT NULL DROP TABLE TGroupSupervisor
IF OBJECT_ID('TSysUserGroup') IS NOT NULL DROP TABLE TSysUserGroup
IF OBJECT_ID('TPerson') IS NOT NULL DROP TABLE TPerson
GO


-- -----------------------------------------------------
-- Table 'TPerson'
-- -----------------------------------------------------
CREATE TABLE TPerson (
 TPersonID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
 IsHuman BIT NOT NULL, 
 NumberID NVARCHAR(20) NOT NULL,
 Photo NVARCHAR(32),
 Sex SMALLINT NOT NULL default -1,
 [Name] NVARCHAR(100) NULL,
 Lastname NVARCHAR(100) NULL,
 BusinessName NVARCHAR(250) NULL,
 CreateDateTime DATETIME NOT NULL)
GO
CREATE INDEX IX_TPerson_Fulldata
ON TPerson(NumberID ASC, [Name] ASC, Lastname ASC, BusinessName ASC)
GO


-- -----------------------------------------------------
-- Table 'TSysUserGroup'
-- -----------------------------------------------------
CREATE TABLE TSysUserGroup (
 TSysUserGroupID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
 [Name] VARCHAR(75) NOT NULL,
 TimeZone INT NOT NULL,
 CreateDateTime DATETIME NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TGroupSupervisor'
-- -----------------------------------------------------
CREATE TABLE TGroupSupervisor (
 TGroupSupervisorID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
 SupervisorID BIGINT NOT NULL,
 UserGroupID BIGINT NOT NULL,
 [Read] BIT NOT NULL default 1, 
 [Add] BIT NOT NULL default 0,
 [Remove] BIT NOT NULL default 0,
 [Edit] BIT NOT NULL default 0)
GO
ALTER TABLE TGroupSupervisor WITH CHECK ADD CONSTRAINT fk_TGroupSupervisor_TSysUserGroup1_Supervisor FOREIGN KEY(SupervisorID)
REFERENCES TSysUserGroup (TSysUserGroupID)
GO
ALTER TABLE TGroupSupervisor WITH CHECK ADD CONSTRAINT fk_TGroupSupervisor_TSysUserGroup2_UserGroup FOREIGN KEY(UserGroupID)
REFERENCES TSysUserGroup (TSysUserGroupID)
GO


-- -----------------------------------------------------
-- Table 'TSysUser'
-- -----------------------------------------------------
CREATE TABLE TSysUser (
 TSysUserID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
 TPersonID BIGINT NOT NULL,
 TSysUserGroupID BIGINT NOT NULL,
 [Status] SMALLINT NOT NULL,
 Username NVARCHAR(35) NOT NULL,
 [Password] NVARCHAR(35) NOT NULL,
 Email NVARCHAR(75) NOT NULL,
 TimeZone INT NOT NULL,
 CreateDateTime DATETIME NOT NULL)
GO
ALTER TABLE TSysUser WITH CHECK ADD CONSTRAINT fk_TSysUser_TPerson FOREIGN KEY(TPersonID)
REFERENCES TPerson (TPersonID)
GO
ALTER TABLE TSysUser WITH CHECK ADD CONSTRAINT fk_TSysUser_TUserGroup FOREIGN KEY(TSysUserGroupID)
REFERENCES TSysUserGroup (TSysUserGroupID)
GO
CREATE INDEX IX_TSysUser_Fulldata
ON TSysUser(TSysUserGroupID ASC, TPersonID ASC, Username ASC, Email ASC, [Password] ASC)
GO



-- -----------------------------------------------------
-- Table 'TSysModule'
-- -----------------------------------------------------
CREATE TABLE TSysModule (
 TSysModuleID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
 [Name] VARCHAR(75) NOT NULL,
 Position INT NOT NULL,
 Icon NVARCHAR(45) NOT NULL,
 IsPublic BIT NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TSysAction'
-- -----------------------------------------------------
CREATE TABLE TSysAction (
  TSysActionID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  TSysModuleID BIGINT NOT NULL,
  [Type] SMALLINT NOT NULL,
  Title NVARCHAR(100) NOT NULL,
  [Action] NVARCHAR(150) NOT NULL,
  Icon NVARCHAR(45) NULL,
  PutInMenu BIT NOT NULL,
  Position INT NOT NULL,
  IsAuditable BIT NOT NULL,
  IsPublic BIT NOT NULL)
GO
ALTER TABLE TSysAction WITH CHECK ADD CONSTRAINT fk_TSysAction_TSysModule FOREIGN KEY(TSysModuleID)
REFERENCES TSysModule (TSysModuleID)
GO
CREATE INDEX IX_TSysAction_Permissions
ON TSysAction(TSysModuleID ASC, [Action] ASC, IsPublic ASC, IsAuditable ASC, [Type] ASC)
GO

-- -----------------------------------------------------
-- Table 'TSysPermission'
-- -----------------------------------------------------
CREATE TABLE TSysPermission (
  TSysPermissionID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  TSysActionID BIGINT NOT NULL,
  TSysUserGroupID BIGINT NOT NULL,
  [Exec] BIT NOT NULL,
  ExecAsAnother BIT NOT NULL)
GO
ALTER TABLE TSysPermission WITH CHECK ADD CONSTRAINT fk_TSysPermission_TSysAction FOREIGN KEY(TSysActionID)
REFERENCES TSysAction (TSysActionID)
GO
ALTER TABLE TSysPermission WITH CHECK ADD CONSTRAINT fk_TSysPermission_TSysUserGroup FOREIGN KEY(TSysUserGroupID)
REFERENCES TSysUserGroup (TSysUserGroupID)
GO
CREATE INDEX IX_TSysPermission_Group_Action
ON TSysPermission(TSysActionID ASC, TSysUserGroupID ASC)
GO

-- -----------------------------------------------------
-- Table 'TSysActionDetail'
-- -----------------------------------------------------
CREATE TABLE TSysActionDetail (
  TSysActionDetailID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  SysActionFatherID BIGINT NOT NULL,
  SysActionChildID BIGINT NOT NULL,
  IsPublic BIT NOT NULL)
GO
ALTER TABLE TSysActionDetail WITH CHECK ADD CONSTRAINT fk_TSysActionDetail_TSysAction1_Father FOREIGN KEY(SysActionFatherID)
REFERENCES TSysAction (TSysActionID)
GO
ALTER TABLE TSysActionDetail WITH CHECK ADD CONSTRAINT fk_TSysActionDetail_TSysAction2_Child FOREIGN KEY(SysActionChildID)
REFERENCES TSysAction (TSysActionID)
GO
CREATE INDEX IX_TSysActionDetail_Full
ON TSysActionDetail(SysActionFatherID ASC, SysActionChildID ASC)
GO

-- -----------------------------------------------------
-- Table 'TSessionLog'
-- -----------------------------------------------------
CREATE TABLE TSessionLog (
  TSessionLogID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  LogDateTime DATETIME NOT NULL,
  [User] NVARCHAR(35) NOT NULL,
  [IP] NVARCHAR(45) NOT NULL,
  Result BIGINT NOT NULL)
GO
CREATE INDEX IX_TSessionLog_Full
ON TSessionLog(LogDateTime ASC, [User] ASC, [IP] ASC, Result DESC)
GO


-- -----------------------------------------------------
-- Table 'TSysVisitLog'
-- -----------------------------------------------------
CREATE TABLE TSysVisitLog (
  TSysVisitLogID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  LogDateTime DATETIME NOT NULL,
  [User] NVARCHAR(35) NOT NULL,
  [IP] NVARCHAR(45) NOT NULL,
  Agent NVARCHAR(200) NOT NULL,
  [URL] NVARCHAR(250) NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TMirrorSessionLog'
-- -----------------------------------------------------
CREATE TABLE TMirrorSessionLog (
  LogDateTime DATETIME NOT NULL,
  [User] NVARCHAR(35) NOT NULL,
  [IP] NVARCHAR(45) NOT NULL,
  Result BIGINT NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TMirrorSysVisitLog'
-- -----------------------------------------------------
CREATE TABLE TMirrorSysVisitLog (
  LogDateTime DATETIME NOT NULL,
  [User] NVARCHAR(35) NOT NULL,
  [IP] NVARCHAR(45) NOT NULL,
  Agent NVARCHAR(200) NOT NULL,
  [URL] NVARCHAR(250) NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TSysTransactionLog'
-- -----------------------------------------------------
CREATE TABLE TSysTransactionLog (
 TSysTransactionLogID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
 LogDateTime DATETIME NOT NULL,
 SysTransaction NVARCHAR(75) NOT NULL,
 Method VARCHAR(150) NOT NULL,
 [Data] NVARCHAR(800) NOT NULL,
 [URL] NVARCHAR(250) NOT NULL,
 [User] NVARCHAR(35) NOT NULL,
 Agent NVARCHAR(200) NOT NULL,
 [IP] NVARCHAR(45) NOT NULL)
GO
CREATE INDEX IX_TSysTransactionLog_Tran_User
ON TSysTransactionLog(SysTransaction ASC, [User] ASC)
GO


-- -----------------------------------------------------
-- Table 'TMirrorSysTransactionLog'
-- -----------------------------------------------------
CREATE TABLE TMirrorSysTransactionLog (
  LogDateTime DATETIME NOT NULL,
  SysTransaction NVARCHAR(75) NOT NULL,
  Method VARCHAR(150) NOT NULL,
  [Data] NVARCHAR(800) NOT NULL,
  [URL] NVARCHAR(250) NOT NULL,
  [User] NVARCHAR(35) NOT NULL,
  Agent NVARCHAR(200) NOT NULL,
  [IP] NVARCHAR(45) NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TAutomaticTask'
-- -----------------------------------------------------
CREATE TABLE TAutomaticTask (
  TAutomaticTaskID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  AutomaticTask VARCHAR(75) NOT NULL,
  ScheduledTime TIME NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TExecutedTask'
-- -----------------------------------------------------
CREATE TABLE TExecutedTask (
  TExecutedTaskID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  TAutomaticTaskID BIGINT NOT NULL,
  ExecDateTime DATETIME NOT NULL)
GO
ALTER TABLE TExecutedTask WITH CHECK ADD CONSTRAINT fk_TExecutedTask_TAutomaticTask FOREIGN KEY(TAutomaticTaskID)
REFERENCES TAutomaticTask (TAutomaticTaskID)
GO
CREATE INDEX IX_TExecutedTask_Full
ON TExecutedTask(TAutomaticTaskID ASC)
GO

-- -----------------------------------------------------
-- Table 'TErrorLog'
-- -----------------------------------------------------
CREATE TABLE TErrorLog (
  TErrorLogID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  LogDateTime DATETIME NOT NULL,
  [User] NVARCHAR(35) NOT NULL,
  [IP] NVARCHAR(45) NOT NULL,
  Error NVARCHAR(250) NOT NULL,
  [Message] NVARCHAR(500) NOT NULL,
  StackTrace NVARCHAR(500) NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TMirrorErrorLog'
-- -----------------------------------------------------
CREATE TABLE TMirrorErrorLog (
  LogDateTime DATETIME NOT NULL,
  [User] NVARCHAR(35) NOT NULL,
  [IP] NVARCHAR(45) NOT NULL,
  Error NVARCHAR(250) NOT NULL,
  [Message] NVARCHAR(500) NOT NULL,
  StackTrace NVARCHAR(500) NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TLogonHour'
-- -----------------------------------------------------
CREATE TABLE TLogonHour (
  TLogonHoursID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  TSysUserGroupID BIGINT NOT NULL,
  [Day] INT NOT NULL,
  H00H01 BIT NOT NULL, H01H02 BIT NOT NULL, H02H03 BIT NOT NULL, H03H04 BIT NOT NULL,
  H04H05 BIT NOT NULL, H05H06 BIT NOT NULL, H06H07 BIT NOT NULL, H07H08 BIT NOT NULL,
  H08H09 BIT NOT NULL, H09H10 BIT NOT NULL, H10H11 BIT NOT NULL, H11H12 BIT NOT NULL,
  H12H13 BIT NOT NULL, H13H14 BIT NOT NULL, H14H15 BIT NOT NULL, H15H16 BIT NOT NULL,
  H16H17 BIT NOT NULL, H17H18 BIT NOT NULL, H18H19 BIT NOT NULL, H19H20 BIT NOT NULL,
  H20H21 BIT NOT NULL, H21H22 BIT NOT NULL, H22H23 BIT NOT NULL, H23H24 BIT NOT NULL)
GO
ALTER TABLE TLogonHour WITH CHECK ADD CONSTRAINT fk_TLogonHour_TSysUserGroup FOREIGN KEY(TSysUserGroupID)
REFERENCES TSysUserGroup (TSysUserGroupID)
GO



-- -----------------------------------------------------
-- Table 'TSysSetting'
-- -----------------------------------------------------
CREATE TABLE TSysSetting (
  TSysSettingID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  SysKey NVARCHAR(25) NOT NULL,
  IsEncrypted BIT NOT NULL,
  SysValue NVARCHAR(150) NOT NULL,
  [Description] NVARCHAR(150) NOT NULL,
  CreateDateTime DATETIME NOT NULL) 
GO
CREATE INDEX IX_TSysSetting_Full
ON TSysSetting(SysKey ASC, SysValue ASC)
GO


-- -----------------------------------------------------
-- Table 'TMirrorSysSetting'
-- -----------------------------------------------------
CREATE TABLE TMirrorSysSetting (
  SysKey NVARCHAR(25) NOT NULL,
  IsEncrypted BIT NOT NULL,
  SysValue NVARCHAR(150) NOT NULL,
  [Description] NVARCHAR(150) NOT NULL,
  CreateDateTime DATETIME NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TTicket'
-- -----------------------------------------------------
CREATE TABLE TTicket (
  TTicketID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  CreatorUserID BIGINT NOT NULL,
  TicketTypeID BIGINT NOT NULL,
  TicketDateTime DATETIME NOT NULL,
  [Status] SMALLINT NOT NULL,
  [Subject] NVARCHAR(75) NOT NULL,
  Rating SMALLINT NOT NULL)
GO
ALTER TABLE TTicket WITH CHECK ADD CONSTRAINT fk_TTicket_TSysUser FOREIGN KEY(CreatorUserID)
REFERENCES TSysUser (TSysUserID)
GO
CREATE INDEX IX_TTicket_User_Creator
ON TTicket(CreatorUserID ASC)
GO


-- -----------------------------------------------------
-- Table 'TTicketMessage'
-- -----------------------------------------------------
CREATE TABLE TTicketMessage (
  TTicketMessageID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  TTicketID BIGINT NOT NULL,
  FromUserID BIGINT NOT NULL,
  ToUserID BIGINT NOT NULL,
  CreateDateTime DATETIME NOT NULL,
  [Message] NVARCHAR(450) NOT NULL,
  FileAttach NVARCHAR(32))
GO
ALTER TABLE TTicketMessage WITH CHECK ADD CONSTRAINT fk_TTicketMessage_TTicket FOREIGN KEY(TTicketID)
REFERENCES TTicket (TTicketID)
GO
ALTER TABLE TTicketMessage WITH CHECK ADD CONSTRAINT fk_TTicketMessage_TSysUser1_From FOREIGN KEY(FromUserID)
REFERENCES TSysUser (TSysUserID)
GO
ALTER TABLE TTicketMessage WITH CHECK ADD CONSTRAINT fk_TTicketMessage_TSysUser2_To FOREIGN KEY(ToUserID)
REFERENCES TSysUser (TSysUserID)
GO
CREATE INDEX IX_TTicketMessage_Users
ON TTicketMessage(TTicketID ASC, FromUserID ASC, ToUserID ASC)
GO


-- -----------------------------------------------------
-- Table 'TGeolocalizationLog'
-- -----------------------------------------------------
CREATE TABLE TGeolocalizationLog (
  TGeolocalizationLogID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  LogDateTime DATETIME NOT NULL,
  [IP] NVARCHAR(45) NOT NULL,
  Latitude NVARCHAR(25) NOT NULL,
  Longitude NVARCHAR(25) NOT NULL) 
GO


-- -----------------------------------------------------
-- Table 'TMirrorGeolocalizationLog'
-- -----------------------------------------------------
CREATE TABLE TMirrorGeolocalizationLog (
  LogDateTime DATETIME NOT NULL,
  [IP] NVARCHAR(45) NOT NULL,
  Latitude NVARCHAR(25) NOT NULL,
  Longitude NVARCHAR(25) NOT NULL)
GO


-- -----------------------------------------------------
-- Table 'TFilesIndex'
-- -----------------------------------------------------
CREATE TABLE TFilesIndex (
  TFilesIndexID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  [CreatorUser] NVARCHAR(35) NOT NULL,
  [Path] NVARCHAR(200) NOT NULL,
  [Filename] NVARCHAR(120) NOT NULL,
  Extension NVARCHAR(10) NOT NULL,
  CreateDateTime DATETIME NOT NULL,
  LastModificationDateTime DATETIME,
  DeleteDateTime DATETIME)
GO


