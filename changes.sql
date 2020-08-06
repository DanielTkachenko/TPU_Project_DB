use TPU_Project
GO
--06.08.20-----------------------------------

----��������� � ������� ������������� ���� ������� ��� ��������
--alter table [����� ����]
--add [ID ��������] uniqueidentifier null
--go
--alter table [����� ����]
--add foreign key([ID ��������]) references [�����]([Id �����])
--go

----������������ �� ��� �������
--ALTER PROCEDURE [dbo].[AddMenuItem]
--@Level int,@NameMenu varchar(45), @NameUpperMenu varchar(45), @Language varchar(45), 
--@Order int, @type varchar(20), @url varchar(100), @img uniqueidentifier = null
--AS
--DECLARE @MenuId uniqueidentifier
--DECLARE @UpperMenuId uniqueidentifier
--DECLARE @LanguageId uniqueidentifier
--SELECT @MenuId = NEWID()
--SELECT @LanguageId=�����.[ID �����]
--FROM �����
--WHERE �����.������������ = @Language
--IF @Level!=1
--BEGIN
--IF @NameUpperMenu is not NULL
--BEGIN
--SELECT @UpperMenuId = [����� ����].[Id ������ ����]
--FROM [����� ����] INNER JOIN [������������� ����]
--ON [����� ����].[Id ������ ����] = [������������� ����].[Id ������ ����]
--INNER JOIN ����� ON [������������� ����].[ID �����] = �����.[ID �����]
--WHERE [������������� ����].������������ = @NameUpperMenu AND �����.������������=@Language
--IF @UpperMenuId is not NULL
--BEGIN
--INSERT INTO [����� ����]([Id ������ ����],�������,[FK_Id ������ ����], [������� �����������], [��� ����], [URL], [ID ��������])
--VALUES(@MenuId,@Level,@UpperMenuId, @Order, @type, @url, @img)
--INSERT INTO [������������� ����]([Id ������ ����],������������,[ID �����])
--VALUES(@MenuId,@NameMenu,@LanguageId)
--END
--ELSE
--print 'No such upper menu item'
--END
--ELSE
--print 'Error no upper menu name'
--END
--IF @Level=1
--BEGIN
--INSERT INTO [����� ����]([Id ������ ����],�������, [������� �����������], [��� ����], [URL], [ID ��������])
--VALUES(@MenuId,@Level, @Order,@type, @url, @img)
--INSERT INTO [������������� ����]([Id ������ ����],������������,[ID �����])
--VALUES(@MenuId,@NameMenu,@LanguageId)
--END;
--go
----����������� ������������� ����
--ALTER VIEW Menu AS
--SELECT P1.[Id ������ ����] 'ID', Pr1.������������ '����������', P1.������� '������� ����', Jz1.������������ '���� �����������' ,P1.[��� ����] '���', 
--P1.[URL] '������', P1.[������� �����������], SP1.[ID ������] 'ID ������', P1.[ID ��������] 'ID ��������', P2.[Id ������ ����] 'ID ��������', Pr2.������������ '��������'
--FROM ([����� ����] P1 
--INNER JOIN [������������� ����] Pr1 ON P1.[Id ������ ����] = Pr1.[Id ������ ����]
--LEFT JOIN [������ ������ ����] SP1 ON SP1.[ID ������ ����] = P1.[Id ������ ����]
--INNER JOIN ����� Jz1 ON Pr1.[ID �����] = Jz1.[ID �����])
--LEFT JOIN ([����� ����] P2 INNER JOIN [������������� ����] Pr2 ON P2.[Id ������ ����]=Pr2.[Id ������ ����])
--ON P1.[FK_Id ������ ����] = P2.[Id ������ ����]

--������������� ���� ����� � �������������� ���������� ����� ��������� � �������������
alter table [������������]
alter column [������] varchar(100) not null
go
alter table [����������� �����]
alter column [������������] varchar(100) not null
go
alter table [������������]
alter column [���] varchar(50) not null
go
alter table [������������]
alter column [�������] varchar(50) null
go
alter table [������������]
alter column [��������] varchar(50) null
go
alter table [������������]
alter column [���] varchar(20) null
go
alter table [�����]
alter column [������������] varchar(20) not null
go
alter table [������ ���������]
alter column [����� ��������] varchar(20) null
go
--������������ ���� � �� AddUser
ALTER PROCEDURE [dbo].[AddUser]
@Provider varchar(30), @Password varchar(100), @FirstName varchar(50), @SecondName varchar(50) = null, 
@Patronymic varchar(50) = NULL, @Sex varchar(20) = null, @Role varchar(45), @Language varchar(20), @Email varchar(100), @PhoneNumber varchar(20)=NULL
AS
DECLARE @IdLaguage uniqueidentifier, @UserId uniqueidentifier
SELECT @IdLaguage = �����.[ID �����]
FROM �����
WHERE �����.������������ = @Language
SELECT  @UserId=NEWID()
IF @PhoneNumber IS NOT NULL
BEGIN
	INSERT INTO [������ ���������] VALUES (NEWID(), @PhoneNumber,@UserId)
END
INSERT INTO [����������� �����] VALUES (NEWID(), @Email, @UserId)
INSERT INTO ������������([Id ������������], �������, ���, ��������, ����, ���, [ID �����], ������, [Provider])
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Password, @Provider)
