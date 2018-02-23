CREATE TABLE [dbo].[Fact] (
    [key1]     INT           NOT NULL,
    [key2]     INT           NOT NULL,
    [key3]     INT           NOT NULL,
    [measure1] INT           NOT NULL,
    [measure2] INT           NOT NULL,
    [measure3] INT           NOT NULL,
    [measure4] NVARCHAR (50) NULL,
    [filler]   BINARY (100)  DEFAULT (0x) NOT NULL,
    CONSTRAINT [PK_Fact] PRIMARY KEY CLUSTERED ([key1] ASC, [key2] ASC, [key3] ASC)
);

