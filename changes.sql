use TPU_Project
GO
--15.07.20-----------------------------------
--переделываем лабицу Пользователь
alter table Пользователь
add [Логин] varchar(100) not null
go
alter table Пользователь
add [Пароль] varchar(200) not null
go
alter table Пользователь
drop column [Регистрация]
go
--изменение в view UserInfo
ALTER VIEW UserInfo AS
SELECT Us.[Id Пользователя], Us.Фамилия, Us.Имя, Us.Отчество, Us.Роль, Us.Пол, Языки.Наименование 'Язык', 
Em.Наименование 'Электронная почта', Num.[Номер телефона], Us.Логин, Us.Пароль
FROM Пользователь Us INNER JOIN Языки ON Us.[ID языка] = Языки.[ID языка]
LEFT JOIN [Электронная почта] Em
ON Us.[Id Пользователя] = Em.[Id Пользователя]
LEFT JOIN [Номера телефонов] Num ON Us.[Id Пользователя] = Num.[Id Пользователя]
go
--изменение процедуры AddUser
ALTER PROCEDURE [AddUser]
@Login varchar(100), @Password varchar(200), @FirstName varchar(45), @SecondName varchar(45), 
@Patronymic varchar(45) = NULL, @Sex bit, @Role varchar(45), @Language varchar(45), @Email varchar(45), @PhoneNumber varchar(11)=NULL
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
INSERT INTO Пользователь([Id Пользователя], Фамилия, Имя, Отчество, Роль, Пол, [ID языка], Логин, Пароль)
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Login, @Password)

