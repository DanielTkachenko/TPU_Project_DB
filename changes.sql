use TPU_Project
GO
--15.07.20-----------------------------------
--������������ ������ ������������
alter table ������������
add [�����] varchar(100) not null
go
alter table ������������
add [������] varchar(200) not null
go
alter table ������������
drop column [�����������]
go
--��������� � view UserInfo
ALTER VIEW UserInfo AS
SELECT Us.[Id ������������], Us.�������, Us.���, Us.��������, Us.����, Us.���, �����.������������ '����', 
Em.������������ '����������� �����', Num.[����� ��������], Us.�����, Us.������
FROM ������������ Us INNER JOIN ����� ON Us.[ID �����] = �����.[ID �����]
LEFT JOIN [����������� �����] Em
ON Us.[Id ������������] = Em.[Id ������������]
LEFT JOIN [������ ���������] Num ON Us.[Id ������������] = Num.[Id ������������]
go
--��������� ��������� AddUser
ALTER PROCEDURE [AddUser]
@Login varchar(100), @Password varchar(200), @FirstName varchar(45), @SecondName varchar(45), 
@Patronymic varchar(45) = NULL, @Sex bit, @Role varchar(45), @Language varchar(45), @Email varchar(45), @PhoneNumber varchar(11)=NULL
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
INSERT INTO ������������([Id ������������], �������, ���, ��������, ����, ���, [ID �����], �����, ������)
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Login, @Password)

