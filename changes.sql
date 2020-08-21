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
GO
--21.08.20
--edit procedure AddMenuItem / added parameter @articleId
ALTER PROCEDURE [dbo].[AddMenuItem]
@Level int,@NameMenu varchar(45), @NameUpperMenu varchar(45), @Language varchar(45), 
@Order int, @type varchar(20), @url varchar(100), @img uniqueidentifier = NULL, @articleId uniqueidentifier = NULL
AS
DECLARE @MenuId uniqueidentifier
DECLARE @UpperMenuId uniqueidentifier
DECLARE @LanguageId uniqueidentifier
SELECT @MenuId = NEWID()
SELECT @LanguageId=Языки.[ID языка]
FROM Языки
WHERE Языки.Наименование = @Language
IF @Level!=1
BEGIN
IF @NameUpperMenu is not NULL
BEGIN
SELECT @UpperMenuId = [Пункт меню].[Id пункта меню]
FROM [Пункт меню] INNER JOIN [Представление меню]
ON [Пункт меню].[Id пункта меню] = [Представление меню].[Id пункта меню]
INNER JOIN Языки ON [Представление меню].[ID языка] = Языки.[ID языка]
WHERE [Представление меню].Наименование = @NameUpperMenu AND Языки.Наименование=@Language
IF @UpperMenuId is not NULL
BEGIN
INSERT INTO [Пункт меню]([Id пункта меню],Позиция,[FK_Id пункта меню], [Порядок отображения], [Тип меню], [URL], [ID картинки])
VALUES(@MenuId,@Level,@UpperMenuId, @Order, @type, @url, @img)
INSERT INTO [Представление меню]([Id пункта меню],Наименование,[ID языка])
VALUES(@MenuId,@NameMenu,@LanguageId)
IF @articleId != NULL
BEGIN
INSERT INTO [Статьи пункты меню]([ID пункта меню], [ID статьи])
VALUES(@MenuId, @articleId)
END
END
ELSE
print 'No such upper menu item'
END
ELSE
print 'Error no upper menu name'
END
IF @Level=1
BEGIN
INSERT INTO [Пункт меню]([Id пункта меню],Позиция, [Порядок отображения], [Тип меню], [URL], [ID картинки])
VALUES(@MenuId,@Level, @Order,@type, @url, @img)
INSERT INTO [Представление меню]([Id пункта меню],Наименование,[ID языка])
VALUES(@MenuId,@NameMenu,@LanguageId)
IF @articleId != NULL
BEGIN
INSERT INTO [Статьи пункты меню]([ID пункта меню], [ID статьи])
VALUES(@MenuId, @articleId)
END
END;