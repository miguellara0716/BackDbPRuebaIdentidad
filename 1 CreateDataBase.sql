USE [master]
GO
/****** Object:  Database [ReaderCSV]    Script Date: 01/07/2022 17:09:58 ******/
CREATE DATABASE [ReaderCSV]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ReaderCSV', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ReaderCSV.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ReaderCSV_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ReaderCSV_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ReaderCSV] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ReaderCSV].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ReaderCSV] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ReaderCSV] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ReaderCSV] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ReaderCSV] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ReaderCSV] SET ARITHABORT OFF 
GO
ALTER DATABASE [ReaderCSV] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ReaderCSV] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ReaderCSV] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ReaderCSV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ReaderCSV] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ReaderCSV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ReaderCSV] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ReaderCSV] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ReaderCSV] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ReaderCSV] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ReaderCSV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ReaderCSV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ReaderCSV] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ReaderCSV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ReaderCSV] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ReaderCSV] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ReaderCSV] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ReaderCSV] SET RECOVERY FULL 
GO
ALTER DATABASE [ReaderCSV] SET  MULTI_USER 
GO
ALTER DATABASE [ReaderCSV] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ReaderCSV] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ReaderCSV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ReaderCSV] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ReaderCSV] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ReaderCSV] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ReaderCSV', N'ON'
GO
ALTER DATABASE [ReaderCSV] SET QUERY_STORE = OFF
GO
USE [ReaderCSV]
GO
/****** Object:  Table [dbo].[FileUploads]    Script Date: 01/07/2022 17:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileUploads](
	[IdFileUpload] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](50) NOT NULL,
	[DateCreation] [datetime] NOT NULL,
 CONSTRAINT [PK_FileUploads] PRIMARY KEY CLUSTERED 
(
	[IdFileUpload] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registers]    Script Date: 01/07/2022 17:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registers](
	[IdRegister] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUpload] [int] NOT NULL,
	[NumerRow] [int] NOT NULL,
	[NumberColumn] [int] NOT NULL,
	[Data] [varchar](max) NOT NULL,
	[DateCreation] [datetime] NOT NULL,
 CONSTRAINT [PK_Registers] PRIMARY KEY CLUSTERED 
(
	[IdRegister] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 01/07/2022 17:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[IdState] [tinyint] IDENTITY(1,1) NOT NULL,
	[NameState] [varchar](20) NOT NULL,
 CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED 
(
	[IdState] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01/07/2022 17:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[IdUser] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](150) NOT NULL,
	[Password] [varchar](250) NOT NULL,
	[State] [tinyint] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Registers]  WITH NOCHECK ADD  CONSTRAINT [FK_Registers_FileUploads] FOREIGN KEY([IdUpload])
REFERENCES [dbo].[FileUploads] ([IdFileUpload])
GO
ALTER TABLE [dbo].[Registers] CHECK CONSTRAINT [FK_Registers_FileUploads]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_States] FOREIGN KEY([State])
REFERENCES [dbo].[States] ([IdState])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_States]
GO
/****** Object:  StoredProcedure [dbo].[pa_GetRegister]    Script Date: 01/07/2022 17:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================================================
-- Author:		Miguel Angel Lara Alvarado
-- Create date: 30/06/2022
-- Description:	Procedimiento de almacenado que devuelve los registros de un archivo
-- ===================================================================================
CREATE PROCEDURE [dbo].[pa_GetRegister] 
	@IdFile INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT NumerRow
		  ,NumberColumn
		  ,Data
		FROM Registers WITH (NOLOCK)
	WHERE IdUpload = @IdFile
	ORDER BY NumerRow, NumberColumn

END
GO
/****** Object:  StoredProcedure [dbo].[pa_ObtenerFileUploads]    Script Date: 01/07/2022 17:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================================================
-- Author:		Miguel Angel Lara Alvarado
-- Create date: 30/06/2022
-- Description:	Procedimiento de almacenado que devuelve los archivos subidos
-- ===================================================================================
CREATE PROCEDURE [dbo].[pa_ObtenerFileUploads]

AS
BEGIN

	SET NOCOUNT ON;
	   
	SELECT IdFileUpload,
		   FileName
		FROM FileUploads WITH (NOLOCK)
	
END
GO
/****** Object:  StoredProcedure [dbo].[pa_SavedFileName]    Script Date: 01/07/2022 17:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================================================
-- Author:		Miguel Angel Lara Alvarado
-- Create date: 30/06/2022
-- Description:	Procedimiento de almacenado que guarda los datos de un archivo subido
-- ===================================================================================
CREATE   PROCEDURE [dbo].[pa_SavedFileName]
	@FileName VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

    
	INSERT INTO FileUploads
	(FileName
	,DateCreation)
	VALUES
	(@FileName
	,SYSDATETIME())

	SELECT @@IDENTITY AS IdFileUpload
END
GO
/****** Object:  StoredProcedure [dbo].[pa_VerifyCredentials]    Script Date: 01/07/2022 17:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================================
-- Author:		Miguel Angel Lara Alvarado
-- Create date: 30/06/2022
-- Description:	Procedimiento de almacenado que verifica unas credenciales
-- ========================================================================
CREATE PROCEDURE [dbo].[pa_VerifyCredentials]
	@UserName VARCHAR(150),
	@Password VARCHAR(250)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @_StateActive TINYINT = 1

	SELECT null 
		FROM Users WITH (NOLOCK)
	WHERE UserName = @UserName AND Password  = @Password AND State = @_StateActive

END
GO
USE [master]
GO
ALTER DATABASE [ReaderCSV] SET  READ_WRITE 
GO
