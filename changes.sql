use TPU_Project
GO
--13.08.20-----------------------------------

--create procedure EditUser
CREATE PROCEDURE EditUser
@email varchar(100), @psw varchar(100), @firstName varchar(50), @lang varchar(20), @secondName varchar(50) = null, @patronymic varchar(50) = null,
@sex varchar(20) = null, @phoneNum varchar(20) = null
AS
DECLARE @langid uniqueidentifier, @userid uniqueidentifier
--������� id ����� �� ������������
SET @langid = (SELECT [ID �����] FROM [�����] WHERE [������������] = @lang)
--������� id ������������ �� email
SET @userid = (SELECT Us.[Id ������������] 
FROM [������������] Us JOIN [����������� �����] Em ON Us.[Id ������������] = Em.[Id ������������] 
WHERE Em.������������ = @email)
UPDATE [������������]
SET ������ = @psw, ��� = @firstName, ������� = @secondName, �������� = @patronymic, ��� = @sex, [ID �����] = @langid
WHERE [Id ������������] = @userid;
UPDATE [������ ���������]
SET [����� ��������] = @phoneNum
WHERE [Id ������������] = @userid