CREATE TABLE [dbo].[Employees] (
    [empid]     INT           NOT NULL,
    [firstname] NVARCHAR (25) NOT NULL,
    [lastname]  NVARCHAR (25) NOT NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([empid] ASC)
);

