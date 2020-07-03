USE TPU_Project;
GO

CREATE TRIGGER MEDIA_UPDATE
ON [Медиа]
AFTER UPDATE
AS
UPDATE [Медиа]
SET [Время создания] = GETDATE()
WHERE [Id Медиа] = (SELECT [Id Медиа] FROM inserted);

GO

CREATE TRIGGER STAT_UPDATE
ON [Статья]
AFTER UPDATE
AS
UPDATE [Статья]
SET [Время создания] = GETDATE()
WHERE [Id статьи] = (SELECT [Id статьи] FROM inserted);