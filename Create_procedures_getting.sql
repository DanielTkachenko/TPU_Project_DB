use TPU_Project;
go
----Получение пунктов меню на определенном языке
--CREATE PROCEDURE GetMenuByLanguage @Language varchar(45)
--AS
--SELECT * FROM [Menu]
--WHERE [Язык подчинённого] = @Language;

----Получение информации о пользователях определенного языка
--go
--create procedure GetUserByLanguage
--@Language varchar(45)
--as
--select * from UserInfo where [Язык] = @Language;

----Получение зарегестрированных пользователей
--go
--create procedure GetRegistered
--@Reg bit
--as
--select * from UserInfo where [Регистрация] = @Reg;

----Получение подчиненных пунктов меню определенного языка
--go
--create procedure GetNextLevelMenu
--@lang varchar(45), @parentMenu varchar(45)
--as
--select [Подчинённый], [Уровень меню] from [Menu] where [Родитель] = @parentMenu and [Язык подчинённого] = @lang;
--go
--Получение кратких версий статей
create procedure GetArticlesBrief
@Offset int, @Count int, @Lang varchar(45)
as
select S1.[Id статьи], S1.Название, S1.[Время создания], S1.Тематика, S1.[Краткая версия статьи]
from [Статья] S1 join [Языки] J1 on S1.[ID языка]=J1.[ID языка]
where J1.Наименование = @Lang
order by S1.[Время создания] desc
	offset @Offset rows
	fetch next @Count rows only;