USE TPU_Project;
GO

CREATE PROCEDURE AddUser
@FirstName varchar(45), @SecondName varchar(45), @LastName varchar(45), @Sex bit, @Role varchar(45), @Language varchar(45)
AS
DECLARE @IdLaguage uniqueidentifier
SELECT @IdLaguage = Языки.[ID языка]
FROM Языки
WHERE Языки.Наименование = @Language
INSERT INTO Пользователь(Фамилия, Имя, Отчество, Роль, Пол, Регистрация, [ID языка])
VALUES(@SecondName,@FirstName,@LastName,@Role,@Sex,0,@IdLaguage);

go
--Добавление телефона
CREATE PROCEDURE AddPhone
@FirstName varchar(45), @SecondName varchar(45), @Phonenumber varchar(11)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = Пользователь.[Id Пользователя]
FROM Пользователь
WHERE Пользователь.Имя = @FirstName AND Пользователь.Фамилия = @SecondName
INSERT INTO [Номера телефонов]([Номер телефона], [Id Пользователя])
VALUES(@Phonenumber,@UserId);

--Email
--Добавление электронной почты
go
CREATE PROCEDURE AddEmail
@FirstName varchar(45), @SecondName varchar(45), @Email varchar(11)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = Пользователь.[Id Пользователя]
FROM Пользователь
WHERE Пользователь.Имя = @FirstName AND Пользователь.Фамилия = @SecondName
INSERT INTO [Электорнная почта](Наименование, [Id Пользователя])
VALUES(@Email,@UserId);

--Добавление пункта меню
go
CREATE PROCEDURE AddMenuItem
@Level int,@NameMenu varchar(45), @NameUpperMenu varchar(45), @Language varchar(45)
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
INSERT INTO [Пункт меню]([Id пункта меню],Позиция,[FK_Id пункта меню])
VALUES(@MenuId,@Level,@UpperMenuId)
INSERT INTO [Представление меню]([Id пункта меню],Наименование,[ID языка])
VALUES(@MenuId,@NameMenu,@LanguageId)
END
ELSE
print 'No such upper menu item'
END
ELSE
print 'Error no upper menu name'
END
IF @Level=1
BEGIN
INSERT INTO [Пункт меню]([Id пункта меню],Позиция)
VALUES(@MenuId,@Level)
INSERT INTO [Представление меню]([Id пункта меню],Наименование,[ID языка])
VALUES(@MenuId,@NameMenu,@LanguageId)
END;


--Добавление статьи
go
CREATE PROCEDURE AddArticle
@Name varchar(30), @Text text,@Topic varchar(30), @DateTime datetime, @Language varchar(30)
AS
DECLARE @LanguageId uniqueidentifier
SELECT @LanguageId = Языки.[ID языка]
FROM Языки
WHERE Языки.Наименование = @Language
IF @DateTime is NULL
SELECT @DateTime = GETDATE()
INSERT INTO Статья(Название, Текст, [Время создания],[ID языка],Тематика)
VALUES(@Name,@Text,@DateTime,@LanguageId,@Topic);

--Добавление странички
go
CREATE PROCEDURE AddPage
@Name varchar(30), @Language varchar(30)
AS
DECLARE @LanguageId uniqueidentifier
SELECT @LanguageId = Языки.[ID языка]
FROM Языки
WHERE Языки.Наименование = @Language
INSERT INTO Страница(Название,[ID языка])
VALUES(@Name,@LanguageId);


--Добавление промежуточной инфы
go
CREATE PROCEDURE AddPageMenu
@NamePage varchar(30),@NameMenu varchar(30)
AS
DECLARE @IdPage uniqueidentifier
DECLARE @IdMenu uniqueidentifier
SELECT @IdMenu = [Представление меню].[Id пункта меню]
FROM [Представление меню]
WHERE [Представление меню].Наименование = @NameMenu
SELECT @IdPage = Страница.[Id страницы]
FROM Страница
WHERE Страница.Название = @NamePage
INSERT INTO [Страницы пункты меню]([Id пункта меню],[Id страницы])
VALUES(@IdMenu,@IdPage);

go
CREATE PROCEDURE AddArticlesInPages
@NamePage varchar(45), @NameArticle varchar(45)
AS
DECLARE @IdPage uniqueidentifier
DECLARE @IdArticle uniqueidentifier
SELECT @IdPage = Страница.[Id страницы]
FROM Страница
WHERE Страница.Название = @NamePage
SELECT @IdArticle = Статья.[Id статьи]
FROM Статья
WHERE Статья.Название = @NameArticle
INSERT INTO [Статьи в страницах]([Id статьи],[Id страницы])
VALUES(@IdArticle,@IdPage);

go
CREATE PROCEDURE AddMediaPage
@MediaId uniqueidentifier, @NamePage varchar(30)
AS
DECLARE @IdPage uniqueidentifier
SELECT @IdPage = Страница.[Id страницы]
FROM Страница
WHERE Страница.Название = @NamePage
INSERT INTO [Медиа в странице]([Id Медиа], [Id страницы])
VALUES(@MediaId,@IdPage);

go
CREATE PROCEDURE AddMediaArticle
@MediaId uniqueidentifier, @NameArticle varchar(30)
AS
DECLARE @IdArticle uniqueidentifier
SELECT @IdArticle = Статья.[Id статьи]
FROM Статья
WHERE Статья.Название = @NameArticle
INSERT INTO [Медиа в статье]([Id Медиа], [Id статьи])
VALUES(@MediaId,@IdArticle);

go
CREATE PROCEDURE AddHrefPage
@HrefText varchar(30), @NamePage varchar(30)
AS
DECLARE @IdPage uniqueidentifier
DECLARE @IdHref uniqueidentifier
SELECT @IdHref = Ссылка.[Id ссылки]
FROM Ссылка
WHERE Ссылка.Текст = @HrefText
SELECT @IdPage = Страница.[Id страницы]
FROM Страница
WHERE Страница.Название = @NamePage
INSERT INTO [Ссылки в страницах]([Id ссылки], [Id страницы])
VALUES(@IdHref,@IdPage);

go
CREATE PROCEDURE AddHrefArticle
@HrefText varchar(30), @NameArticle varchar(30)
AS
DECLARE @IdArticle uniqueidentifier
DECLARE @IdHref uniqueidentifier
SELECT @IdHref = Ссылка.[Id ссылки]
FROM Ссылка
WHERE Ссылка.Текст = @HrefText
SELECT @IdArticle = Статья.[Id статьи]
FROM Статья
WHERE Статья.Название = @NameArticle
INSERT INTO [Ссылки в статьях]([Id ссылки], [Id статьи])
VALUES(@IdHref,@IdArticle);


--Добавление медиа
go
CREATE PROCEDURE AddMedia
@MediaType varchar(30), @Data image, @Topic varchar(30), @Date datetime
AS
INSERT INTO Медиа(Тип, Данные, Тема, [Время создания])
VALUES(@MediaType,@Data,@Topic,@Date);


--Добавление ссылок
go
CREATE PROCEDURE AddHref
@Adress varchar(30), @Text varchar(30)
AS
INSERT INTO Ссылка([Адрес ссылки], Текст)
VALUES(@Adress,@Text)
