use TPU_Project;
go
--��������� ������� ���� �� ������������ �����
CREATE PROCEDURE GetMenuByLanguage @Language varchar(45)
AS
SELECT * FROM [Menu]
WHERE [���� �����������] = @Language;

--��������� ���������� � ������������� ������������� �����
go
create procedure GetUserByLanguage
@Language varchar(45)
as
select * from UserInfo where [����] = @Language;

--��������� ������������������ �������������
go
create procedure GetRegistered
@Reg bit
as
select * from UserInfo where [�����������] = @Reg;

--��������� ����������� ������� ���� ������������� �����
go
create procedure GetNextLevelMenu
@lang varchar(45), @parentMenu varchar(45)
as
select [����������], [������� ����] from [Menu] where [��������] = @parentMenu and [���� �����������] = @lang;
