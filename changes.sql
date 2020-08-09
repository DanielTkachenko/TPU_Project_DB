use TPU_Project
GO
--09.08.20-----------------------------------

--добавляем в таблицу Пользователь колонку для подтверждения регистрации
ALTER TABLE [Пользователь]
ADD [Подтвержден] bit not null default 0
GO
ALTER VIEW UserInfo AS
SELECT Us.[Id Пользователя], Us.Фамилия, Us.Имя, Us.Отчество, Us.Роль, Us.Пол, Языки.Наименование 'Язык', 
Em.Наименование 'Электронная почта', Us.[Подтвержден], Num.[Номер телефона], Us.Пароль, Us.[refresh salt], Us.[Provider]
FROM Пользователь Us INNER JOIN Языки ON Us.[ID языка] = Языки.[ID языка]
LEFT JOIN [Электронная почта] Em
ON Us.[Id Пользователя] = Em.[Id Пользователя]
LEFT JOIN [Номера телефонов] Num ON Us.[Id Пользователя] = Num.[Id Пользователя]
go
ALTER PROCEDURE [dbo].[AddUser]
@Provider varchar(30), @Password varchar(100), @FirstName varchar(50), @SecondName varchar(50) = null, 
@Patronymic varchar(50) = NULL, @Role varchar(45), @Language varchar(20), 
@Email varchar(100), @PhoneNumber varchar(20)=NULL, @Sex varchar(20) = null, @verified bit = 0
AS
DECLARE @IdLaguage uniqueidentifier, @UserId uniqueidentifier
SELECT @IdLaguage = Языки.[ID языка]
FROM Языки
WHERE Языки.Наименование = @Language
SELECT  @UserId=NEWID()
INSERT INTO Пользователь([Id Пользователя], Фамилия, Имя, Отчество, Роль, Пол, [ID языка], Пароль, [Provider], [Подтвержден])
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Password, @Provider, @verified)
IF @PhoneNumber IS NOT NULL
BEGIN
	INSERT INTO [Номера телефонов] VALUES (NEWID(), @PhoneNumber,@UserId)
END
INSERT INTO [Электронная почта] VALUES (NEWID(), @Email, @UserId)
go
--создаем ХП для изменения статуса регистрации
ALTER PROCEDURE [dbo].[EditRegisteredStatus]
@email varchar(100), @status bit
AS
UPDATE Пользователь
SET [Подтвержден] = @status
FROM [Пользователь] Us join [Электронная почта] Em ON Us.[Id Пользователя] = Em.[Id Пользователя]
WHERE Em.Наименование = @email and Us.[Подтвержден] != @status
RETURN @@ROWCOUNT