use TPU_Project
GO
--06.08.20-----------------------------------

----добавляем в таблицу Представление меню колонку для картинок
--alter table [Пункт меню]
--add [ID картинки] uniqueidentifier null
--go
--alter table [Пункт меню]
--add foreign key([ID картинки]) references [Медиа]([Id Медиа])
--go

----корректируем ХП для вставки
--ALTER PROCEDURE [dbo].[AddMenuItem]
--@Level int,@NameMenu varchar(45), @NameUpperMenu varchar(45), @Language varchar(45), 
--@Order int, @type varchar(20), @url varchar(100), @img uniqueidentifier = null
--AS
--DECLARE @MenuId uniqueidentifier
--DECLARE @UpperMenuId uniqueidentifier
--DECLARE @LanguageId uniqueidentifier
--SELECT @MenuId = NEWID()
--SELECT @LanguageId=Языки.[ID языка]
--FROM Языки
--WHERE Языки.Наименование = @Language
--IF @Level!=1
--BEGIN
--IF @NameUpperMenu is not NULL
--BEGIN
--SELECT @UpperMenuId = [Пункт меню].[Id пункта меню]
--FROM [Пункт меню] INNER JOIN [Представление меню]
--ON [Пункт меню].[Id пункта меню] = [Представление меню].[Id пункта меню]
--INNER JOIN Языки ON [Представление меню].[ID языка] = Языки.[ID языка]
--WHERE [Представление меню].Наименование = @NameUpperMenu AND Языки.Наименование=@Language
--IF @UpperMenuId is not NULL
--BEGIN
--INSERT INTO [Пункт меню]([Id пункта меню],Позиция,[FK_Id пункта меню], [Порядок отображения], [Тип меню], [URL], [ID картинки])
--VALUES(@MenuId,@Level,@UpperMenuId, @Order, @type, @url, @img)
--INSERT INTO [Представление меню]([Id пункта меню],Наименование,[ID языка])
--VALUES(@MenuId,@NameMenu,@LanguageId)
--END
--ELSE
--print 'No such upper menu item'
--END
--ELSE
--print 'Error no upper menu name'
--END
--IF @Level=1
--BEGIN
--INSERT INTO [Пункт меню]([Id пункта меню],Позиция, [Порядок отображения], [Тип меню], [URL], [ID картинки])
--VALUES(@MenuId,@Level, @Order,@type, @url, @img)
--INSERT INTO [Представление меню]([Id пункта меню],Наименование,[ID языка])
--VALUES(@MenuId,@NameMenu,@LanguageId)
--END;
--go
----редактируем представление меню
--ALTER VIEW Menu AS
--SELECT P1.[Id пункта меню] 'ID', Pr1.Наименование 'Подчинённый', P1.Позиция 'Уровень меню', Jz1.Наименование 'Язык подчинённого' ,P1.[Тип меню] 'Тип', 
--P1.[URL] 'Ссылка', P1.[Порядок отображения], SP1.[ID статьи] 'ID статьи', P1.[ID картинки] 'ID картинки', P2.[Id пункта меню] 'ID родителя', Pr2.Наименование 'Родитель'
--FROM ([Пункт меню] P1 
--INNER JOIN [Представление меню] Pr1 ON P1.[Id пункта меню] = Pr1.[Id пункта меню]
--LEFT JOIN [Статьи пункты меню] SP1 ON SP1.[ID пункта меню] = P1.[Id пункта меню]
--INNER JOIN Языки Jz1 ON Pr1.[ID языка] = Jz1.[ID языка])
--LEFT JOIN ([Пункт меню] P2 INNER JOIN [Представление меню] Pr2 ON P2.[Id пункта меню]=Pr2.[Id пункта меню])
--ON P1.[FK_Id пункта меню] = P2.[Id пункта меню]

--корректировка длин полей и обязательность заполнения полей связанных с пользователем
alter table [Пользователь]
alter column [Пароль] varchar(100) not null
go
alter table [Электронная почта]
alter column [Наименование] varchar(100) not null
go
alter table [Пользователь]
alter column [Имя] varchar(50) not null
go
alter table [Пользователь]
alter column [Фамилия] varchar(50) null
go
alter table [Пользователь]
alter column [Отчество] varchar(50) null
go
alter table [Пользователь]
alter column [Пол] varchar(20) null
go
alter table [Языки]
alter column [Наименование] varchar(20) not null
go
alter table [Номера телефонов]
alter column [Номер телефона] varchar(20) null
go
--корректируем поля в ХП AddUser
ALTER PROCEDURE [dbo].[AddUser]
@Provider varchar(30), @Password varchar(100), @FirstName varchar(50), @SecondName varchar(50) = null, 
@Patronymic varchar(50) = NULL, @Sex varchar(20) = null, @Role varchar(45), @Language varchar(20), @Email varchar(100), @PhoneNumber varchar(20)=NULL
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
