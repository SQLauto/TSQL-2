CREATE TABLE [dbo].[Dim2] (
    [key2]   INT          NOT NULL,
    [attr1]  INT          NOT NULL,
    [filler] BINARY (100) DEFAULT (0x) NOT NULL,
    CONSTRAINT [PK_Dim2] PRIMARY KEY CLUSTERED ([key2] ASC)
);

