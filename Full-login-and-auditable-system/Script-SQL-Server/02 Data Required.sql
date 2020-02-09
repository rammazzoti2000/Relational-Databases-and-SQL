-- -----------------------------------------------------
-- SysModule 'Home'
-- -----------------------------------------------------
INSERT INTO TSysModule ([Name], Position, Icon, IsPublic)
VALUES('Home', 0, '', 1)
GO


-- -----------------------------------------------------
-- Person 'Administrator' and 'Nobody'
-- -----------------------------------------------------
INSERT INTO TPerson (IsHuman, NumberID, Sex, [BusinessName], CreateDateTime)
VALUES (0, '0', -1, 'Administrator', GETUTCDATE())
GO
INSERT INTO TPerson (IsHuman, NumberID, Sex, [BusinessName], CreateDateTime)
VALUES (0, '0', -1, 'Nobody', GETUTCDATE())
GO

-- -----------------------------------------------------
-- User Group for 'Administrators', 'Nobodys' and 'Default'
-- -----------------------------------------------------
INSERT INTO TSysUserGroup ([Name], TimeZone, CreateDateTime)
VALUES ('Administrators', 0, GETUTCDATE())
GO
INSERT INTO TSysUserGroup ([Name], TimeZone, CreateDateTime)
VALUES ('Nobodys', 0, GETUTCDATE())
GO
INSERT INTO TSysUserGroup ([Name], TimeZone, CreateDateTime)
VALUES ('Default', 0, GETUTCDATE())
GO

-- -----------------------------------------------------
-- User for persons 'Administrator' and 'Nobody'
-- -----------------------------------------------------
INSERT INTO TSysUser (TPersonID, TSysUserGroupID, [Status], Username, Email, [Password], TimeZone, CreateDateTime)
VALUES (1, 1, 1, 'administrator', '', '', 0, GETUTCDATE())
GO
INSERT INTO TSysUser (TPersonID, TSysUserGroupID, [Status], Username, Email, [Password], TimeZone, CreateDateTime)
VALUES (1, 1, 1, 'nobody', '', '', 0, GETUTCDATE())
GO

-- -----------------------------------------------------
-- Schedule for user group 'Administrators', 'Nobodys' and 'Default'
-- -----------------------------------------------------
INSERT INTO TLogonHour (TSysUserGroupID, [Day], H00H01, H01H02, H02H03, H03H04, H04H05, H05H06, H06H07, H07H08, H08H09, H09H10, H10H11, H11H12, H12H13, H13H14, H14H15, H15H16, H16H17, H17H18, H18H19, H19H20, H20H21, H21H22, H22H23, H23H24)
VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (1 , 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (1 , 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (1 , 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (1 , 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (1 , 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (1 , 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
GO
INSERT INTO TLogonHour (TSysUserGroupID, [Day], H00H01, H01H02, H02H03, H03H04, H04H05, H05H06, H06H07, H07H08, H08H09, H09H10, H10H11, H11H12, H12H13, H13H14, H14H15, H15H16, H16H17, H17H18, H18H19, H19H20, H20H21, H21H22, H22H23, H23H24)
VALUES (2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (2 , 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (2 , 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (2 , 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (2 , 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (2 , 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (2 , 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
GO
INSERT INTO TLogonHour (TSysUserGroupID, [Day], H00H01, H01H02, H02H03, H03H04, H04H05, H05H06, H06H07, H07H08, H08H09, H09H10, H10H11, H11H12, H12H13, H13H14, H14H15, H15H16, H16H17, H17H18, H18H19, H19H20, H20H21, H21H22, H22H23, H23H24)
VALUES (3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (3 , 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (3 , 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (3 , 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (3 , 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (3 , 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		, (3 , 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
GO
