use TPU_Project
GO
--06.07.20-----------------------------------
--изменение таблицы Статья
alter table [Статья]
add [Краткая версия статьи] text null
go
--Добавим данные в таблицу
exec AddArticle 'hello world', 'new article', 'students', 'Русский'
go
exec AddArticle 'hello world', 'new article', 'students', 'Английский'
go
exec AddArticle 'расписание', 'новое расписание для студентов', 'расписание', 'Русский'
go
exec AddArticle 'расписание', 'новое расписание для студентов', 'расписание', 'Английский'
go
--В ХП Добавления статей добавляем параметр для краткой версии статей
ALTER PROCEDURE [AddArticle]
@Name varchar(30), @Text text,@Topic varchar(30), @Language varchar(30), @Brief text
AS
DECLARE @LanguageId uniqueidentifier
DECLARE @DateTime datetime
SELECT @DateTime = GETDATE()
SELECT @LanguageId = Языки.[ID языка]
FROM Языки
WHERE Языки.Наименование = @Language
IF @DateTime is NULL
SELECT @DateTime = GETDATE()
INSERT INTO Статья(Название, Текст, [Время создания],[ID языка],Тематика, [Краткая версия статьи])
VALUES(@Name,@Text,@DateTime,@LanguageId,@Topic, @Brief);
