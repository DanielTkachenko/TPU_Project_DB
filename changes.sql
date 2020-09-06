use TPU_Project
GO
--06.09.20-----------------------------------
alter table [��������]
add [ID ��������������] uniqueidentifier not null
go
alter table [��������� ���������]
add [��������� ���������] varchar(100) not null
go
create procedure [AddNotification]
@Email varchar(100), @Language varchar(20), @Status varchar(10), @Title varchar(100), @Message text
as
declare @textid uniqueidentifier, @adminid uniqueidentifier, @data datetime, @langid uniqueidentifier
set @textid = NEWID()
select @adminid = (select [Id ������������] from [����������� �����] where [������������] = @Email)
set @data = GETDATE()
select @langid = (select [ID �����] from [�����] where [������������] = @Language)
insert into [��������� ���������]([ID ������ ���������], [����� ���������], [��������� ���������])
values(@textid, @Message, @Title)
insert into [��������]([ID ���������], ����, [ID ����� ������ ��������], [������ ��������], [ID ������ ���������], [ID ��������������])
values(NEWID(), @data, @langid, @Status, @textid, @adminid)
