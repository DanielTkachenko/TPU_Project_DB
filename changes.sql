use TPU_Project
GO
--05.09.20-----------------------------------

--fix procedure EditUser
ALTER PROCEDURE [dbo].[EditUser]
@email varchar(100), @psw varchar(100), @firstName varchar(50), @lang varchar(20), @secondName varchar(50) = null, @patronymic varchar(50) = null,
@sex varchar(20) = null, @phoneNum varchar(20) = null
AS
DECLARE @langid uniqueidentifier, @userid uniqueidentifier
SET @langid = (SELECT [ID �����] FROM [�����] WHERE [������������] = @lang)
SET @userid = (SELECT Us.[Id ������������] 
FROM [������������] Us JOIN [����������� �����] Em ON Us.[Id ������������] = Em.[Id ������������] 
WHERE Em.������������ = @email)
UPDATE [������������]
SET ��� = @firstName, ������� = @secondName, �������� = @patronymic, ��� = @sex, [ID �����] = @langid
WHERE [Id ������������] = @userid;
IF @psw IS NOT NULL
BEGIN
	UPDATE [������������]
	SET [������] = @psw
	WHERE [Id ������������] = @userid
END
IF @phoneNum != NULL
BEGIN
	IF EXISTS (SELECT * FROM [������ ���������] WHERE [Id ������������] = @userid)
	BEGIN
		UPDATE [������ ���������]
		SET [����� ��������] = @phoneNum
		WHERE [Id ������������] = @userid
	END
	ELSE
	BEGIN
		INSERT INTO [������ ���������]([Id ��������], [Id ������������], [����� ��������])
		VALUES(NEWID(), @userid, @phoneNum)
	END
END
GO
--ADD UNIQUE TO [������ ���������]
ALTER TABLE [������ ���������]
ADD UNIQUE([����� ��������])
