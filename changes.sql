use TPU_Project
GO
--09.07.20-----------------------------------
--удаляем лишние таблицы
DROP TABLE [Медиа в статье]
DROP TABLE [Медиа в странице]
DROP TABLE [Сссылки в статьях]
DROP TABLE [Сссылки в страницах]
DROP TABLE [Сссылка]
DROP PROCEDURE AddMediaArticle
DROP PROCEDURE AddMediaPage
DROP PROCEDURE AddHref
DROP PROCEDURE AddHrefArticle
DROP PROCEDURE AddHrefPage
GO
--создаем новую таблицу
CREATE TABLE [Статьи пункты меню]
(
	[ID пункта меню] uniqueidentifier,
	[ID статьи] uniqueidentifier,
	PRIMARY KEY([ID пункта меню], [ID статьи]),
	FOREIGN KEY([ID пункта меню]) REFERENCES [Пункт меню]([Id пункта меню]),
	FOREIGN KEY([ID статьи]) REFERENCES [Статья]([Id статьи])
)
GO
--корректируем таблицу медиа: убираем колонку Тип, убираем колонку Тема, тип колонки Данные - бинарный
ALTER TABLE [Медиа]
ALTER COLUMN [Данные] BINARY NOT NULL
GO
ALTER TABLE [Медиа]
DROP COLUMN [Тип]
GO
ALTER TABLE [Медиа]
DROP COLUMN [Тема]
GO
--Изменяем ХП добавления Медиа в соответствии с изменениями
ALTER PROCEDURE [AddMedia]
@Data binary
AS
DECLARE @Date datetime
SELECT @Date = GETDATE()
INSERT INTO Медиа(Данные, [Время создания])
VALUES(@Data,@Date);
GO
--Корректируем ХП GetArticlesBrief
ALTER PROCEDURE [GetArticlesBrief]
@str_id uniqueidentifier
AS
SELECT [Id статьи] FROM [Статьи в страницах]
WHERE [Id страницы]=@str_id
GO
--Корректируем представление Menu
ALTER VIEW Menu AS
SELECT P1.[Id пункта меню] 'ID', Pr1.Наименование 'Подчинённый', P1.Позиция 'Уровень меню', P1.[Тип меню] 'Тип', 
P1.[URL] 'Ссылка', P1.[Порядок отображения], SP1.[ID статьи] 'ID статьи',P2.[Id пункта меню] 'ID родителя', Pr2.Наименование 'Родитель'
FROM ([Пункт меню] P1 
INNER JOIN [Представление меню] Pr1 ON P1.[Id пункта меню] = Pr1.[Id пункта меню]
INNER JOIN [Статьи пункты меню] SP1 ON SP1.[ID пункта меню] = P1.[Id пункта меню])
LEFT JOIN ([Пункт меню] P2 INNER JOIN [Представление меню] Pr2 ON P2.[Id пункта меню]=Pr2.[Id пункта меню])
ON P1.[FK_Id пункта меню] = P2.[Id пункта меню]
GO
