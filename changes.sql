use TPU_Project
GO
--06.08.20-----------------------------------

--добавляем в таблицу Представление меню колонку для картинок
alter table [Пункт меню]
add [ID картинки] uniqueidentifier null
go
alter table [Пункт меню]
add foreign key([ID картинки]) references [Медиа]([Id Медиа])
go

--корректируем ХП для вставки
ALTER PROCEDURE [dbo].[AddMenuItem]
@Level int,@NameMenu varchar(45), @NameUpperMenu varchar(45), @Language varchar(45), 
@Order int, @type varchar(20), @url varchar(100), @img uniqueidentifier = null
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
END;
go
--редактируем представление меню
ALTER VIEW Menu AS
SELECT P1.[Id пункта меню] 'ID', Pr1.Наименование 'Подчинённый', P1.Позиция 'Уровень меню', Jz1.Наименование 'Язык подчинённого' ,P1.[Тип меню] 'Тип', 
P1.[URL] 'Ссылка', P1.[Порядок отображения], SP1.[ID статьи] 'ID статьи', P1.[ID картинки] 'ID картинки', P2.[Id пункта меню] 'ID родителя', Pr2.Наименование 'Родитель'
FROM ([Пункт меню] P1 
INNER JOIN [Представление меню] Pr1 ON P1.[Id пункта меню] = Pr1.[Id пункта меню]
LEFT JOIN [Статьи пункты меню] SP1 ON SP1.[ID пункта меню] = P1.[Id пункта меню]
INNER JOIN Языки Jz1 ON Pr1.[ID языка] = Jz1.[ID языка])
LEFT JOIN ([Пункт меню] P2 INNER JOIN [Представление меню] Pr2 ON P2.[Id пункта меню]=Pr2.[Id пункта меню])
ON P1.[FK_Id пункта меню] = P2.[Id пункта меню]
