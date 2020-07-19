use TPU_Project
GO
--19.07.20-----------------------------------
--в таблицу электронная почта устанавливаем уникальность для имени электронной почты
alter table [Электронная почта]
add constraint EMAIL_UNIQUE unique([Наименование])
go
--переделываем таблицу Пользователь / добавляем колонку для указания типа регистрации и удаляем колонку Логин
alter table [Пользователь]
drop column [Логин]
go
alter table [Пользователь]
add [Provider] varchar(30) not null
go
ALTER VIEW UserInfo AS
SELECT Us.[Id Пользователя], Us.Фамилия, Us.Имя, Us.Отчество, Us.Роль, Us.Пол, Языки.Наименование 'Язык', 
Em.Наименование 'Электронная почта', Num.[Номер телефона], Us.Пароль, Us.[refresh salt], Us.[Provider]
FROM Пользователь Us INNER JOIN Языки ON Us.[ID языка] = Языки.[ID языка]
LEFT JOIN [Электронная почта] Em
ON Us.[Id Пользователя] = Em.[Id Пользователя]
LEFT JOIN [Номера телефонов] Num ON Us.[Id Пользователя] = Num.[Id Пользователя]
go
--убираем из процедуры AddUser параметр Логин и добавляем параметр Provider
ALTER PROCEDURE [AddUser]
@Provider varchar(30), @Password varchar(200), @FirstName varchar(45), @SecondName varchar(45) = null, 
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
INSERT INTO Пользователь([Id Пользователя], Фамилия, Имя, Отчество, Роль, Пол, [ID языка], Пароль, [Provider])
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Password, @Provider)
go
--редактируем ХП EditUserRefreshSalt / на вход подается email
ALTER procedure [EditUserRefreshSalt]
@Salt varchar(50), @email varchar(30)
as
update [Пользователь] 
set [refresh salt] = @Salt
from (select Us.[Id Пользователя], Us.[refresh salt] 
from [Пользователь] Us join [Электронная почта] Em on Us.[Id Пользователя]=Em.[Id Пользователя]
where [Наименование] = @email) as Selected
where Пользователь.[Id Пользователя] = Selected.[Id Пользователя]
go
--удалить ХП GetUserByLogin
drop procedure GetUserByLogin