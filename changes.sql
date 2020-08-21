use TPU_Project
GO
--13.08.20-----------------------------------

--create procedure EditUser
CREATE PROCEDURE EditUser
@email varchar(100), @psw varchar(100), @firstName varchar(50), @lang varchar(20), @secondName varchar(50) = null, @patronymic varchar(50) = null,
@sex varchar(20) = null, @phoneNum varchar(20) = null
AS
DECLARE @langid uniqueidentifier, @userid uniqueidentifier
--������� id ����� �� ������������
SET @langid = (SELECT [ID �����] FROM [�����] WHERE [������������] = @lang)
--������� id ������������ �� email
SET @userid = (SELECT Us.[Id ������������] 
FROM [������������] Us JOIN [����������� �����] Em ON Us.[Id ������������] = Em.[Id ������������] 
WHERE Em.������������ = @email)
UPDATE [������������]
SET ������ = @psw, ��� = @firstName, ������� = @secondName, �������� = @patronymic, ��� = @sex, [ID �����] = @langid
WHERE [Id ������������] = @userid;
UPDATE [������ ���������]
SET [����� ��������] = @phoneNum
WHERE [Id ������������] = @userid
GO
--21.08.20
--edit procedure AddMenuItem / added parameter @articleId
ALTER PROCEDURE [dbo].[AddMenuItem]
@Level int,@NameMenu varchar(45), @NameUpperMenu varchar(45), @Language varchar(45), 
@Order int, @type varchar(20), @url varchar(100), @img uniqueidentifier = NULL, @articleId uniqueidentifier = NULL
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
INSERT INTO [����� ����]([Id ������ ����],�������,[FK_Id ������ ����], [������� �����������], [��� ����], [URL], [ID ��������])
VALUES(@MenuId,@Level,@UpperMenuId, @Order, @type, @url, @img)
INSERT INTO [������������� ����]([Id ������ ����],������������,[ID �����])
VALUES(@MenuId,@NameMenu,@LanguageId)
IF @articleId != NULL
BEGIN
INSERT INTO [������ ������ ����]([ID ������ ����], [ID ������])
VALUES(@MenuId, @articleId)
END
END
ELSE
print 'No such upper menu item'
END
ELSE
print 'Error no upper menu name'
END
IF @Level=1
BEGIN
INSERT INTO [����� ����]([Id ������ ����],�������, [������� �����������], [��� ����], [URL], [ID ��������])
VALUES(@MenuId,@Level, @Order,@type, @url, @img)
INSERT INTO [������������� ����]([Id ������ ����],������������,[ID �����])
VALUES(@MenuId,@NameMenu,@LanguageId)
IF @articleId != NULL
BEGIN
INSERT INTO [������ ������ ����]([ID ������ ����], [ID ������])
VALUES(@MenuId, @articleId)
END
END;