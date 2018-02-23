CREATE TABLE [dbo].[Shippers] (
    [shipperid]   VARCHAR (5)   NOT NULL,
    [shippername] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED ([shipperid] ASC)
);

