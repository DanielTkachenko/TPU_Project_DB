USE TPU_Project;
GO

CREATE TRIGGER MEDIA_UPDATE
ON [�����]
AFTER UPDATE
AS
UPDATE [�����]
SET [����� ��������] = GETDATE()
WHERE [Id �����] = (SELECT [Id �����] FROM inserted);

GO

CREATE TRIGGER STAT_UPDATE
ON [������]
AFTER UPDATE
AS
UPDATE [������]
SET [����� ��������] = GETDATE()
WHERE [Id ������] = (SELECT [Id ������] FROM inserted);