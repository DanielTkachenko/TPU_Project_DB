use TPU_Project
GO

--16.09.20
CREATE TABLE [���������]
([ID ���������] uniqueidentifier not null,
[���������� ���������] varbinary,
[���� �������� ���������] datetime,
[�������� ���������] nvarchar(100) not null,
[�������� �����] nvarchar(100) not null,
PRIMARY KEY([ID ���������]))
GO

CREATE TABLE [��������� ������������]
([ID ������������] uniqueidentifier not null,
[ID ���������] uniqueidentifier not null,
PRIMARY KEY([ID ������������], [ID ���������]),
FOREIGN KEY([ID ������������]) REFERENCES [������������]([Id ������������]),
FOREIGN KEY([ID ���������]) REFERENCES [���������]([ID ���������]))
GO

CREATE PROCEDURE GetDocumentsWithoutContent
@email varchar(100)
AS
DECLARE @userid uniqueidentifier
SELECT @userid = (SELECT [Id ������������] FROM [����������� �����] WHERE [������������] = @email)
SELECT DOC.[ID ���������], [���� �������� ���������], [�������� ���������], [�������� �����]
FROM [��������� ������������] UD JOIN [���������] DOC ON UD.[ID ���������] = DOC.[ID ���������]
WHERE [ID ������������] = @userid
ORDER BY [���� �������� ���������] DESC
go

CREATE TABLE [��������� ������]
([��������] nvarchar(500),
[��������] nvarchar(500))
go

CREATE TABLE [������������� ������� ������]
([ID ������] uniqueidentifier not null,
[����� ������] varchar(10),
[������������� ������] varchar(100),
PRIMARY KEY([ID ������]))
go

ALTER PROCEDURE GetUtilParameter
@key nvarchar(500),
@parameter nvarchar(500) OUTPUT
AS
SELECT @parameter = [��������] FROM [��������� ������]
WHERE [��������] = @key
go

--������������ �� � ������� ��������� � ������������� / ��������� ����� ������


ALTER TABLE [������������]
ADD [ID ������] uniqueidentifier
go
ALTER TABLE [������������]
ADD FOREIGN KEY([ID ������]) REFERENCES [������������� ������� ������]([ID ������])
go

ALTER PROCEDURE [dbo].[AddUser]
@Provider varchar(30), @Password varchar(100), @FirstName varchar(50), @SecondName varchar(50) = null, 
@Patronymic varchar(50) = NULL, @Role varchar(45), @Language varchar(20), 
@Email varchar(100), @PhoneNumber varchar(20)=NULL, @Sex varchar(20) = null, @verified bit = 0, @idGroup uniqueidentifier = null
AS
DECLARE @IdLaguage uniqueidentifier, @UserId uniqueidentifier
SELECT @IdLaguage = �����.[ID �����]
FROM �����
WHERE �����.������������ = @Language
SELECT  @UserId=NEWID()
INSERT INTO ������������([Id ������������], �������, ���, ��������, ����, ���, [ID �����], ������, [Provider], [�����������], [ID ������])
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Password, @Provider, @verified, @idGroup)
IF @PhoneNumber IS NOT NULL
BEGIN
	INSERT INTO [������ ���������] VALUES (NEWID(), @PhoneNumber,@UserId)
END
INSERT INTO [����������� �����] VALUES (NEWID(), @Email, @UserId)
go

ALTER PROCEDURE [dbo].[EditUser]
@email varchar(100), @psw varchar(100), @firstName varchar(50), @lang varchar(20), @secondName varchar(50) = null, @patronymic varchar(50) = null,
@sex varchar(20) = null, @phoneNum varchar(20) = null, @idGroup uniqueidentifier = null
AS
DECLARE @langid uniqueidentifier, @userid uniqueidentifier
SET @langid = (SELECT [ID �����] FROM [�����] WHERE [������������] = @lang)
SET @userid = (SELECT Us.[Id ������������] 
FROM [������������] Us JOIN [����������� �����] Em ON Us.[Id ������������] = Em.[Id ������������] 
WHERE Em.������������ = @email)
UPDATE [������������]
SET ��� = @firstName, ������� = @secondName, �������� = @patronymic, ��� = @sex, [ID �����] = @langid, [ID ������] = @idGroup
WHERE [Id ������������] = @userid;
IF @psw IS NOT NULL
BEGIN
	UPDATE [������������]
	SET [������] = @psw
	WHERE [Id ������������] = @userid
END
IF @phoneNum != NULL
BEGIN
	IF EXISTS (SELECT * FROM [������ ���������] WHERE [Id ������������] = @userid)
	BEGIN
		UPDATE [������ ���������]
		SET [����� ��������] = @phoneNum
		WHERE [Id ������������] = @userid
	END
	ELSE
	BEGIN
		INSERT INTO [������ ���������]([Id ��������], [Id ������������], [����� ��������])
		VALUES(NEWID(), @userid, @phoneNum)
	END
END
GO

ALTER VIEW UserInfo AS
SELECT Us.[Id ������������], Us.�������, Us.���, Us.��������, Us.����, Us.���, �����.������������ '����', 
Em.������������ '����������� �����', Us.[�����������], Num.[����� ��������], Us.������, Us.[refresh salt], Us.[Provider], Us.[ID ������]
FROM ������������ Us INNER JOIN ����� ON Us.[ID �����] = �����.[ID �����]
LEFT JOIN [����������� �����] Em
ON Us.[Id ������������] = Em.[Id ������������]
LEFT JOIN [������ ���������] Num ON Us.[Id ������������] = Num.[Id ������������]
go

----------
CREATE PROCEDURE GetUserGroupID
@email varchar(100), @internalGroupID varchar(100) OUTPUT
AS
DECLARE @groupid uniqueidentifier
SET @groupid = (SELECT Us.[ID ������] FROM [����������� �����] Em JOIN [������������]Us ON Em.[Id ������������] = Us.[Id ������������]  
WHERE Em.[������������] = @email)
SELECT @internalGroupID = (SELECT [������������� ������] FROM [������������� ������� ������] WHERE [ID ������] = @groupid)
GO

CREATE PROCEDURE GetDocumentsWithContent
@email varchar(100)
AS
DECLARE @userid uniqueidentifier
SELECT @userid = (SELECT [Id ������������] FROM [����������� �����] WHERE [������������] = @email)
SELECT *
FROM [��������� ������������] UD JOIN [���������] DOC ON UD.[ID ���������] = DOC.[ID ���������]
WHERE [ID ������������] = @userid
ORDER BY [���� �������� ���������] DESC