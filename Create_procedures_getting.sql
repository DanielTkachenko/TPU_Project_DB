use TPU_Project;
go
----��������� ������� ���� �� ������������ �����
--CREATE PROCEDURE GetMenuByLanguage @Language varchar(45)
--AS
--SELECT * FROM [Menu]
--WHERE [���� �����������] = @Language;

----��������� ���������� � ������������� ������������� �����
--go
--create procedure GetUserByLanguage
--@Language varchar(45)
--as
--select * from UserInfo where [����] = @Language;

----��������� ������������������ �������������
--go
--create procedure GetRegistered
--@Reg bit
--as
--select * from UserInfo where [�����������] = @Reg;

----��������� ����������� ������� ���� ������������� �����
--go
--create procedure GetNextLevelMenu
--@lang varchar(45), @parentMenu varchar(45)
--as
--select [����������], [������� ����] from [Menu] where [��������] = @parentMenu and [���� �����������] = @lang;
--go
--��������� ������� ������ ������
create procedure GetArticlesBrief
@Offset int, @Count int, @Lang varchar(45)
as
select S1.[Id ������], S1.��������, S1.[����� ��������], S1.��������, S1.[������� ������ ������]
from [������] S1 join [�����] J1 on S1.[ID �����]=J1.[ID �����]
where J1.������������ = @Lang
order by S1.[����� ��������] desc
	offset @Offset rows
	fetch next @Count rows only;