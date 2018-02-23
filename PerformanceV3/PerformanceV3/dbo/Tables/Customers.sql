CREATE TABLE [dbo].[Customers] (
    [custid]   CHAR (11)     NOT NULL,
    [custname] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([custid] ASC)
);

