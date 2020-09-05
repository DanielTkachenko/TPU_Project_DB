use TPU_Project
GO
--05.09.20-----------------------------------

--fix procedure EditUser
ALTER PROCEDURE [dbo].[EditUser]
@email varchar(100), @psw varchar(100), @firstName varchar(50), @lang varchar(20), @secondName varchar(50) = null, @patronymic varchar(50) = null,
@sex varchar(20) = null, @phoneNum varchar(20) = null
AS
DECLARE @langid uniqueidentifier, @userid uniqueidentifier
SET @langid = (SELECT [ID языка] FROM [Языки] WHERE [Наименование] = @lang)
SET @userid = (SELECT Us.[Id Пользователя] 
FROM [Пользователь] Us JOIN [Электронная почта] Em ON Us.[Id Пользователя] = Em.[Id Пользователя] 
WHERE Em.Наименование = @email)
UPDATE [Пользователь]
SET Имя = @firstName, Фамилия = @secondName, Отчество = @patronymic, Пол = @sex, [ID языка] = @langid
WHERE [Id Пользователя] = @userid;
IF @psw IS NOT NULL
BEGIN
	UPDATE [Пользователь]
	SET [Пароль] = @psw
	WHERE [Id Пользователя] = @userid
END
IF @phoneNum != NULL
BEGIN
	IF EXISTS (SELECT * FROM [Номера телефонов] WHERE [Id Пользователя] = @userid)
	BEGIN
		UPDATE [Номера телефонов]
		SET [Номер телефона] = @phoneNum
		WHERE [Id Пользователя] = @userid
	END
	ELSE
	BEGIN
		INSERT INTO [Номера телефонов]([Id Телефона], [Id Пользователя], [Номер телефона])
		VALUES(NEWID(), @userid, @phoneNum)
	END
END
GO
--ADD UNIQUE TO [НОМЕРА ТЕЛЕФОНОВ]
ALTER TABLE [НОМЕРА ТЕЛЕФОНОВ]
ADD UNIQUE([Номер телефона])
