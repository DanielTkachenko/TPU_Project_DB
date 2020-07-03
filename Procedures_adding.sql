USE TPU_Project;
GO

CREATE PROCEDURE AddUser
@FirstName varchar(45), @SecondName varchar(45), @LastName varchar(45), @Sex bit, @Role varchar(45), @Language varchar(45)
AS
DECLARE @IdLaguage uniqueidentifier
SELECT @IdLaguage = �����.[ID �����]
FROM �����
WHERE �����.������������ = @Language
INSERT INTO ������������(�������, ���, ��������, ����, ���, �����������, [ID �����])
VALUES(@SecondName,@FirstName,@LastName,@Role,@Sex,0,@IdLaguage);

go
--���������� ��������
CREATE PROCEDURE AddPhone
@FirstName varchar(45), @SecondName varchar(45), @Phonenumber varchar(11)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = ������������.[Id ������������]
FROM ������������
WHERE ������������.��� = @FirstName AND ������������.������� = @SecondName
INSERT INTO [������ ���������]([����� ��������], [Id ������������])
VALUES(@Phonenumber,@UserId);

--Email
--���������� ����������� �����
go
CREATE PROCEDURE AddEmail
@FirstName varchar(45), @SecondName varchar(45), @Email varchar(11)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = ������������.[Id ������������]
FROM ������������
WHERE ������������.��� = @FirstName AND ������������.������� = @SecondName
INSERT INTO [����������� �����](������������, [Id ������������])
VALUES(@Email,@UserId);

--���������� ������ ����
go
CREATE PROCEDURE AddMenuItem
@Level int,@NameMenu varchar(45), @NameUpperMenu varchar(45), @Language varchar(45)
AS
DECLARE @MenuId uniqueidentifier
DECLARE @UpperMenuId uniqueidentifier
DECLARE @LanguageId uniqueidentifier
SELECT @MenuId = NEWID()
SELECT @LanguageId=�����.[ID �����]
FROM �����
WHERE �����.������������ = @Language
IF @Level!=1
BEGIN
IF @NameUpperMenu is not NULL
BEGIN
SELECT @UpperMenuId = [����� ����].[Id ������ ����]
FROM [����� ����] INNER JOIN [������������� ����]
ON [����� ����].[Id ������ ����] = [������������� ����].[Id ������ ����]
INNER JOIN ����� ON [������������� ����].[ID �����] = �����.[ID �����]
WHERE [������������� ����].������������ = @NameUpperMenu AND �����.������������=@Language
IF @UpperMenuId is not NULL
BEGIN
INSERT INTO [����� ����]([Id ������ ����],�������,[FK_Id ������ ����])
VALUES(@MenuId,@Level,@UpperMenuId)
INSERT INTO [������������� ����]([Id ������ ����],������������,[ID �����])
VALUES(@MenuId,@NameMenu,@LanguageId)
END
ELSE
print 'No such upper menu item'
END
ELSE
print 'Error no upper menu name'
END
IF @Level=1
BEGIN
INSERT INTO [����� ����]([Id ������ ����],�������)
VALUES(@MenuId,@Level)
INSERT INTO [������������� ����]([Id ������ ����],������������,[ID �����])
VALUES(@MenuId,@NameMenu,@LanguageId)
END;


--���������� ������
go
CREATE PROCEDURE AddArticle
@Name varchar(30), @Text text,@Topic varchar(30), @DateTime datetime, @Language varchar(30)
AS
DECLARE @LanguageId uniqueidentifier
SELECT @LanguageId = �����.[ID �����]
FROM �����
WHERE �����.������������ = @Language
IF @DateTime is NULL
SELECT @DateTime = GETDATE()
INSERT INTO ������(��������, �����, [����� ��������],[ID �����],��������)
VALUES(@Name,@Text,@DateTime,@LanguageId,@Topic);

