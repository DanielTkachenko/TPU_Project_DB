use TPU_Project
GO
--06.07.20-----------------------------------
--��������� ������� ������
alter table [������]
add [������� ������ ������] text null
go
--������� ������ � �������
exec AddArticle 'hello world', 'new article', 'students', '�������'
go
exec AddArticle 'hello world', 'new article', 'students', '����������'
go
exec AddArticle '����������', '����� ���������� ��� ���������', '����������', '�������'
go
exec AddArticle '����������', '����� ���������� ��� ���������', '����������', '����������'
go
--� �� ���������� ������ ��������� �������� ��� ������� ������ ������
ALTER PROCEDURE [AddArticle]
@Name varchar(30), @Text text,@Topic varchar(30), @Language varchar(30), @Brief text
AS
DECLARE @LanguageId uniqueidentifier
DECLARE @DateTime datetime
SELECT @DateTime = GETDATE()
SELECT @LanguageId = �����.[ID �����]
FROM �����
WHERE �����.������������ = @Language
IF @DateTime is NULL
SELECT @DateTime = GETDATE()
INSERT INTO ������(��������, �����, [����� ��������],[ID �����],��������, [������� ������ ������])
VALUES(@Name,@Text,@DateTime,@LanguageId,@Topic, @Brief);
