USE TPU_Project;
GO

CREATE TABLE [Пользователь]
(
 [Id Пользователя] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [Фамилия] Varchar(45) NOT NULL,
 [Имя] Varchar(45) NOT NULL,
 [Отчество] Varchar(45) NULL,
 [Роль] Varchar(45) NOT NULL,
 [Пол] Bit NOT NULL,
 [Регистрация] Bit DEFAULT 0 NOT NULL,
 [ID языка] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table Пользователь
CREATE INDEX [FK_ID_языка] ON [Пользователь] ([ID языка])
go
-- Add keys for table Пользователь
ALTER TABLE [Пользователь] ADD CONSTRAINT [PK_Id_Пользователя] PRIMARY KEY ([Id Пользователя])
go
-- Table Номера телефонов
CREATE TABLE [Номера телефонов]
(
 [Id Телефона] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [Номер телефона] Varchar(11) NOT NULL,
 [Id Пользователя] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table Номера телефонов
CREATE INDEX [FK_Id_Пользователя] ON [Номера телефонов] ([Id Пользователя])
go
-- Add keys for table Номера телефонов
ALTER TABLE [Номера телефонов] ADD CONSTRAINT [PK_Id_Телефона] PRIMARY KEY ([Id Телефона])
go
-- Table Электорнная почта
CREATE TABLE [Электорнная почта]
(
 [Id электоронной почты] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [Наименование] Varchar(45) NOT NULL,
 [Id Пользователя] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table Электорнная почта
CREATE INDEX [FK_Id_Пользователя] ON [Электорнная почта] ([Id Пользователя])
go
-- Add keys for table Электорнная почта
ALTER TABLE [Электорнная почта] ADD CONSTRAINT [PF_Id_Электронной_почты] PRIMARY KEY ([Id электоронной почты])
go
-- Table Пункт меню
CREATE TABLE [Пункт меню]
(
 [Id пункта меню] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [Позиция] Varchar(30) NOT NULL,
 [FK_Id пункта меню] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table Пункт меню
CREATE INDEX [FK_Id_Пункта_меню] ON [Пункт меню] ([FK_Id пункта меню])
go
-- Add keys for table Пункт меню
ALTER TABLE [Пункт меню] ADD CONSTRAINT [PK_Id_Пункта_меню] PRIMARY KEY ([Id пункта меню])
go
-- Table Страница
CREATE TABLE [Страница]
(
 [Id страницы] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [Название] Varchar(30) NOT NULL,
 [ID языка] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table Страница
CREATE INDEX [FK_Id_Языка] ON [Страница] ([ID языка])
go
-- Add keys for table Страница
ALTER TABLE [Страница] ADD CONSTRAINT [PK_Id_Страницы] PRIMARY KEY ([Id страницы])
go
-- Table Статьи в страницах
CREATE TABLE [Статьи в страницах]
(
 [Id страницы] Uniqueidentifier NOT NULL,
 [Id статьи] Uniqueidentifier NOT NULL
)
go
-- Add keys for table Статьи в страницах
ALTER TABLE [Статьи в страницах] ADD CONSTRAINT [PK_Id_Страницы_статьи] PRIMARY KEY ([Id страницы],[Id статьи])
go
-- Table Статья
CREATE TABLE [Статья]
(
 [Id статьи] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [Название] Varchar(30) NOT NULL,
 [Текст] Text NOT NULL,
 [Тематика] Varchar(30) NOT NULL,
 [Время создания] Datetime DEFAULT GetDate() NOT NULL,
 [ID языка] Uniqueidentifier NOT NULL
)
go
-- Create indexes for table Статья
CREATE INDEX [FK_Id_Языка] ON [Статья] ([ID языка])
go
-- Add keys for table Статья
ALTER TABLE [Статья] ADD CONSTRAINT [PK_Id_статьи] PRIMARY KEY ([Id статьи])
go
-- Table Медиа
CREATE TABLE [Медиа]
(
 [Id Медиа] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [Тип] Varchar(30) NOT NULL,
 [Данные] Image NOT NULL,
 [Тема] Varchar(30) NOT NULL,
 [Время создания] Datetime DEFAULT GetDate() NOT NULL
)
go
-- Add keys for table Медиа
ALTER TABLE [Медиа] ADD CONSTRAINT [PK_Id_Медиа] PRIMARY KEY ([Id Медиа])
go
-- Table Медиа в статье
CREATE TABLE [Медиа в статье]
(
 [Id статьи] Uniqueidentifier NOT NULL,
 [Id Медиа] Uniqueidentifier NOT NULL
)
go
-- Add keys for table Медиа в статье
ALTER TABLE [Медиа в статье] ADD CONSTRAINT [PK_Медиа_в_статье] PRIMARY KEY ([Id статьи],[Id Медиа])
go
-- Table Сссылка
CREATE TABLE [Сссылка]
(
 [Id ссылки] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [Адрес ссылки] Varchar(30) NOT NULL,
 [Текст] Varchar(30) NOT NULL
)
go
-- Add keys for table Сссылка
ALTER TABLE [Сссылка] ADD CONSTRAINT [PK_Id_Ссылки] PRIMARY KEY ([Id ссылки])
go
-- Table Сссылки в статьях
CREATE TABLE [Сссылки в статьях]
(
 [Id статьи] Uniqueidentifier NOT NULL,
 [Id ссылки] Uniqueidentifier NOT NULL
)
go
-- Add keys for table Сссылки в статьях
ALTER TABLE [Сссылки в статьях] ADD CONSTRAINT [PK_Id_статьи_ссылки] PRIMARY KEY ([Id статьи],[Id ссылки])
go
-- Table Сссылки в страницах
CREATE TABLE [Сссылки в страницах]
(
 [Id страницы] Uniqueidentifier NOT NULL,
 [Id ссылки] Uniqueidentifier NOT NULL
)
go
-- Add keys for table Сссылки в страницах
ALTER TABLE [Сссылки в страницах] ADD CONSTRAINT [PK_Id_страницы_ссылки] PRIMARY KEY ([Id страницы],[Id ссылки])
go
-- Table Медиа в странице
CREATE TABLE [Медиа в странице]
(
 [Id Медиа] Uniqueidentifier NOT NULL,
 [Id страницы] Uniqueidentifier NOT NULL
)
go
-- Add keys for table Медиа в странице
ALTER TABLE [Медиа в странице] ADD CONSTRAINT [PK_Id_Медиа_страницы] PRIMARY KEY ([Id Медиа],[Id страницы])
go
-- Table Языки
CREATE TABLE [Языки]
(
 [ID языка] Uniqueidentifier DEFAULT NewId() NOT NULL,
 [Наименование] Varchar(45) NOT NULL
)
go
-- Add keys for table Языки
ALTER TABLE [Языки] ADD CONSTRAINT [PK_Id_языка] PRIMARY KEY ([ID языка])
go
-- Table Представление меню
CREATE TABLE [Представление меню]
(
 [Наименование] Varchar(45) NOT NULL,
 [ID языка] Uniqueidentifier NOT NULL,
 [Id пункта меню] Uniqueidentifier NOT NULL
)
go
-- Add keys for table Представление меню
ALTER TABLE [Представление меню] ADD CONSTRAINT [PK_Id_языка_пункта_меню] PRIMARY KEY ([ID языка],[Id пункта меню])
go
-- Table Страницы пункты меню
CREATE TABLE [Страницы пункты меню]
(
 [Id пункта меню] Uniqueidentifier NOT NULL,
 [Id страницы] Uniqueidentifier NOT NULL
)
go
-- Add keys for table Страницы пункты меню
ALTER TABLE [Страницы пункты меню] ADD CONSTRAINT [PK_Id_пункта_меню_страницы] PRIMARY KEY ([Id пункта меню],[Id страницы])
go
-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE [Номера телефонов] ADD CONSTRAINT [Телефоны_пользователи] FOREIGN KEY ([Id Пользователя]) REFERENCES [Пользователь] ([Id Пользователя]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Электорнная почта] ADD CONSTRAINT [ЭлекторннаяПочта_Пользователь] FOREIGN KEY ([Id Пользователя]) REFERENCES [Пользователь] ([Id Пользователя]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Пункт меню] ADD CONSTRAINT [ПунктМеню_ПунктМенюВерхнегоУровня] FOREIGN KEY ([FK_Id пункта меню]) REFERENCES [Пункт меню] ([Id пункта меню]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Статьи в страницах] ADD CONSTRAINT [Статьи_Страницы] FOREIGN KEY ([Id страницы]) REFERENCES [Страница] ([Id страницы]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Статьи в страницах] ADD CONSTRAINT [СтатьиВСтраницах_Статьи] FOREIGN KEY ([Id статьи]) REFERENCES [Статья] ([Id статьи]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Медиа в статье] ADD CONSTRAINT [МедиаВСтатье_Статьи] FOREIGN KEY ([Id статьи]) REFERENCES [Статья] ([Id статьи]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Медиа в статье] ADD CONSTRAINT [МедиаВСтатье_Медиа] FOREIGN KEY ([Id Медиа]) REFERENCES [Медиа] ([Id Медиа]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Сссылки в статьях] ADD CONSTRAINT [СссылкиВСтатьях_Статьи] FOREIGN KEY ([Id статьи]) REFERENCES [Статья] ([Id статьи]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Сссылки в статьях] ADD CONSTRAINT [СссылкиВСтатьях_Ссылки] FOREIGN KEY ([Id ссылки]) REFERENCES [Сссылка] ([Id ссылки]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Медиа в странице] ADD CONSTRAINT [МедиаВСтатьях_Медиа] FOREIGN KEY ([Id Медиа]) REFERENCES [Медиа] ([Id Медиа]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Медиа в странице] ADD CONSTRAINT [МедиаВСтранице_Страницы] FOREIGN KEY ([Id страницы]) REFERENCES [Страница] ([Id страницы]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Сссылки в страницах] ADD CONSTRAINT [СссылкиВСтраницах_Страницы] FOREIGN KEY ([Id страницы]) REFERENCES [Страница] ([Id страницы]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Сссылки в страницах] ADD CONSTRAINT [СссылкиВСтраницах_Ссылки] FOREIGN KEY ([Id ссылки]) REFERENCES [Сссылка] ([Id ссылки]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Представление меню] ADD CONSTRAINT [Представление_Языки] FOREIGN KEY ([ID языка]) REFERENCES [Языки] ([ID языка]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Страницы пункты меню] ADD CONSTRAINT [СтраницыПунктыМеню_ПунктыМеню] FOREIGN KEY ([Id пункта меню]) REFERENCES [Пункт меню] ([Id пункта меню]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Страницы пункты меню] ADD CONSTRAINT [СтраницыПунктыМеню_Страницы] FOREIGN KEY ([Id страницы]) REFERENCES [Страница] ([Id страницы]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Пользователь] ADD CONSTRAINT [Пользователь_Языки] FOREIGN KEY ([ID языка]) REFERENCES [Языки] ([ID языка]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Страница] ADD CONSTRAINT [Страница_Языки] FOREIGN KEY ([ID языка]) REFERENCES [Языки] ([ID языка]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Статья] ADD CONSTRAINT [Статья_Языки] FOREIGN KEY ([ID языка]) REFERENCES [Языки] ([ID языка]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Представление меню] ADD CONSTRAINT [ПредставлениеМеню_ПунктМеню] FOREIGN KEY ([Id пункта меню]) REFERENCES [Пункт меню] ([Id пункта меню]) ON UPDATE NO ACTION ON DELETE NO ACTION
go
