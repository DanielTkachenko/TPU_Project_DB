use TPU_Project
GO

--16.09.20
CREATE TABLE [Документы]
([ID документа] uniqueidentifier not null,
[Содержимое документа] varbinary,
[Дата загрузки документа] datetime,
[Название документа] nvarchar(100) not null,
[Название файла] nvarchar(100) not null,
PRIMARY KEY([ID документа]))
GO

CREATE TABLE [Документы пользователя]
([ID пользователя] uniqueidentifier not null,
[ID документа] uniqueidentifier not null,
PRIMARY KEY([ID пользователя], [ID документа]),
FOREIGN KEY([ID пользователя]) REFERENCES [Пользователь]([Id Пользователя]),
FOREIGN KEY([ID документа]) REFERENCES [Документы]([ID документа]))
GO

CREATE PROCEDURE GetDocumentsWithoutContent
@email varchar(100)
AS
DECLARE @userid uniqueidentifier
SELECT @userid = (SELECT [Id Пользователя] FROM [Электронная почта] WHERE [Наименование] = @email)
SELECT DOC.[ID документа], [Дата загрузки документа], [Название документа], [Название файла]
FROM [Документы пользователя] UD JOIN [Документы] DOC ON UD.[ID документа] = DOC.[ID документа]
WHERE [ID пользователя] = @userid
ORDER BY [Дата загрузки документа] DESC
go

CREATE TABLE [Служебные данные]
([Параметр] nvarchar(500),
[Значение] nvarchar(500))
go

CREATE TABLE [Идентификатор учебной группы]
([ID группы] uniqueidentifier not null,
[Номер группы] varchar(10),
[Идентификатор группы] varchar(100),
PRIMARY KEY([ID группы]))
go

ALTER PROCEDURE GetUtilParameter
@key nvarchar(500),
@parameter nvarchar(500) OUTPUT
AS
SELECT @parameter = [Значение] FROM [Служебные данные]
WHERE [Параметр] = @key
go

--корректируем ХП и таблицы связанные с пользователем / добавляем номер группы


ALTER TABLE [Пользователь]
ADD [ID группы] uniqueidentifier
go
ALTER TABLE [Пользователь]
ADD FOREIGN KEY([ID группы]) REFERENCES [Идентификатор учебной группы]([ID группы])
go

ALTER PROCEDURE [dbo].[AddUser]
@Provider varchar(30), @Password varchar(100), @FirstName varchar(50), @SecondName varchar(50) = null, 
@Patronymic varchar(50) = NULL, @Role varchar(45), @Language varchar(20), 
@Email varchar(100), @PhoneNumber varchar(20)=NULL, @Sex varchar(20) = null, @verified bit = 0, @idGroup uniqueidentifier = null
AS
DECLARE @IdLaguage uniqueidentifier, @UserId uniqueidentifier
SELECT @IdLaguage = Языки.[ID языка]
FROM Языки
WHERE Языки.Наименование = @Language
SELECT  @UserId=NEWID()
INSERT INTO Пользователь([Id Пользователя], Фамилия, Имя, Отчество, Роль, Пол, [ID языка], Пароль, [Provider], [Подтвержден], [ID группы])
VALUES(@UserId, @SecondName,@FirstName,@Patronymic,@Role,@Sex,@IdLaguage, @Password, @Provider, @verified, @idGroup)
IF @PhoneNumber IS NOT NULL
BEGIN
	INSERT INTO [Номера телефонов] VALUES (NEWID(), @PhoneNumber,@UserId)
END
INSERT INTO [Электронная почта] VALUES (NEWID(), @Email, @UserId)
go

ALTER PROCEDURE [dbo].[EditUser]
@email varchar(100), @psw varchar(100), @firstName varchar(50), @lang varchar(20), @secondName varchar(50) = null, @patronymic varchar(50) = null,
@sex varchar(20) = null, @phoneNum varchar(20) = null, @idGroup uniqueidentifier = null
AS
DECLARE @langid uniqueidentifier, @userid uniqueidentifier
SET @langid = (SELECT [ID языка] FROM [Языки] WHERE [Наименование] = @lang)
SET @userid = (SELECT Us.[Id Пользователя] 
FROM [Пользователь] Us JOIN [Электронная почта] Em ON Us.[Id Пользователя] = Em.[Id Пользователя] 
WHERE Em.Наименование = @email)
UPDATE [Пользователь]
SET Имя = @firstName, Фамилия = @secondName, Отчество = @patronymic, Пол = @sex, [ID языка] = @langid, [ID группы] = @idGroup
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

ALTER VIEW UserInfo AS
SELECT Us.[Id Пользователя], Us.Фамилия, Us.Имя, Us.Отчество, Us.Роль, Us.Пол, Языки.Наименование 'Язык', 
Em.Наименование 'Электронная почта', Us.[Подтвержден], Num.[Номер телефона], Us.Пароль, Us.[refresh salt], Us.[Provider], Us.[ID группы]
FROM Пользователь Us INNER JOIN Языки ON Us.[ID языка] = Языки.[ID языка]
LEFT JOIN [Электронная почта] Em
ON Us.[Id Пользователя] = Em.[Id Пользователя]
LEFT JOIN [Номера телефонов] Num ON Us.[Id Пользователя] = Num.[Id Пользователя]
go

----------
CREATE PROCEDURE GetUserGroupID
@email varchar(100), @internalGroupID varchar(100) OUTPUT
AS
DECLARE @groupid uniqueidentifier
SET @groupid = (SELECT Us.[ID группы] FROM [Электронная почта] Em JOIN [Пользователь]Us ON Em.[Id пользователя] = Us.[Id Пользователя]  
WHERE Em.[Наименование] = @email)
SELECT @internalGroupID = (SELECT [Идентификатор группы] FROM [Идентификатор учебной группы] WHERE [ID группы] = @groupid)
GO

CREATE PROCEDURE GetDocumentsWithContent
@email varchar(100)
AS
DECLARE @userid uniqueidentifier
SELECT @userid = (SELECT [Id Пользователя] FROM [Электронная почта] WHERE [Наименование] = @email)
SELECT *
FROM [Документы пользователя] UD JOIN [Документы] DOC ON UD.[ID документа] = DOC.[ID документа]
WHERE [ID пользователя] = @userid
ORDER BY [Дата загрузки документа] DESC