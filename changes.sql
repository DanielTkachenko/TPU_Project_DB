use TPU_Project
GO

11.09.20
CREATE TABLE [Пользователь сброс пароля]
([ID пользователя] uniqueidentifier not null,
[Токен для сброса] varchar(100) not null,
[Время добавления] datetime not null,
foreign key([ID пользователя]) references Пользователь([Id Пользователя]),
primary key([ID пользователя], [Токен для сброса]))

go

CREATE PROCEDURE [EditPasswordUser]
@email varchar(100), @newPassword varchar(100), @token varchar(100)
AS
DECLARE @userid uniqueidentifier
SELECT @userid = (SELECT [Id Пользователя] FROM [Электронная почта] WHERE [Наименование] = @email)
IF EXISTS (SELECT * FROM [Пользователь сброс пароля] WHERE [ID пользователя] = @userid AND [Токен для сброса] = @token)
BEGIN
	UPDATE Пользователь
	SET Пароль = @newPassword
	WHERE [Id Пользователя] = @userid
END
RETURN @@ROWCOUNT

GO

CREATE PROCEDURE AddResetPasswordRequest
@email varchar(100), @token varchar(100)
AS
DECLARE @userid uniqueidentifier
SELECT @userid = (SELECT [Id Пользователя] FROM [Электронная почта] WHERE [Наименование] = @email)
INSERT INTO [Пользователь сброс пароля]([ID пользователя], [Токен для сброса], [Время добавления])
VALUES(@userid, @token, GETDATE())