CREATE TABLE [EMPLOYEE] (
  [SSN] char(9) PRIMARY KEY,
  [Fname] varchar(50) NOT NULL,
  [Lname] varchar(50) NOT NULL,
  [BirthDate] date NOT NULL,
  [Gender] char(1),
  [SupervisorSSN] char(9),
  [DNUM] int NOT NULL
)
GO

CREATE TABLE [DEPARTMENT] (
  [DNUM] int PRIMARY KEY,
  [DName] varchar(100) UNIQUE NOT NULL,
  [ManagerSSN] char(9) UNIQUE NOT NULL,
  [ManagerStartDate] date NOT NULL
)
GO

CREATE TABLE [PROJECT] (
  [PNumber] int PRIMARY KEY,
  [PName] varchar(100) NOT NULL,
  [Location] varchar(100),
  [DNUM] int NOT NULL
)
GO

CREATE TABLE [WORKS_ON] (
  [ESSN] char(9) NOT NULL,
  [PNO] int NOT NULL,
  [Hours] decimal(5,2) NOT NULL,
  [primary] key(ESSN,PNO)
)
GO

CREATE TABLE [DEPENDENT] (
  [ESSN] char(9) NOT NULL,
  [DependentName] varchar(50) NOT NULL,
  [Gender] char(1),
  [BirthDate] date NOT NULL,
  [primary] key(ESSN,DependentName)
)
GO

CREATE TABLE [DEPT_LOCATIONS] (
  [DNUM] int NOT NULL,
  [Location] varchar(100) NOT NULL,
  [primary] key(DNUM,Location)
)
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'M or F',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'EMPLOYEE',
@level2type = N'Column', @level2name = 'Gender';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'M or F',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'DEPENDENT',
@level2type = N'Column', @level2name = 'Gender';
GO

ALTER TABLE [EMPLOYEE] ADD FOREIGN KEY ([SupervisorSSN]) REFERENCES [EMPLOYEE] ([SSN])
GO

ALTER TABLE [EMPLOYEE] ADD FOREIGN KEY ([DNUM]) REFERENCES [DEPARTMENT] ([DNUM])
GO

ALTER TABLE [DEPARTMENT] ADD FOREIGN KEY ([ManagerSSN]) REFERENCES [EMPLOYEE] ([SSN])
GO

ALTER TABLE [PROJECT] ADD FOREIGN KEY ([DNUM]) REFERENCES [DEPARTMENT] ([DNUM])
GO

ALTER TABLE [WORKS_ON] ADD FOREIGN KEY ([ESSN]) REFERENCES [EMPLOYEE] ([SSN])
GO

ALTER TABLE [WORKS_ON] ADD FOREIGN KEY ([PNO]) REFERENCES [PROJECT] ([PNumber])
GO

ALTER TABLE [DEPENDENT] ADD FOREIGN KEY ([ESSN]) REFERENCES [EMPLOYEE] ([SSN])
GO

ALTER TABLE [DEPT_LOCATIONS] ADD FOREIGN KEY ([DNUM]) REFERENCES [DEPARTMENT] ([DNUM])
GO
