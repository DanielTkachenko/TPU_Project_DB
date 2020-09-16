use TPU_Project
GO

11.09.20
CREATE TABLE [������������ ����� ������]
([ID ������������] uniqueidentifier not null,
[����� ��� ������] varchar(100) not null,
[����� ����������] datetime not null,
foreign key([ID ������������]) references ������������([Id ������������]),
primary key([ID ������������], [����� ��� ������]))

go

CREATE PROCEDURE [EditPasswordUser]
@email varchar(100), @newPassword varchar(100), @token varchar(100)
AS
DECLARE @userid uniqueidentifier
SELECT @userid = (SELECT [Id ������������] FROM [����������� �����] WHERE [������������] = @email)
IF EXISTS (SELECT * FROM [������������ ����� ������] WHERE [ID ������������] = @userid AND [����� ��� ������] = @token)
BEGIN
	UPDATE ������������
	SET ������ = @newPassword
	WHERE [Id ������������] = @userid
END
RETURN @@ROWCOUNT

GO

CREATE PROCEDURE AddResetPasswordRequest
@email varchar(100), @token varchar(100)
AS
DECLARE @userid uniqueidentifier
SELECT @userid = (SELECT [Id ������������] FROM [����������� �����] WHERE [������������] = @email)
INSERT INTO [������������ ����� ������]([ID ������������], [����� ��� ������], [����� ����������])
VALUES(@userid, @token, GETDATE())