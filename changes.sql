use TPU_Project
GO
--06.09.20-----------------------------------
alter table [Рассылки]
add [ID администратора] uniqueidentifier not null
go
alter table [Текстовки сообщений]
add [Заголовок сообщения] varchar(100) not null
go
create procedure [AddNotification]
@Email varchar(100), @Language varchar(20), @Status varchar(10), @Title varchar(100), @Message text
as
declare @textid uniqueidentifier, @adminid uniqueidentifier, @data datetime, @langid uniqueidentifier
set @textid = NEWID()
select @adminid = (select [Id Пользователя] from [Электронная почта] where [Наименование] = @Email)
set @data = GETDATE()
select @langid = (select [ID языка] from [Языки] where [Наименование] = @Language)
insert into [Текстовки сообщений]([ID текста сообщения], [Текст сообщения], [Заголовок сообщения])
values(@textid, @Message, @Title)
insert into [Рассылки]([ID сообщения], Дата, [ID языка группы рассылки], [Статус доставки], [ID текста сообщения], [ID администратора])
values(NEWID(), @data, @langid, @Status, @textid, @adminid)
