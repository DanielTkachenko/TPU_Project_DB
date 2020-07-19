use TPU_Project
GO
--19.07.20-----------------------------------
--� ������� ����������� ����� ������������� ������������ ��� ����� ����������� �����
alter table [����������� �����]
add constraint EMAIL_UNIQUE unique([������������])
go
--������������ ������� ������������ / ��������� ������� ��� �������� ���� ����������� � ������� ������� �����
alter table [������������]
drop column [�����]
go
alter table [������������]
add [Provider] varchar(30) not null
go
ALTER VIEW UserInfo AS
SELECT Us.[Id ������������], Us.�������, Us.���, Us.��������, Us.����, Us.���, �����.������������ '����', 
Em.������������ '����������� �����', Num.[����� ��������], Us.������, Us.[refresh salt], Us.[Provider]
FROM ������������ Us INNER JOIN ����� ON Us.[ID �����] = �����.[ID �����]
LEFT JOIN [����������� �����] Em
ON Us.[Id ������������] = Em.[Id ������������]
LEFT JOIN [������ ���������] Num ON Us.[Id ������������] = Num.[Id ������������]
go
--������� �� ��������� AddUser �������� ����� � ��������� �������� Provider
ALTER PROCEDURE [AddUser]
@Provider varchar(30), @Password varchar(200), @FirstName varchar(45), @SecondName varchar(45) = null, 
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
INSERT INTO ������������([Id ������������], �������, ���, ��������, ����, ���, [ID �����], ������, [Provider])
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Password, @Provider)
go
--����������� �� EditUserRefreshSalt / �� ���� �������� email
ALTER procedure [EditUserRefreshSalt]
@Salt varchar(50), @email varchar(30)
as
update [������������] 
set [refresh salt] = @Salt
from (select Us.[Id ������������], Us.[refresh salt] 
from [������������] Us join [����������� �����] Em on Us.[Id ������������]=Em.[Id ������������]
where [������������] = @email) as Selected
where ������������.[Id ������������] = Selected.[Id ������������]
go
--������� �� GetUserByLogin
drop procedure GetUserByLogin