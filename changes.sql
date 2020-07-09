use TPU_Project
GO
--09.07.20-----------------------------------
--������� ������ �������
DROP TABLE [����� � ������]
DROP TABLE [����� � ��������]
DROP TABLE [������� � �������]
DROP TABLE [������� � ���������]
DROP TABLE [�������]
DROP PROCEDURE AddMediaArticle
DROP PROCEDURE AddMediaPage
DROP PROCEDURE AddHref
DROP PROCEDURE AddHrefArticle
DROP PROCEDURE AddHrefPage
GO
--������� ����� �������
CREATE TABLE [������ ������ ����]
(
	[ID ������ ����] uniqueidentifier,
	[ID ������] uniqueidentifier,
	PRIMARY KEY([ID ������ ����], [ID ������]),
	FOREIGN KEY([ID ������ ����]) REFERENCES [����� ����]([Id ������ ����]),
	FOREIGN KEY([ID ������]) REFERENCES [������]([Id ������])
)
GO
--������������ ������� �����: ������� ������� ���, ������� ������� ����, ��� ������� ������ - ��������
ALTER TABLE [�����]
ALTER COLUMN [������] BINARY NOT NULL
GO
ALTER TABLE [�����]
DROP COLUMN [���]
GO
ALTER TABLE [�����]
DROP COLUMN [����]
GO
--�������� �� ���������� ����� � ������������ � �����������
ALTER PROCEDURE [AddMedia]
@Data binary
AS
DECLARE @Date datetime
SELECT @Date = GETDATE()
INSERT INTO �����(������, [����� ��������])
VALUES(@Data,@Date);
GO
--������������ �� GetArticlesBrief
ALTER PROCEDURE [GetArticlesBrief]
@str_id uniqueidentifier
AS
SELECT [Id ������] FROM [������ � ���������]
WHERE [Id ��������]=@str_id
GO
--������������ ������������� Menu
ALTER VIEW Menu AS
SELECT P1.[Id ������ ����] 'ID', Pr1.������������ '����������', P1.������� '������� ����', P1.[��� ����] '���', 
P1.[URL] '������', P1.[������� �����������], SP1.[ID ������] 'ID ������',P2.[Id ������ ����] 'ID ��������', Pr2.������������ '��������'
FROM ([����� ����] P1 
INNER JOIN [������������� ����] Pr1 ON P1.[Id ������ ����] = Pr1.[Id ������ ����]
INNER JOIN [������ ������ ����] SP1 ON SP1.[ID ������ ����] = P1.[Id ������ ����])
LEFT JOIN ([����� ����] P2 INNER JOIN [������������� ����] Pr2 ON P2.[Id ������ ����]=Pr2.[Id ������ ����])
ON P1.[FK_Id ������ ����] = P2.[Id ������ ����]
GO
