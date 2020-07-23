use TPU_Project
GO
--23.07.20-----------------------------------

--переделываем таблицу Пользователь / меняем тип колонки Пол
alter table [Пользователь]
alter column [Пол] varchar(10) not null
go
ALTER PROCEDURE [AddUser]
@Provider varchar(30), @Password varchar(200), @FirstName varchar(45), @SecondName varchar(45) = null, 
@Patronymic varchar(45) = NULL, @Sex varchar(10), @Role varchar(45), @Language varchar(45), @Email varchar(45), @PhoneNumber varchar(11)=NULL
AS
DECLARE @IdLaguage uniqueidentifier, @UserId uniqueidentifier
SELECT @IdLaguage = Языки.[ID языка]
FROM Языки
WHERE Языки.Наименование = @Language
SELECT  @UserId=NEWID()
IF @PhoneNumber IS NOT NULL
BEGIN
	INSERT INTO [Номера телефонов] VALUES (NEWID(), @PhoneNumber,@UserId)
END
INSERT INTO [Электронная почта] VALUES (NEWID(), @Email, @UserId)
INSERT INTO Пользователь([Id Пользователя], Фамилия, Имя, Отчество, Роль, Пол, [ID языка], Пароль, [Provider])
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Password, @Provider)
