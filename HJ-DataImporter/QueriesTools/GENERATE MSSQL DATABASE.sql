USE [master]
GO
/****** Object:  Database [HJ]    Script Date: 16/08/2017 5:32:15 PM ******/
CREATE DATABASE [HJ]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HJ', FILENAME = N'C:\Users\kagajjar\HJ.mdf' , SIZE = 1687168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HJ_log', FILENAME = N'C:\Users\kagajjar\HJ_log.ldf' , SIZE = 24576KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [HJ] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HJ].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HJ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HJ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HJ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HJ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HJ] SET ARITHABORT OFF 
GO
ALTER DATABASE [HJ] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HJ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HJ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HJ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HJ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HJ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HJ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HJ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HJ] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HJ] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HJ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HJ] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HJ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HJ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HJ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HJ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HJ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HJ] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HJ] SET  MULTI_USER 
GO
ALTER DATABASE [HJ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HJ] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HJ] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HJ] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HJ] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HJ] SET QUERY_STORE = OFF
GO
USE [HJ]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [HJ]
GO
/****** Object:  Table [dbo].[Hotels]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotels](
	[HotelId] [int] NOT NULL,
	[CityId] [int] NULL,
	[HotelName] [nvarchar](255) NULL,
	[StarRating] [int] NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[Address] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[PhoneNumber] [float] NULL,
 CONSTRAINT [PK_Hotels] PRIMARY KEY CLUSTERED 
(
	[HotelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Descriptions]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Descriptions](
	[HotelId] [int] NULL,
	[Description] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[OuterJoin]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OuterJoin]
AS
SELECT        h1.HotelId, h1.CityId, h1.HotelName, h1.StarRating, h1.Latitude, h1.Longitude, h1.Address, h1.Location, h1.PhoneNumber, F1.HotelId AS Expr1, F1.Description
FROM            dbo.Hotels AS h1 RIGHT OUTER JOIN
                         dbo.Descriptions AS F1 ON h1.HotelId = F1.HotelId
WHERE        (h1.HotelId IS NULL)

GO
/****** Object:  Table [dbo].[Cities]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityId] [int] NOT NULL,
	[CityName] [varchar](50) NULL,
	[StateCode] [varchar](10) NULL,
	[CountryCode] [varchar](2) NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CitiesTemp]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CitiesTemp](
	[CityId] [float] NULL,
	[CityName] [nvarchar](100) NULL,
	[StateCode] [varchar](50) NULL,
	[CountryCode] [varchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryCode] [varchar](2) NULL,
	[CountryName] [varchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CountriesTemp]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountriesTemp](
	[CountryCode] [varchar](50) NULL,
	[CountryName] [varchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DescriptionsTemp]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DescriptionsTemp](
	[HotelId] [int] NULL,
	[Description] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Facilities]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facilities](
	[HotelId] [int] NOT NULL,
	[FacilityType] [varchar](50) NULL,
	[FacilityName] [varchar](200) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FacilitiesTemp]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacilitiesTemp](
	[HotelId] [int] NULL,
	[FacilityType] [varchar](50) NULL,
	[FacilityName] [varchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HotelsTemp]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HotelsTemp](
	[HotelId] [float] NULL,
	[CityId] [float] NULL,
	[HotelName] [varchar](500) NULL,
	[StarRating] [float] NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[Address] [varchar](500) NULL,
	[Location] [varchar](500) NULL,
	[PhoneNumber] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Images]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[HotelId] [int] NULL,
	[Image] [varchar](200) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImagesTemp]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImagesTemp](
	[HotelId] [varchar](50) NOT NULL,
	[Image] [varchar](200) NULL
) ON [PRIMARY]

GO
/****** Object:  Index [IX_Descriptions]    Script Date: 16/08/2017 5:32:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Descriptions] ON [dbo].[Descriptions]
(
	[HotelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Facilities]    Script Date: 16/08/2017 5:32:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Facilities] ON [dbo].[Facilities]
(
	[HotelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Hotels]    Script Date: 16/08/2017 5:32:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Hotels] ON [dbo].[Hotels]
(
	[HotelId] ASC,
	[CityId] ASC,
	[HotelName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Images]    Script Date: 16/08/2017 5:32:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Images] ON [dbo].[Images]
(
	[HotelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Descriptions]  WITH CHECK ADD  CONSTRAINT [FK_Descriptions_Hotels] FOREIGN KEY([HotelId])
REFERENCES [dbo].[Hotels] ([HotelId])
GO
ALTER TABLE [dbo].[Descriptions] CHECK CONSTRAINT [FK_Descriptions_Hotels]
GO
ALTER TABLE [dbo].[Facilities]  WITH CHECK ADD  CONSTRAINT [FK_Facilities_Hotels] FOREIGN KEY([HotelId])
REFERENCES [dbo].[Hotels] ([HotelId])
GO
ALTER TABLE [dbo].[Facilities] CHECK CONSTRAINT [FK_Facilities_Hotels]
GO
ALTER TABLE [dbo].[Hotels]  WITH CHECK ADD  CONSTRAINT [FK_Hotels_Cities] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[Hotels] CHECK CONSTRAINT [FK_Hotels_Cities]
GO
ALTER TABLE [dbo].[Images]  WITH CHECK ADD  CONSTRAINT [FK_Images_Hotels] FOREIGN KEY([HotelId])
REFERENCES [dbo].[Hotels] ([HotelId])
GO
ALTER TABLE [dbo].[Images] CHECK CONSTRAINT [FK_Images_Hotels]
GO
/****** Object:  StoredProcedure [dbo].[DeleteFromDescriptionsHotelId]    Script Date: 16/08/2017 5:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteFromDescriptionsHotelId] 
@HotelId int,
@TableName varchar
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
DELETE 
	FROM Descriptions
	WHERE HotelId = @HotelId

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "h1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "F1"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OuterJoin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OuterJoin'
GO
USE [master]
GO
ALTER DATABASE [HJ] SET  READ_WRITE 
GO
