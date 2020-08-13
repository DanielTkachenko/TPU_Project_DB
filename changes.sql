use TPU_Project
GO
--13.08.20-----------------------------------

--create procedure EditUser
CREATE PROCEDURE EditUser
@email varchar(100), @psw varchar(100), @firstName varchar(50), @lang varchar(20), @secondName varchar(50) = null, @patronymic varchar(50) = null,
@sex varchar(20) = null, @phoneNum varchar(20) = null
AS
DECLARE @langid uniqueidentifier, @userid uniqueidentifier
--находим id языка по наименованию
SET @langid = (SELECT [ID языка] FROM [Языки] WHERE [Наименование] = @lang)
--находим id пользователя по email
SET @userid = (SELECT Us.[Id Пользователя] 
FROM [Пользователь] Us JOIN [Электронная почта] Em ON Us.[Id Пользователя] = Em.[Id Пользователя] 
WHERE Em.Наименование = @email)
UPDATE [Пользователь]
SET Пароль = @psw, Имя = @firstName, Фамилия = @secondName, Отчество = @patronymic, Пол = @sex, [ID языка] = @langid
WHERE [Id Пользователя] = @userid;
UPDATE [Номера телефонов]
SET [Номер телефона] = @phoneNum
WHERE [Id Пользователя] = @userid