--���������� ���������
go
CREATE PROCEDURE AddPage
@Name varchar(30), @Language varchar(30)
AS
DECLARE @LanguageId uniqueidentifier
SELECT @LanguageId = �����.[ID �����]
FROM �����
WHERE �����.������������ = @Language
INSERT INTO ��������(��������,[ID �����])
VALUES(@Name,@LanguageId);


--���������� ������������� ����
go
CREATE PROCEDURE AddPageMenu
@NamePage varchar(30),@NameMenu varchar(30)
AS
DECLARE @IdPage uniqueidentifier
DECLARE @IdMenu uniqueidentifier
SELECT @IdMenu = [������������� ����].[Id ������ ����]
FROM [������������� ����]
WHERE [������������� ����].������������ = @NameMenu
SELECT @IdPage = ��������.[Id ��������]
FROM ��������
WHERE ��������.�������� = @NamePage
INSERT INTO [�������� ������ ����]([Id ������ ����],[Id ��������])
VALUES(@IdMenu,@IdPage);

go
CREATE PROCEDURE AddArticlesInPages
@NamePage varchar(45), @NameArticle varchar(45)
AS
DECLARE @IdPage uniqueidentifier
DECLARE @IdArticle uniqueidentifier
SELECT @IdPage = ��������.[Id ��������]
FROM ��������
WHERE ��������.�������� = @NamePage
SELECT @IdArticle = ������.[Id ������]
FROM ������
WHERE ������.�������� = @NameArticle
INSERT INTO [������ � ���������]([Id ������],[Id ��������])
VALUES(@IdArticle,@IdPage);

go
CREATE PROCEDURE AddMediaPage
@MediaId uniqueidentifier, @NamePage varchar(30)
AS
DECLARE @IdPage uniqueidentifier
SELECT @IdPage = ��������.[Id ��������]
FROM ��������
WHERE ��������.�������� = @NamePage
INSERT INTO [����� � ��������]([Id �����], [Id ��������])
VALUES(@MediaId,@IdPage);

go
CREATE PROCEDURE AddMediaArticle
@MediaId uniqueidentifier, @NameArticle varchar(30)
AS
DECLARE @IdArticle uniqueidentifier
SELECT @IdArticle = ������.[Id ������]
FROM ������
WHERE ������.�������� = @NameArticle
INSERT INTO [����� � ������]([Id �����], [Id ������])
VALUES(@MediaId,@IdArticle);

go
CREATE PROCEDURE AddHrefPage
@HrefText varchar(30), @NamePage varchar(30)
AS
DECLARE @IdPage uniqueidentifier
DECLARE @IdHref uniqueidentifier
SELECT @IdHref = ������.[Id ������]
FROM ������
WHERE ������.����� = @HrefText
SELECT @IdPage = ��������.[Id ��������]
FROM ��������
WHERE ��������.�������� = @NamePage
INSERT INTO [������ � ���������]([Id ������], [Id ��������])
VALUES(@IdHref,@IdPage);

go
CREATE PROCEDURE AddHrefArticle
@HrefText varchar(30), @NameArticle varchar(30)
AS
DECLARE @IdArticle uniqueidentifier
DECLARE @IdHref uniqueidentifier
SELECT @IdHref = ������.[Id ������]
FROM ������
WHERE ������.����� = @HrefText
SELECT @IdArticle = ������.[Id ������]
FROM ������
WHERE ������.�������� = @NameArticle
INSERT INTO [������ � �������]([Id ������], [Id ������])
VALUES(@IdHref,@IdArticle);


--���������� �����
go
CREATE PROCEDURE AddMedia
@MediaType varchar(30), @Data image, @Topic varchar(30), @Date datetime
AS
INSERT INTO �����(���, ������, ����, [����� ��������])
VALUES(@MediaType,@Data,@Topic,@Date);


--���������� ������
go
CREATE PROCEDURE AddHref
@Adress varchar(30), @Text varchar(30)
AS
INSERT INTO ������([����� ������], �����)
VALUES(@Adress,@Text)
