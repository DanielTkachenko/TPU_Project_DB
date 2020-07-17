use TPU_Project
GO
--17.07.20-----------------------------------
--переделываем лабицу Пользователь / добавляем колонку salt
alter table Пользователь
add [refresh salt] varchar(50) null
go
--создаем ХП для вставки данных в добавленный столбец
create procedure EditUserRefreshSalt
@Salt varchar(50), @Login varchar(100)
as
update [Пользователь]
set [refresh salt] = @Salt
where [Логин] = @Login