use TPU_Project
GO
--17.07.20-----------------------------------
--������������ ������ ������������ / ��������� ������� salt
alter table ������������
add [refresh salt] varchar(50) null
go
--������� �� ��� ������� ������ � ����������� �������
create procedure EditUserRefreshSalt
@Salt varchar(50), @Login varchar(100)
as
update [������������]
set [refresh salt] = @Salt
where [�����] = @Login