use TPU_Project
GO
--17.07.20-----------------------------------
--переделываем лабицу Пользователь / добавляем колонку salt
--alter table Пользователь
--add [refresh salt] varchar(50) null
--go
----создаем ХП для вставки данных в добавленный столбец
--create procedure EditUserRefreshSalt
--@Salt varchar(50), @Login varchar(100)
--as
--update [Пользователь]
--set [refresh salt] = @Salt
--where [Логин] = @Login
--go
ALTER VIEW UserInfo AS
SELECT Us.[Id Пользователя], Us.Фамилия, Us.Имя, Us.Отчество, Us.Роль, Us.Пол, Языки.Наименование 'Язык', 
Em.Наименование 'Электронная почта', Num.[Номер телефона], Us.Логин, Us.Пароль, Us.[refresh salt]
FROM Пользователь Us INNER JOIN Языки ON Us.[ID языка] = Языки.[ID языка]
LEFT JOIN [Электронная почта] Em
ON Us.[Id Пользователя] = Em.[Id Пользователя]
LEFT JOIN [Номера телефонов] Num ON Us.[Id Пользователя] = Num.[Id Пользователя]
go
