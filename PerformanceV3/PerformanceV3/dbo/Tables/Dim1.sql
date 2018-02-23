CREATE TABLE [dbo].[Dim1] (
    [key1]   INT          NOT NULL,
    [attr1]  INT          NOT NULL,
    [filler] BINARY (100) DEFAULT (0x) NOT NULL,
    CONSTRAINT [PK_Dim1] PRIMARY KEY CLUSTERED ([key1] ASC)
);

