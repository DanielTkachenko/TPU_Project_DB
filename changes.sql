use TPU_Project
GO
--17.07.20-----------------------------------
--������������ ������ ������������ / ��������� ������� salt
--alter table ������������
--add [refresh salt] varchar(50) null
--go
----������� �� ��� ������� ������ � ����������� �������
--create procedure EditUserRefreshSalt
--@Salt varchar(50), @Login varchar(100)
--as
--update [������������]
--set [refresh salt] = @Salt
--where [�����] = @Login
--go
ALTER VIEW UserInfo AS
SELECT Us.[Id ������������], Us.�������, Us.���, Us.��������, Us.����, Us.���, �����.������������ '����', 
Em.������������ '����������� �����', Num.[����� ��������], Us.�����, Us.������, Us.[refresh salt]
FROM ������������ Us INNER JOIN ����� ON Us.[ID �����] = �����.[ID �����]
LEFT JOIN [����������� �����] Em
ON Us.[Id ������������] = Em.[Id ������������]
LEFT JOIN [������ ���������] Num ON Us.[Id ������������] = Num.[Id ������������]
go
