CREATE TABLE [dbo].[Dim3] (
    [key3]   INT          NOT NULL,
    [attr1]  INT          NOT NULL,
    [filler] BINARY (100) DEFAULT (0x) NOT NULL,
    CONSTRAINT [PK_Dim3] PRIMARY KEY CLUSTERED ([key3] ASC)
);

