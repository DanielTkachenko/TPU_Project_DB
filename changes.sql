use TPU_Project
GO
--09.08.20-----------------------------------

--��������� � ������� ������������ ������� ��� ������������� �����������
ALTER TABLE [������������]
ADD [�����������] bit not null default 0
GO
ALTER VIEW UserInfo AS
SELECT Us.[Id ������������], Us.�������, Us.���, Us.��������, Us.����, Us.���, �����.������������ '����', 
Em.������������ '����������� �����', Us.[�����������], Num.[����� ��������], Us.������, Us.[refresh salt], Us.[Provider]
FROM ������������ Us INNER JOIN ����� ON Us.[ID �����] = �����.[ID �����]
LEFT JOIN [����������� �����] Em
ON Us.[Id ������������] = Em.[Id ������������]
LEFT JOIN [������ ���������] Num ON Us.[Id ������������] = Num.[Id ������������]
go
ALTER PROCEDURE [dbo].[AddUser]
@Provider varchar(30), @Password varchar(100), @FirstName varchar(50), @SecondName varchar(50) = null, 
@Patronymic varchar(50) = NULL, @Role varchar(45), @Language varchar(20), 
@Email varchar(100), @PhoneNumber varchar(20)=NULL, @Sex varchar(20) = null, @verified bit = 0
AS
DECLARE @IdLaguage uniqueidentifier, @UserId uniqueidentifier
SELECT @IdLaguage = �����.[ID �����]
FROM �����
WHERE �����.������������ = @Language
SELECT  @UserId=NEWID()
INSERT INTO ������������([Id ������������], �������, ���, ��������, ����, ���, [ID �����], ������, [Provider], [�����������])
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Password, @Provider, @verified)
IF @PhoneNumber IS NOT NULL
BEGIN
	INSERT INTO [������ ���������] VALUES (NEWID(), @PhoneNumber,@UserId)
END
INSERT INTO [����������� �����] VALUES (NEWID(), @Email, @UserId)
go
--������� �� ��� ��������� ������� �����������
ALTER PROCEDURE [dbo].[EditRegisteredStatus]
@email varchar(100), @status bit
AS
UPDATE ������������
SET [�����������] = @status
FROM [������������] Us join [����������� �����] Em ON Us.[Id ������������] = Em.[Id ������������]
WHERE Em.������������ = @email and Us.[�����������] != @status
RETURN @@ROWCOUNT