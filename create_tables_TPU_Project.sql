USE TPU_Project;
GO

CREATE TABLE [������������]
(
 [Id ������������] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [�������] Varchar(45) NOT NULL,
 [���] Varchar(45) NOT NULL,
 [��������] Varchar(45) NULL,
 [����] Varchar(45) NOT NULL,
 [���] Bit NOT NULL,
 [�����������] Bit DEFAULT 0 NOT NULL,
 [ID �����] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table ������������
CREATE INDEX [FK_ID_�����] ON [������������] ([ID �����])
go
-- Add keys for table ������������
ALTER TABLE [������������] ADD CONSTRAINT [PK_Id_������������] PRIMARY KEY ([Id ������������])
go
-- Table ������ ���������
CREATE TABLE [������ ���������]
(
 [Id ��������] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [����� ��������] Varchar(11) NOT NULL,
 [Id ������������] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table ������ ���������
CREATE INDEX [FK_Id_������������] ON [������ ���������] ([Id ������������])
go
-- Add keys for table ������ ���������
ALTER TABLE [������ ���������] ADD CONSTRAINT [PK_Id_��������] PRIMARY KEY ([Id ��������])
go
-- Table ����������� �����
CREATE TABLE [����������� �����]
(
 [Id ������������ �����] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [������������] Varchar(45) NOT NULL,
 [Id ������������] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table ����������� �����
CREATE INDEX [FK_Id_������������] ON [����������� �����] ([Id ������������])
go
-- Add keys for table ����������� �����
ALTER TABLE [����������� �����] ADD CONSTRAINT [PF_Id_�����������_�����] PRIMARY KEY ([Id ������������ �����])
go
-- Table ����� ����
CREATE TABLE [����� ����]
(
 [Id ������ ����] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [�������] Varchar(30) NOT NULL,
 [FK_Id ������ ����] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table ����� ����
CREATE INDEX [FK_Id_������_����] ON [����� ����] ([FK_Id ������ ����])
go
-- Add keys for table ����� ����
ALTER TABLE [����� ����] ADD CONSTRAINT [PK_Id_������_����] PRIMARY KEY ([Id ������ ����])
go
-- Table ��������
CREATE TABLE [��������]
(
 [Id ��������] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [��������] Varchar(30) NOT NULL,
 [ID �����] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table ��������
CREATE INDEX [FK_Id_�����] ON [��������] ([ID �����])
go
-- Add keys for table ��������
ALTER TABLE [��������] ADD CONSTRAINT [PK_Id_��������] PRIMARY KEY ([Id ��������])
go
-- Table ������ � ���������
CREATE TABLE [������ � ���������]
(
 [Id ��������] Uniqueidentifier NOT NULL,
 [Id ������] Uniqueidentifier NOT NULL
)
go
-- Add keys for table ������ � ���������
ALTER TABLE [������ � ���������] ADD CONSTRAINT [PK_Id_��������_������] PRIMARY KEY ([Id ��������],[Id ������])
go
-- Table ������
CREATE TABLE [������]
(
 [Id ������] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [��������] Varchar(30) NOT NULL,
 [�����] Text NOT NULL,
 [��������] Varchar(30) NOT NULL,
 [����� ��������] Datetime DEFAULT GetDate() NOT NULL,
 [ID �����] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table ������
CREATE INDEX [FK_Id_�����] ON [������] ([ID �����])
go
-- Add keys for table ������
ALTER TABLE [������] ADD CONSTRAINT [PK_Id_������] PRIMARY KEY ([Id ������])
go
-- Table �����
CREATE TABLE [�����]
(
 [Id �����] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [���] Varchar(30) NOT NULL,
 [������] Image NOT NULL,
 [����] Varchar(30) NOT NULL,
 [����� ��������] Datetime DEFAULT GetDate() NOT NULL
)
go
-- Add keys for table �����
ALTER TABLE [�����] ADD CONSTRAINT [PK_Id_�����] PRIMARY KEY ([Id �����])
go
-- Table ����� � ������
CREATE TABLE [����� � ������]
(
 [Id ������] Uniqueidentifier NOT NULL,
 [Id �����] Uniqueidentifier NOT NULL
)
go
-- Add keys for table ����� � ������
ALTER TABLE [����� � ������] ADD CONSTRAINT [PK_�����_�_������] PRIMARY KEY ([Id ������],[Id �����])
go
-- Table �������
CREATE TABLE [�������]
(
 [Id ������] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [����� ������] Varchar(30) NOT NULL,
 [�����] Varchar(30) NOT NULL
)
go
-- Add keys for table �������
ALTER TABLE [�������] ADD CONSTRAINT [PK_Id_������] PRIMARY KEY ([Id ������])
go
-- Table ������� � �������
CREATE TABLE [������� � �������]
(
 [Id ������] Uniqueidentifier NOT NULL,
 [Id ������] Uniqueidentifier NOT NULL
)
go
-- Add keys for table ������� � �������
ALTER TABLE [������� � �������] ADD CONSTRAINT [PK_Id_������_������] PRIMARY KEY ([Id ������],[Id ������])
go
-- Table ������� � ���������
CREATE TABLE [������� � ���������]
(
 [Id ��������] Uniqueidentifier NOT NULL,
 [Id ������] Uniqueidentifier NOT NULL
)
go
-- Add keys for table ������� � ���������
ALTER TABLE [������� � ���������] ADD CONSTRAINT [PK_Id_��������_������] PRIMARY KEY ([Id ��������],[Id ������])
go
-- Table ����� � ��������
CREATE TABLE [����� � ��������]
(
 [Id �����] Uniqueidentifier NOT NULL,
 [Id ��������] Uniqueidentifier NOT NULL
)
go
-- Add keys for table ����� � ��������
ALTER TABLE [����� � ��������] ADD CONSTRAINT [PK_Id_�����_��������] PRIMARY KEY ([Id �����],[Id ��������])
go
-- Table �����
CREATE TABLE [�����]
(
 [ID �����] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [������������] Varchar(45) NOT NULL
)
go
-- Add keys for table �����
ALTER TABLE [�����] ADD CONSTRAINT [PK_Id_�����] PRIMARY KEY ([ID �����])
go
-- Table ������������� ����
CREATE TABLE [������������� ����]
(
 [������������] Varchar(45) NOT NULL,
 [ID �����] Uniqueidentifier NOT NULL,
 [Id ������ ����] Uniqueidentifier NOT NULL
)
go
-- Add keys for table ������������� ����
ALTER TABLE [������������� ����] ADD CONSTRAINT [PK_Id_�����_������_����] PRIMARY KEY ([ID �����],[Id ������ ����])
go
-- Table �������� ������ ����
CREATE TABLE [�������� ������ ����]
(
 [Id ������ ����] Uniqueidentifier NOT NULL,
 [Id ��������] Uniqueidentifier NOT NULL
)
go
-- Add keys for table �������� ������ ����
ALTER TABLE [�������� ������ ����] ADD CONSTRAINT [PK_Id_������_����_��������] PRIMARY KEY ([Id ������ ����],[Id ��������])
go
-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE [������ ���������] ADD CONSTRAINT [��������_������������] FOREIGN KEY ([Id ������������]) REFERENCES [������������] ([Id ������������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [����������� �����] ADD CONSTRAINT [����������������_������������] FOREIGN KEY ([Id ������������]) REFERENCES [������������] ([Id ������������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [����� ����] ADD CONSTRAINT [���������_�����������������������] FOREIGN KEY ([FK_Id ������ ����]) REFERENCES [����� ����] ([Id ������ ����]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������ � ���������] ADD CONSTRAINT [������_��������] FOREIGN KEY ([Id ��������]) REFERENCES [��������] ([Id ��������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������ � ���������] ADD CONSTRAINT [����������������_������] FOREIGN KEY ([Id ������]) REFERENCES [������] ([Id ������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [����� � ������] ADD CONSTRAINT [������������_������] FOREIGN KEY ([Id ������]) REFERENCES [������] ([Id ������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [����� � ������] ADD CONSTRAINT [������������_�����] FOREIGN KEY ([Id �����]) REFERENCES [�����] ([Id �����]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������� � �������] ADD CONSTRAINT [���������������_������] FOREIGN KEY ([Id ������]) REFERENCES [������] ([Id ������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������� � �������] ADD CONSTRAINT [���������������_������] FOREIGN KEY ([Id ������]) REFERENCES [�������] ([Id ������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [����� � ��������] ADD CONSTRAINT [�������������_�����] FOREIGN KEY ([Id �����]) REFERENCES [�����] ([Id �����]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [����� � ��������] ADD CONSTRAINT [��������������_��������] FOREIGN KEY ([Id ��������]) REFERENCES [��������] ([Id ��������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������� � ���������] ADD CONSTRAINT [�����������������_��������] FOREIGN KEY ([Id ��������]) REFERENCES [��������] ([Id ��������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������� � ���������] ADD CONSTRAINT [�����������������_������] FOREIGN KEY ([Id ������]) REFERENCES [�������] ([Id ������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������������� ����] ADD CONSTRAINT [�������������_�����] FOREIGN KEY ([ID �����]) REFERENCES [�����] ([ID �����]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [�������� ������ ����] ADD CONSTRAINT [������������������_����������] FOREIGN KEY ([Id ������ ����]) REFERENCES [����� ����] ([Id ������ ����]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [�������� ������ ����] ADD CONSTRAINT [������������������_��������] FOREIGN KEY ([Id ��������]) REFERENCES [��������] ([Id ��������]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������������] ADD CONSTRAINT [������������_�����] FOREIGN KEY ([ID �����]) REFERENCES [�����] ([ID �����]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [��������] ADD CONSTRAINT [��������_�����] FOREIGN KEY ([ID �����]) REFERENCES [�����] ([ID �����]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������] ADD CONSTRAINT [������_�����] FOREIGN KEY ([ID �����]) REFERENCES [�����] ([ID �����]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [������������� ����] ADD CONSTRAINT [�����������������_���������] FOREIGN KEY ([Id ������ ����]) REFERENCES [����� ����] ([Id ������ ����]) ON UPDATE NO ACTION ON DELETE NO ACTION
go
