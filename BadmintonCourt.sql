USE [master]
GO
/****** Object:  Database [BadmintonCourt]    Script Date: 7/20/2024 1:50:59 PM ******/
CREATE DATABASE [BadmintonCourt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BadmintonCourt', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MINHDUC\MSSQL\DATA\BadmintonCourt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BadmintonCourt_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MINHDUC\MSSQL\DATA\BadmintonCourt_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BadmintonCourt] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BadmintonCourt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BadmintonCourt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BadmintonCourt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BadmintonCourt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BadmintonCourt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BadmintonCourt] SET ARITHABORT OFF 
GO
ALTER DATABASE [BadmintonCourt] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BadmintonCourt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BadmintonCourt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BadmintonCourt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BadmintonCourt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BadmintonCourt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BadmintonCourt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BadmintonCourt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BadmintonCourt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BadmintonCourt] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BadmintonCourt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BadmintonCourt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BadmintonCourt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BadmintonCourt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BadmintonCourt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BadmintonCourt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BadmintonCourt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BadmintonCourt] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BadmintonCourt] SET  MULTI_USER 
GO
ALTER DATABASE [BadmintonCourt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BadmintonCourt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BadmintonCourt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BadmintonCourt] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BadmintonCourt] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BadmintonCourt] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BadmintonCourt] SET QUERY_STORE = ON
GO
ALTER DATABASE [BadmintonCourt] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BadmintonCourt]
GO
/****** Object:  Table [dbo].[BookedSlot]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookedSlot](
	[slotID] [varchar](30) NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NOT NULL,
	[courtID] [varchar](30) NOT NULL,
	[bookingID] [varchar](30) NOT NULL,
	[isDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[slotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[bookingID] [varchar](30) NOT NULL,
	[amount] [float] NOT NULL,
	[bookingType] [int] NOT NULL,
	[userID] [varchar](30) NOT NULL,
	[bookingDate] [datetime] NOT NULL,
	[changeLog] [int] NOT NULL,
	[isDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[bookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Court]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Court](
	[courtID] [varchar](30) NOT NULL,
	[courtImg] [varchar](3000) NULL,
	[branchID] [varchar](30) NOT NULL,
	[price] [real] NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[courtName] [nvarchar](30) NOT NULL,
	[courtStatus] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[courtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourtBranch]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourtBranch](
	[branchID] [varchar](30) NOT NULL,
	[location] [nvarchar](500) NULL,
	[branchName] [nvarchar](50) NOT NULL,
	[branchPhone] [varchar](10) NOT NULL,
	[branchImg] [varchar](3000) NULL,
	[branchStatus] [int] NOT NULL,
	[mapUrl] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[branchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[discountID] [varchar](30) NOT NULL,
	[amount] [float] NOT NULL,
	[proportion] [float] NOT NULL,
	[isDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[discountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[feedbackID] [varchar](30) NOT NULL,
	[rating] [int] NOT NULL,
	[content] [nvarchar](500) NOT NULL,
	[userID] [varchar](30) NULL,
	[branchID] [varchar](30) NOT NULL,
	[period] [datetime] NOT NULL,
	[isDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[feedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[paymentID] [varchar](30) NOT NULL,
	[userID] [varchar](30) NOT NULL,
	[date] [datetime] NOT NULL,
	[bookingID] [varchar](30) NULL,
	[method] [int] NOT NULL,
	[amount] [float] NOT NULL,
	[transactionId] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[paymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[roleID] [varchar](30) NOT NULL,
	[role] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[userID] [varchar](30) NOT NULL,
	[userName] [nvarchar](50) NULL,
	[password] [varchar](200) NULL,
	[branchID] [varchar](30) NULL,
	[roleID] [varchar](30) NOT NULL,
	[token] [varchar](1000) NULL,
	[actionPeriod] [datetime] NULL,
	[balance] [float] NULL,
	[accessFail] [int] NULL,
	[lastFail] [datetime] NULL,
	[activeStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDetail]    Script Date: 7/20/2024 1:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetail](
	[userID] [varchar](30) NOT NULL,
	[firstName] [nvarchar](50) NULL,
	[lastName] [nvarchar](50) NULL,
	[email] [varchar](50) NOT NULL,
	[phone] [varchar](10) NULL,
	[facebook] [varchar](50) NULL,
	[img] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000002', CAST(N'2024-07-13T17:00:00.000' AS DateTime), CAST(N'2024-07-13T19:00:00.000' AS DateTime), N'C014', N'BK0000002', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000003', CAST(N'2024-06-07T17:00:00.000' AS DateTime), CAST(N'2024-06-07T19:00:00.000' AS DateTime), N'C001', N'BK0000003', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000004', CAST(N'2024-06-14T17:00:00.000' AS DateTime), CAST(N'2024-06-14T19:00:00.000' AS DateTime), N'C001', N'BK0000003', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000005', CAST(N'2024-06-21T17:00:00.000' AS DateTime), CAST(N'2024-06-21T19:00:00.000' AS DateTime), N'C001', N'BK0000003', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000006', CAST(N'2024-06-28T17:00:00.000' AS DateTime), CAST(N'2024-06-28T19:00:00.000' AS DateTime), N'C001', N'BK0000003', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000007', CAST(N'2024-07-05T17:00:00.000' AS DateTime), CAST(N'2024-07-05T19:00:00.000' AS DateTime), N'C001', N'BK0000003', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000008', CAST(N'2024-07-12T17:00:00.000' AS DateTime), CAST(N'2024-07-12T19:00:00.000' AS DateTime), N'C001', N'BK0000003', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000009', CAST(N'2024-07-19T17:00:00.000' AS DateTime), CAST(N'2024-07-19T19:00:00.000' AS DateTime), N'C001', N'BK0000003', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000010', CAST(N'2024-07-26T17:00:00.000' AS DateTime), CAST(N'2024-07-26T19:00:00.000' AS DateTime), N'C001', N'BK0000003', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000011', CAST(N'2024-08-03T17:00:00.000' AS DateTime), CAST(N'2024-08-03T19:00:00.000' AS DateTime), N'C001', N'BK0000003', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000012', CAST(N'2024-06-11T13:00:00.000' AS DateTime), CAST(N'2024-06-11T15:00:00.000' AS DateTime), N'C001', N'BK0000004', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000013', CAST(N'2024-06-08T09:00:00.000' AS DateTime), CAST(N'2024-06-08T12:00:00.000' AS DateTime), N'C014', N'BK0000005', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000014', CAST(N'2024-07-09T09:00:00.000' AS DateTime), CAST(N'2024-07-09T12:00:00.000' AS DateTime), N'C014', N'BK0000006', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000015', CAST(N'2024-07-07T10:00:00.000' AS DateTime), CAST(N'2024-07-07T12:00:00.000' AS DateTime), N'C003', N'BK0000007', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000016', CAST(N'2024-07-05T12:00:00.000' AS DateTime), CAST(N'2024-07-05T14:00:00.000' AS DateTime), N'C003', N'BK0000008', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000017', CAST(N'2024-07-12T12:00:00.000' AS DateTime), CAST(N'2024-07-12T14:00:00.000' AS DateTime), N'C003', N'BK0000008', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000018', CAST(N'2024-07-19T12:00:00.000' AS DateTime), CAST(N'2024-07-19T14:00:00.000' AS DateTime), N'C003', N'BK0000008', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000019', CAST(N'2024-07-26T12:00:00.000' AS DateTime), CAST(N'2024-07-26T14:00:00.000' AS DateTime), N'C003', N'BK0000008', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000020', CAST(N'2024-08-02T12:00:00.000' AS DateTime), CAST(N'2024-08-02T14:00:00.000' AS DateTime), N'C003', N'BK0000008', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000021', CAST(N'2024-09-08T13:00:00.000' AS DateTime), CAST(N'2024-09-08T14:00:00.000' AS DateTime), N'C003', N'BK0000008', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000022', CAST(N'2024-08-16T12:00:00.000' AS DateTime), CAST(N'2024-08-16T14:00:00.000' AS DateTime), N'C003', N'BK0000008', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000023', CAST(N'2024-08-23T12:00:00.000' AS DateTime), CAST(N'2024-08-23T14:00:00.000' AS DateTime), N'C003', N'BK0000008', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000024', CAST(N'2024-08-30T12:00:00.000' AS DateTime), CAST(N'2024-08-30T14:00:00.000' AS DateTime), N'C003', N'BK0000008', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000025', CAST(N'2024-07-09T11:00:00.000' AS DateTime), CAST(N'2024-07-09T17:00:00.000' AS DateTime), N'C001', N'BK0000009', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000026', CAST(N'2024-07-09T14:00:00.000' AS DateTime), CAST(N'2024-07-09T16:00:00.000' AS DateTime), N'C001', N'BK0000010', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000027', CAST(N'2024-10-07T08:00:00.000' AS DateTime), CAST(N'2024-10-07T09:00:00.000' AS DateTime), N'C001', N'BK0000011', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000028', CAST(N'2024-08-03T17:00:00.000' AS DateTime), CAST(N'2024-08-03T19:00:00.000' AS DateTime), N'C004', N'BK0000012', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000029', CAST(N'2024-07-14T09:00:00.000' AS DateTime), CAST(N'2024-07-14T10:00:00.000' AS DateTime), N'C002', N'BK0000013', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000030', CAST(N'2024-07-13T09:00:00.000' AS DateTime), CAST(N'2024-07-13T10:00:00.000' AS DateTime), N'C002', N'BK0000014', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000031', CAST(N'2024-07-14T09:00:00.000' AS DateTime), CAST(N'2024-07-14T13:00:00.000' AS DateTime), N'C001', N'BK0000015', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000032', CAST(N'2024-07-13T07:00:00.000' AS DateTime), CAST(N'2024-07-13T09:00:00.000' AS DateTime), N'C007', N'BK0000016', 1)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000033', CAST(N'2024-07-14T07:00:00.000' AS DateTime), CAST(N'2024-07-14T09:00:00.000' AS DateTime), N'C007', N'BK0000017', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000034', CAST(N'2024-07-15T07:00:00.000' AS DateTime), CAST(N'2024-07-15T09:00:00.000' AS DateTime), N'C007', N'BK0000018', 1)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000035', CAST(N'2024-07-15T18:00:00.000' AS DateTime), CAST(N'2024-07-15T20:00:00.000' AS DateTime), N'C007', N'BK0000019', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000036', CAST(N'2024-07-14T15:00:00.000' AS DateTime), CAST(N'2024-07-14T17:00:00.000' AS DateTime), N'C001', N'BK0000020', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000037', CAST(N'2024-07-14T07:00:00.000' AS DateTime), CAST(N'2024-07-14T22:00:00.000' AS DateTime), N'C003', N'BK0000021', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S0000038', CAST(N'2024-07-15T12:00:00.000' AS DateTime), CAST(N'2024-07-15T13:00:00.000' AS DateTime), N'C005', N'BK0000022', NULL)
INSERT [dbo].[BookedSlot] ([slotID], [startTime], [endTime], [courtID], [bookingID], [isDelete]) VALUES (N'S1', CAST(N'1900-01-01T07:00:00.000' AS DateTime), CAST(N'1900-01-01T22:00:00.000' AS DateTime), N'C001', N'B1', NULL)
GO
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'B1', 0, 0, N'U0000027', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000002', 110000, 1, N'U0000008', CAST(N'2024-07-02T01:40:30.667' AS DateTime), 1, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000003', 560000, 2, N'U0000008', CAST(N'2024-07-02T01:42:39.990' AS DateTime), 3, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000004', 70000, 1, N'U0000002', CAST(N'2024-07-02T01:44:36.433' AS DateTime), 1, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000005', 1320000, 1, N'U0000008', CAST(N'2024-07-02T07:32:18.117' AS DateTime), 0, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000006', 1320000, 1, N'U0000008', CAST(N'2024-07-02T07:48:55.467' AS DateTime), 0, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000007', 60000, 1, N'U0000006', CAST(N'2024-07-02T08:06:09.583' AS DateTime), 0, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000008', 450000, 2, N'U0000008', CAST(N'2024-07-02T08:08:22.980' AS DateTime), 3, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000009', 210000, 1, N'U0000028', CAST(N'2024-07-08T10:21:10.887' AS DateTime), 0, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000010', 70000, 1, N'U0000028', CAST(N'2024-07-08T10:24:36.897' AS DateTime), 0, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000011', 35000, 1, N'U0000028', CAST(N'2024-07-09T22:28:20.730' AS DateTime), 1, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000012', 90000, 1, N'U0000028', CAST(N'2024-07-12T19:05:27.867' AS DateTime), 10, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000013', 40000, 1, N'U0000028', CAST(N'2024-07-12T19:10:01.743' AS DateTime), 1, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000014', 40000, 1, N'U0000028', CAST(N'2024-07-12T19:12:31.517' AS DateTime), 2, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000015', 140000, 1, N'U0000037', CAST(N'2024-07-12T21:17:56.533' AS DateTime), 1, 1)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000016', 140000, 1, N'U0000037', CAST(N'2024-07-12T22:18:53.080' AS DateTime), 0, 1)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000017', 140000, 1, N'U0000037', CAST(N'2024-07-12T22:19:34.490' AS DateTime), 0, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000018', 140000, 1, N'U0000037', CAST(N'2024-07-12T22:21:09.980' AS DateTime), 0, 1)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000019', 140000, 1, N'U0000037', CAST(N'2024-07-12T22:21:37.603' AS DateTime), 8, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000020', 70000, 1, N'U0000037', CAST(N'2024-07-12T23:19:46.207' AS DateTime), 1, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000021', 371250, 1, N'U0000037', CAST(N'2024-07-13T08:07:04.740' AS DateTime), 0, NULL)
INSERT [dbo].[Booking] ([bookingID], [amount], [bookingType], [userID], [bookingDate], [changeLog], [isDelete]) VALUES (N'BK0000022', 60000, 1, N'U0000037', CAST(N'2024-07-13T08:10:26.360' AS DateTime), 0, NULL)
GO
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C001', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F677a8215-83a0-4eb8-9c08-3f1f02252761?alt=media&token=e5f6e639-600f-401b-a259-11e374347b5f|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fe9b5d441-37e7-4a2e-b1ee-b52b21732717?alt=media&token=8318da1c-e57c-492b-a584-bb706e5085ba|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fde73cfb3-1260-4900-87cc-af2b009ccff9?alt=media&token=09c71dc9-7008-44a0-b339-16ba25c866f4|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F2062b4d8-623f-42b1-8f84-65e195c83377?alt=media&token=c164e88d-5f4e-4678-8a48-a046da76f3c1', N'B001', 35000, N'Sân cầu lông phố sáng tiện nghi, phục vụ tốt cho người chơi.', N'Sân cầu lông A', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C002', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F38e7dc6b-ed9b-43ad-abec-38949073a5d0?alt=media&token=d6011321-6405-4ce7-80a6-4a8f0c3a11dd|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fd87b6671-2eb6-4eb8-8478-2a48823da2e6?alt=media&token=5b3952a2-cd42-44db-a28f-5302e2f33d57|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Ffd39dc12-bef9-471a-adb7-fbe65f360983?alt=media&token=08b7332c-c02a-4904-89e5-3b3da9f05109|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fbe3521c1-2bf8-4799-a064-3f0cd7dad49b?alt=media&token=8f671410-0aa5-457c-ba80-3b9802866b38', N'B001', 40000, N'Sân cầu lông thi đấu chuyên nghiệp, đầy đủ trang thiết bị.', N'Sân cầu lông B', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C003', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F38e7dc6b-ed9b-43ad-abec-38949073a5d0?alt=media&token=d6011321-6405-4ce7-80a6-4a8f0c3a11dd|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fd87b6671-2eb6-4eb8-8478-2a48823da2e6?alt=media&token=5b3952a2-cd42-44db-a28f-5302e2f33d57|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Ffd39dc12-bef9-471a-adb7-fbe65f360983?alt=media&token=08b7332c-c02a-4904-89e5-3b3da9f05109|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fbe3521c1-2bf8-4799-a064-3f0cd7dad49b?alt=media&token=8f671410-0aa5-457c-ba80-3b9802866b38', N'B001', 30000, N'Sân cầu lông rộng rãi, không gian thoáng mát, thích hợp cho gia đình.', N'Sân cầu lông C', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C004', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F38e7dc6b-ed9b-43ad-abec-38949073a5d0?alt=media&token=d6011321-6405-4ce7-80a6-4a8f0c3a11dd|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fd87b6671-2eb6-4eb8-8478-2a48823da2e6?alt=media&token=5b3952a2-cd42-44db-a28f-5302e2f33d57|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Ffd39dc12-bef9-471a-adb7-fbe65f360983?alt=media&token=08b7332c-c02a-4904-89e5-3b3da9f05109|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fbe3521c1-2bf8-4799-a064-3f0cd7dad49b?alt=media&token=8f671410-0aa5-457c-ba80-3b9802866b38', N'B001', 45000, N'Sân cầu lông được trang bị đầy đủ ánh sáng và hệ thống thông gió tốt.', N'Sân cầu lông D', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C005', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fe0f0ad8b-d66e-4b90-9959-43d2742c78c8?alt=media&token=30655239-dec7-469d-a574-c713c4c813b7|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F7de05160-0cac-41bb-a463-5fb34a48a970?alt=media&token=b7d030d2-801d-4f15-bad6-86f1a2535694|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F21515f35-b2f3-438a-bc4f-90fba3a332e8?alt=media&token=e1c9bff3-b693-4f3e-972b-dba111cceff9|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Ff8c7b593-222f-4a30-ad73-da7abff567c1?alt=media&token=2d2a1569-e294-4e32-a393-e9ac75de9bfa', N'B002', 60000, N'Sân cầu lông đẳng cấp, dành cho các vận động viên chuyên nghiệp.', N'Sân cầu lông A', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C006', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F1792707b-591d-4400-b58e-44bf068e23fd?alt=media&token=087f30c8-63ff-4880-97b8-bb13515a3cd1|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fc0933691-d10e-4b42-9a21-e4ec190ab313?alt=media&token=73874f29-baa1-4acc-be0e-c14e00c8b8d2|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fa054bcfb-5b46-40bd-8811-fcd105f60642?alt=media&token=7e1daa8b-c767-4f9b-b427-a58267c5dfb6|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F13e6b343-1cae-40df-8b7c-6518b28d1135?alt=media&token=3187f329-ea77-4865-934f-c6fdea65b2b1', N'B002', 55000, N'Sân cầu lông phục vụ nhu cầu thư giãn và rèn luyện sức khỏe.', N'Sân cầu lông B', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C007', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F17295a89-e0ab-42e9-981a-3f91e04e96fe?alt=media&token=6b019960-743a-435d-aad6-26fea42eb71b|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fbf572d68-731c-456b-8259-fbd75b3af701?alt=media&token=095cabc7-f988-41ae-9039-52820e9d8782|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fadfdb1c4-44a7-4736-bf8a-2d30e02317b8?alt=media&token=7cc6c16f-6bd9-40de-800e-c9aa3db0c030|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F83e0eb34-b066-4ec6-aaf2-58cfc5e6adac?alt=media&token=61bb5046-c19d-4e4a-8e68-6e583f6a4e4c|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fce054f65-9847-47b3-aceb-7bcdb1cea8de?alt=media&token=e26f1745-8297-4738-b478-be2fdad00ba4|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F8a8113f7-69df-4058-9ca5-9f8c01c93fc3?alt=media&token=66f59608-2b4c-479b-a374-066bb11e1b44|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fde2cfead-7951-4723-b826-77adfddb2b96?alt=media&token=b34bace9-8a0e-49ae-bf85-ef161bce0d0e|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F2d6033e8-fb88-479e-a970-42be48e63856?alt=media&token=576f1adb-bf03-493d-930f-346ac7cdf930', N'B002', 70000, N'Sân cầu lông cao cấp với đầy đủ dịch vụ và tiện nghi.', N'Sân cầu lông C', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C008', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Ff6fc8c96-12a6-4933-afca-84a70e60d3d9?alt=media&token=0253c03b-01a1-4361-a999-7abe18c282aa|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F534f9b3f-87df-48d4-bf32-b93148753a81?alt=media&token=12d5a302-092f-42f1-9dae-50b49473b0de|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F38adc338-025b-47c0-ab6f-067f2cc9bf96?alt=media&token=e59003ab-8846-447c-8327-c17cbd004136|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F58d2bfe9-18da-4376-91f8-ef33d899005d?alt=media&token=8fa2f1a6-363a-4e62-a31d-3e82211bfd9c', N'B003', 50000, N'Sân cầu lông phù hợp cho cả những người mới bắt đầu và những vận động viên chuyên nghiệp.', N'Sân cầu lông A', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C009', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F6a28a925-ae47-4926-a6cc-b6a8d3e024ad?alt=media&token=a15b33e6-acd5-417c-910e-4867b42f26c2|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F762a710d-975a-4c9c-b650-ec2d1a1fe6b3?alt=media&token=6f00296a-b1ac-4ffb-9dbb-35f5c0b23d88|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F844ee35c-12a5-4bbe-8c6d-502e1ef2bee2?alt=media&token=2ca54e97-b229-4bbb-9772-e1a0e6058cc6|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fad83ed9b-e78c-4806-a17d-ca8fb1d0a42e?alt=media&token=ea4a63e4-08b2-4ea7-81e0-9f0c98779809', N'B003', 35000, N'Sân cầu lông với không gian thoáng đãng và tiện nghi.', N'Sân cầu lông B', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C010', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fa8746de9-206a-4e41-8de5-b84bcfdb23b3?alt=media&token=ec7eb8ca-14f2-45e8-9d09-29e42458d514|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F674d0f87-e587-40db-8c4a-a2852ee4bbd9?alt=media&token=7333502f-8648-4853-8d87-34e97dd6ee4a|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F96e05cd8-0429-41f2-86dc-3c4bb26c2a8a?alt=media&token=b21c2c3d-5bb8-4085-bb89-3d2ea9234f0e|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F3dea156f-465f-427e-8f8d-1311996bccb5?alt=media&token=7a7c5551-19f6-4b97-8269-b7140f3f3bf3', N'B003', 40000, N'Sân cầu lông đáp ứng mọi nhu cầu của người chơi, từ giải trí đến thi đấu.', N'Sân cầu lông C', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C011', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F941d7f46-4ee5-45eb-b980-f2fd88b90e3b?alt=media&token=793b43d6-5687-440b-a465-af111ea2dc72|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F12ca32f4-35c9-4ab4-898b-ca3124318640?alt=media&token=42ea67f8-157f-479c-9dcc-6e7c08ed0f44|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F6593bd77-b857-4e2b-9a2b-732fc8288179?alt=media&token=0a99a7a4-0ea4-4972-b2c2-f4ff61679ad3|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fa96e923c-0416-4cea-8f20-6271130d0a2d?alt=media&token=68e7a60d-f473-4992-bc04-41339b9df2dd', N'B003', 45000, N'Sân cầu lông phục vụ cho mọi đối tượng, từ trẻ em đến người già.', N'Sân cầu lông D', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C012', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fd4d262b7-b731-411f-947d-e84c7c745b22?alt=media&token=7505c3da-915d-48d8-9306-7d557e7292e0|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F1f88e6d9-4607-4c0e-aca6-c3c689a0f9f4?alt=media&token=33b365a7-0a1a-4cef-a569-3fc08f1e1f9f|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fcf2c2992-90d3-4379-af5c-340110d9c573?alt=media&token=132b99dc-cd7d-4db9-83a7-d64484920a2d|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fc572512a-a707-448f-af18-0ae599c6edf9?alt=media&token=bec517ba-3fd3-4550-a850-072d8e012793', N'B003', 38000, N'Sân cầu lông phù hợp cho các bạn trẻ yêu thích thể thao.', N'Sân cầu lông E', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C013', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F38e7dc6b-ed9b-43ad-abec-38949073a5d0?alt=media&token=d6011321-6405-4ce7-80a6-4a8f0c3a11dd|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fd87b6671-2eb6-4eb8-8478-2a48823da2e6?alt=media&token=5b3952a2-cd42-44db-a28f-5302e2f33d57|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Ffd39dc12-bef9-471a-adb7-fbe65f360983?alt=media&token=08b7332c-c02a-4904-89e5-3b3da9f05109|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fbe3521c1-2bf8-4799-a064-3f0cd7dad49b?alt=media&token=8f671410-0aa5-457c-ba80-3b9802866b38', N'B003', 42000, N'Sân cầu lông có không gian mở, phù hợp cho gia đình và bạn bè.', N'Sân cầu lông F', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C014', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F4a1094b2-e0a1-4abf-94df-5d86ff83681a?alt=media&token=524f396f-fae2-4fb1-a7c3-b520bfbcc5e1|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F12115add-27a2-40d2-bde6-c4a43f963100?alt=media&token=92986946-2229-4ff6-b316-33b999bb38be|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fdb6b9b4f-4cc7-46f5-9879-b48e90f330f6?alt=media&token=021ae4c9-8762-4ab4-91a7-96db6f67a24b|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fbce0fc91-5c6b-4aeb-a6f8-3b988fd48df7?alt=media&token=aa1f0879-3717-4334-a3bd-b9999a684301', N'B004', 55000, N'Sân cầu lông rộng rãi với đầy đủ thiết bị và ánh sáng tự nhiên.', N'Sân cầu lông A', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C015', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fccbf1558-ac08-4119-8d87-26c43b28ce36?alt=media&token=b0e210e6-d8cd-4602-9a14-d6cadf4f54d6|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fbee9c932-3692-4177-b926-8021edebcdbf?alt=media&token=5efead18-9030-4812-947c-04ac7fd12bee|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Ffb69e56a-b887-4f6f-9f80-6c72814bafe3?alt=media&token=203377f3-f7fd-46d9-ba6e-3d682ee78c1d|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F6ac14cc2-101f-414c-8736-13b86e19a7fe?alt=media&token=848cd917-012f-4153-b22d-86f127e72fd0', N'B004', 60000, N'Sân cầu lông dành cho các cuộc thi chuyên nghiệp và huấn luyện viên.', N'Sân cầu lông B', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C016', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F0da06a47-a5e8-4f54-88a2-45f9e7d752d6?alt=media&token=bbc8983d-9cb2-4fec-b43d-f2583c9eda17|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F45131afc-5202-4c30-b879-c30502a50388?alt=media&token=0ae3f17c-2912-4a3a-bea6-5fbc68e8e6a3|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F07b13b66-a4b2-46c2-8153-3ba98659e2fc?alt=media&token=41c79802-bc21-419f-a5a1-7ee964883c26|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F90b87f27-73a2-4776-93cc-0d1921b9e285?alt=media&token=10609efe-4ac4-485d-8a45-7afae815aadc', N'B004', 45000, N'Sân cầu lông tiện nghi với không gian lý tưởng để rèn luyện sức khỏe.', N'Sân cầu lông C', 1)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C017', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F6c1ed4d6-098b-45da-bf3b-417787b02baa?alt=media&token=5bb7d2c5-09c1-4295-ac2c-f3b897f8c030|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F16bb6df7-3ba7-4b12-ac98-915179716215?alt=media&token=939b050b-6bc4-4808-9ae1-984e3a91722b|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F885bcef1-9aa1-468b-b884-6413e3089f25?alt=media&token=dfe0817f-721d-48a9-87a4-30d7133d60e1|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fb48ff5b9-4453-4fab-b74a-8b49eefc3129?alt=media&token=4e3fbe65-f80d-4823-a866-af1c349ab658', N'B005', 40000, N'Sân cầu lông phục vụ cho mọi nhu cầu, từ gia đình đến bạn bè.', N'Sân cầu lông A', 0)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C018', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F5eea5e72-44aa-4281-af95-1e1d1fb7a118?alt=media&token=b3776eed-cd14-4155-9cc1-da32e4d1ce0d|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F3bb4c380-2947-4288-ae2d-8c18fa3ac271?alt=media&token=ad393093-a01f-450a-8b10-09044354b01e|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fd61d818b-8c69-472c-8c30-0eb514f3d144?alt=media&token=503573fa-ff74-4339-b05b-db73d3e76221', N'B005', 45000, N'Sân cầu lông đáp ứng mọi yêu cầu về chất lượng và dịch vụ.', N'Sân cầu lông B', 0)
INSERT [dbo].[Court] ([courtID], [courtImg], [branchID], [price], [description], [courtName], [courtStatus]) VALUES (N'C019', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fb5cfdaaa-e964-4de6-993d-b66a3b8003f5?alt=media&token=69ade14d-9d30-4bf5-b71a-a2fcd6938bb0|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F3a92294c-fcd8-4e8e-acbf-461ee6dfd00e?alt=media&token=fc73599b-74b1-44f5-965f-cef7da5ba1ab|https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Ffa27607f-8532-443d-bf65-5527976b971f?alt=media&token=e4c731e7-d06e-4a87-a80e-ea18a68de90e', N'B005', 35000, N'Sân cầu lông phù hợp cho mọi đối tượng từ người mới chơi đến người chuyên nghiệp.', N'Sân cầu lông C', 0)
GO
INSERT [dbo].[CourtBranch] ([branchID], [location], [branchName], [branchPhone], [branchImg], [branchStatus], [mapUrl]) VALUES (N'B001', N'Bà Rịa - Vũng Tàu', N'Sân cầu lông Vũng Tàu', N'0987654321', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F65aab25c-9cfc-4c14-9f2a-60581602a35c?alt=media&token=0f4232c4-20b4-43b0-ae4b-d205cfb78436', 1, N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3916.9443900204574!2d106.87432764457839!3d10.96757020000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174ddf13a55ec25:0x662ef71599c3d17!2zU8OibiBj4bqndSBsw7RuZyBOaOG6rXQgVGjDoG5o!5e0!3m2!1sen!2s!4v1720368371037!5m2!1sen!2s')
INSERT [dbo].[CourtBranch] ([branchID], [location], [branchName], [branchPhone], [branchImg], [branchStatus], [mapUrl]) VALUES (N'B002', N'Hồ Chí Minh', N'Sân cầu lông Quận 1', N'0976543210', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fa77030fd-9095-4bba-ba2d-426d0e42b806?alt=media&token=34f2e27f-d552-48c9-8b7c-33eaaef1e876', 1, N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3916.8815686864264!2d106.89844363488771!3d10.972311000000007!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174dda1621b4d5f:0x22bfdc5082afbeb6!2sDuc Thinh Badminton Club!5e0!3m2!1sen!2s!4v1720368396794!5m2!1sen!2s')
INSERT [dbo].[CourtBranch] ([branchID], [location], [branchName], [branchPhone], [branchImg], [branchStatus], [mapUrl]) VALUES (N'B003', N'Hà Nội', N'Sân cầu lông Hoàn Kiếm', N'0912345678', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F1fd6a274-af67-4fa7-b945-a78c6438ac1c?alt=media&token=95306da9-170f-4707-8dfc-6dafd624a62a', 1, N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3917.9602806219896!2d106.90020523488771!3d10.890623200000002!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174df61447a8da1:0x184f54e5efde4168!2zU8OibiBj4bqndSBsw7RuZyBQaMaw4bubYyBUw6Ju!5e0!3m2!1sen!2s!4v1720368420820!5m2!1sen!2s')
INSERT [dbo].[CourtBranch] ([branchID], [location], [branchName], [branchPhone], [branchImg], [branchStatus], [mapUrl]) VALUES (N'B004', N'Đà Nẵng', N'Sân cầu lông Đà Nẵng', N'0901234567', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fed4976c4-1759-49d5-b329-52bb1ae0c078?alt=media&token=62882de4-9b79-437d-a27c-99c5d100acf6', 1, N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3917.1275711519697!2d106.85337103488773!3d10.953734899999994!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174df1214344147:0x59ef30d1ff880c96!2zU8OibiBD4bqndSDEkOG7iW5oIENhbw!5e0!3m2!1sen!2s!4v1720368478338!5m2!1sen!2s')
INSERT [dbo].[CourtBranch] ([branchID], [location], [branchName], [branchPhone], [branchImg], [branchStatus], [mapUrl]) VALUES (N'B005', N'Cần Thơ', N'Sân cầu lông Cần Thơ', N'0934567890', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F33f335c1-e11a-45bc-bb17-a8923edd20cb?alt=media&token=f5806297-a731-4c35-b6be-0ff2583f3209', 0, N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3917.1275711519697!2d106.85337103488773!3d10.953734899999994!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174dd808bc444ed:0x81e9374266d93fe!2zU8OibiBD4bqndSBMw7RuZyBBbmggSGnhur91!5e0!3m2!1sen!2s!4v1720368515134!5m2!1sen!2s')
INSERT [dbo].[CourtBranch] ([branchID], [location], [branchName], [branchPhone], [branchImg], [branchStatus], [mapUrl]) VALUES (N'B006', N'Biên Hòa', N'Sân Cầu Lông Chí Long', N'0977300916', N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F3eaa0026-1a00-4d7f-b275-7468b3025102?alt=media&token=475abc0c-6e1c-4304-9897-2f9895083a06', 0, N'null')
GO
INSERT [dbo].[Discount] ([discountID], [amount], [proportion], [isDelete]) VALUES (N'D001', 100000, 5, NULL)
INSERT [dbo].[Discount] ([discountID], [amount], [proportion], [isDelete]) VALUES (N'D002', 200000, 10, NULL)
GO
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000001', 5, N'Sân bóng rộng rãi và đầy đủ tiện nghi, phục vụ tốt cho các trận đấu.', N'U0000001', N'B001', CAST(N'2024-06-11T01:31:27.513' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000002', 4, N'Giá cả hợp lý, không gian sân bóng rộng và thoáng mát.', N'U0000002', N'B002', CAST(N'2024-06-22T01:31:27.513' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000003', 3, N'Sân bóng không được bảo trì tốt, gây khó chịu khi chơi.', N'U0000003', N'B003', CAST(N'2024-06-23T01:31:27.513' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000004', 2, N'Nhân viên phục vụ không nhiệt tình, thiếu chuyên nghiệp.', N'U0000004', N'B004', CAST(N'2024-06-08T01:31:27.513' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000005', 5, N'Vị trí thuận lợi, dễ dàng di chuyển vào cuối tuần.', N'U0000005', N'B005', CAST(N'2024-06-19T01:31:27.513' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000006', 4, N'Không gian sân bóng rộng và sạch sẽ, phục vụ tốt cho các đội chơi.', N'U0000006', N'B001', CAST(N'2024-06-17T01:31:27.513' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000007', 3, N'Giá cả hơi cao so với chất lượng sân bóng.', N'U0000007', N'B002', CAST(N'2024-06-11T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000008', 1, N'Sân bóng quá đông vào các buổi chiều cuối tuần, không thoải mái cho việc chơi.', N'U0000008', N'B003', CAST(N'2024-06-10T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000009', 2, N'Không gian sân bóng hẹp và không có ánh sáng đủ vào ban đêm.', N'U0000009', N'B004', CAST(N'2024-06-15T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000010', 4, N'Sân bóng đẹp và rộng rãi, phù hợp cho các trận đấu.', N'U0000010', N'B005', CAST(N'2024-07-02T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000011', 3, N'Nhân viên không thân thiện và không giải quyết thắc mắc của khách hàng nhanh chóng.', N'U0000011', N'B001', CAST(N'2024-06-25T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000012', 5, N'Dịch vụ tốt, giá cả hợp lý và sân bóng luôn sạch sẽ.', N'U0000012', N'B002', CAST(N'2024-06-23T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000013', 2, N'Nhân viên phục vụ không nhiệt tình và không chuyên nghiệp.', N'U0000013', N'B003', CAST(N'2024-07-02T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000014', 4, N'Sân bóng sạch sẽ và thoáng mát vào ban đêm, phục vụ tốt cho các trận đấu.', N'U0000014', N'B004', CAST(N'2024-06-29T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000015', 3, N'Không gian chơi hẹp và ồn ào quá mức, không thoải mái cho các trận đấu lớn.', N'U0000015', N'B005', CAST(N'2024-06-18T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000016', 1, N'Không có chỗ đậu xe gần sân, rất bất tiện khi đi chơi bóng.', N'U0000001', N'B001', CAST(N'2024-06-29T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000017', 5, N'Trung tâm có nhiều sân chơi, phù hợp cho nhiều nhóm lớn.', N'U0000002', N'B002', CAST(N'2024-06-10T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000018', 4, N'Giá cả hợp lý, nhân viên nhiệt tình và sân bóng luôn được bảo trì tốt.', N'U0000003', N'B003', CAST(N'2024-06-23T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000019', 3, N'Sân bóng không được phẳng lặng, gây khó chơi cho các trận đấu.', N'U0000004', N'B004', CAST(N'2024-06-12T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000020', 2, N'Không có dịch vụ hỗ trợ cho người mới chơi, thiếu tiện nghi.', N'U0000005', N'B005', CAST(N'2024-06-18T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000021', 5, N'Địa điểm gần nhà, tiện lợi cho việc luyện tập hàng ngày.', N'U0000006', N'B001', CAST(N'2024-06-28T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000022', 3, N'Không gian sân bóng hơi chật và không phù hợp cho các trận đấu lớn.', N'U0000007', N'B002', CAST(N'2024-06-17T01:31:27.517' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000023', 4, N'Giá cả hợp lý và nhân viên phục vụ nhanh chóng, hiệu quả.', N'U0000008', N'B003', CAST(N'2024-06-06T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000024', 2, N'Nhân viên không thân thiện và không nhiệt tình trong phục vụ.', N'U0000009', N'B004', CAST(N'2024-06-22T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000025', 5, N'Vị trí thuận lợi và sân bóng luôn được bảo trì sạch sẽ.', N'U0000010', N'B005', CAST(N'2024-06-22T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000026', 4, N'Sân bóng rộng và đáp ứng đủ yêu cầu cho các trận đấu.', N'U0000011', N'B001', CAST(N'2024-06-06T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000027', 3, N'Giá cả hơi cao so với chất lượng sân bóng.', N'U0000012', N'B002', CAST(N'2024-06-15T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000028', 1, N'Sân bóng quá đông vào các buổi chiều cuối tuần, không thoải mái cho việc chơi.', N'U0000013', N'B003', CAST(N'2024-06-12T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000029', 2, N'Không gian sân bóng hẹp và không có ánh sáng đủ vào ban đêm.', N'U0000014', N'B004', CAST(N'2024-06-06T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000030', 4, N'Sân bóng đẹp và rộng rãi, phù hợp cho các trận đấu.', N'U0000015', N'B005', CAST(N'2024-06-22T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000031', 3, N'Nhân viên không thân thiện và không giải quyết thắc mắc của khách hàng nhanh chóng.', N'U0000001', N'B001', CAST(N'2024-06-29T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000032', 5, N'Dịch vụ tốt, giá cả hợp lý và sân bóng luôn sạch sẽ.', N'U0000002', N'B002', CAST(N'2024-06-30T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000033', 2, N'Nhân viên phục vụ không nhiệt tình và không chuyên nghiệp.', N'U0000003', N'B003', CAST(N'2024-06-16T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000034', 4, N'Sân bóng sạch sẽ và thoáng mát vào ban đêm, phục vụ tốt cho các trận đấu.', N'U0000004', N'B004', CAST(N'2024-06-04T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000035', 3, N'Không gian chơi hẹp và ồn ào quá mức, không thoải mái cho các trận đấu lớn.', N'U0000005', N'B005', CAST(N'2024-06-14T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000036', 1, N'Không có chỗ đậu xe gần sân, rất bất tiện khi đi chơi bóng.', N'U0000006', N'B001', CAST(N'2024-06-06T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000037', 5, N'Trung tâm có nhiều sân chơi, phù hợp cho nhiều nhóm lớn.', N'U0000007', N'B002', CAST(N'2024-06-19T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000038', 4, N'Giá cả hợp lý, nhân viên nhiệt tình và sân bóng luôn được bảo trì tốt.', N'U0000008', N'B003', CAST(N'2024-06-25T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000039', 3, N'Sân bóng không được phẳng lặng, gây khó chơi cho các trận đấu.', N'U0000009', N'B004', CAST(N'2024-06-26T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000040', 2, N'Không có dịch vụ hỗ trợ cho người mới chơi, thiếu tiện nghi.', N'U0000010', N'B005', CAST(N'2024-06-21T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000041', 5, N'Địa điểm gần nhà, tiện lợi cho việc luyện tập hàng ngày.', N'U0000011', N'B001', CAST(N'2024-06-08T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000042', 3, N'Không gian sân bóng hơi chật và không phù hợp cho các trận đấu lớn.', N'U0000012', N'B002', CAST(N'2024-06-20T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000043', 4, N'Giá cả hợp lý và nhân viên phục vụ nhanh chóng, hiệu quả.', N'U0000013', N'B003', CAST(N'2024-06-04T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000044', 2, N'Nhân viên không thân thiện và không nhiệt tình trong phục vụ.', N'U0000014', N'B004', CAST(N'2024-06-08T01:31:27.520' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000045', 5, N'Vị trí thuận lợi và sân bóng luôn được bảo trì sạch sẽ.', N'U0000015', N'B005', CAST(N'2024-06-15T01:31:27.523' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000046', 4, N'Sân bóng rộng và đáp ứng đủ yêu cầu cho các trận đấu.', N'U0000001', N'B001', CAST(N'2024-06-17T01:31:27.523' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000047', 3, N'Giá cả hơi cao so với chất lượng sân bóng.', N'U0000002', N'B002', CAST(N'2024-07-02T01:31:27.523' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000048', 1, N'Sân bóng quá đông vào các buổi chiều cuối tuần, không thoải mái cho việc chơi.', N'U0000003', N'B003', CAST(N'2024-06-14T01:31:27.523' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000049', 2, N'Không gian sân bóng hẹp và không có ánh sáng đủ vào ban đêm.', N'U0000004', N'B004', CAST(N'2024-06-15T01:31:27.523' AS DateTime), NULL)
INSERT [dbo].[Feedback] ([feedbackID], [rating], [content], [userID], [branchID], [period], [isDelete]) VALUES (N'F0000050', 4, N'Sân bóng đẹp và rộng rãi, phù hợp cho các trận đấu.', N'U0000005', N'B005', CAST(N'2024-06-13T01:31:27.523' AS DateTime), NULL)
GO
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000001', N'U0000008', CAST(N'2024-07-02T01:40:30.623' AS DateTime), N'BK0000002', 1, 2640000, N'14488493')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000002', N'U0000008', CAST(N'2024-07-02T01:42:39.980' AS DateTime), N'BK0000003', 2, 560000, N'14488494')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000003', N'U0000002', CAST(N'2024-07-02T01:44:36.423' AS DateTime), N'BK0000004', 1, 560000, N'14488496')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000004', N'U0000008', CAST(N'2024-07-02T07:32:18.083' AS DateTime), N'BK0000005', 1, 1320000, N'14488563')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000005', N'U0000008', CAST(N'2024-07-02T07:48:55.440' AS DateTime), N'BK0000006', 1, 1320000, N'14488565')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000006', N'U0000006', CAST(N'2024-07-02T08:06:09.573' AS DateTime), N'BK0000007', 2, 60000, N'14488568')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000007', N'U0000008', CAST(N'2024-07-02T08:08:22.970' AS DateTime), N'BK0000008', 1, 480000, N'14488570')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000008', N'U0000028', CAST(N'2024-07-08T10:21:10.833' AS DateTime), N'BK0000009', 1, 210000, N'14498801')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000009', N'U0000028', CAST(N'2024-07-08T10:24:36.887' AS DateTime), N'BK0000010', 1, 70000, N'14498810')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000010', N'U0000028', CAST(N'2024-07-09T22:27:43.177' AS DateTime), NULL, 1, 100000, N'14502986')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000011', N'U0000037', CAST(N'2024-07-12T21:15:55.463' AS DateTime), NULL, 1, 100000, N'14509532')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000012', N'U0000037', CAST(N'2024-07-12T00:00:00.000' AS DateTime), NULL, 2, 175000, N'4083642618')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000013', N'U0000037', CAST(N'2024-07-13T08:07:04.717' AS DateTime), N'BK0000021', 1, 60000, N'14509902')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000014', N'U0000037', CAST(N'2024-07-13T08:08:00.187' AS DateTime), N'BK0000021', 1, 311250, N'14509903')
INSERT [dbo].[Payment] ([paymentID], [userID], [date], [bookingID], [method], [amount], [transactionId]) VALUES (N'P0000015', N'U0000037', CAST(N'2024-07-13T00:00:00.000' AS DateTime), NULL, 2, 100000, N'4083785788')
GO
INSERT [dbo].[Role] ([roleID], [role]) VALUES (N'R001', N'Admin')
INSERT [dbo].[Role] ([roleID], [role]) VALUES (N'R002', N'Staff')
INSERT [dbo].[Role] ([roleID], [role]) VALUES (N'R003', N'Customer')
GO
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000001', N'NguyenPTT16', N'3a9f16a9d5de812a26da68380c09db1cabae0dc8c0c04ddfcce88c061ace1baa', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAwMSIsIlVzZXJuYW1lIjoiTmd1eWVuUFRUMTYiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjUwOSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.PVjxtN0L7yob6Z2Mhj4BXc3bZ-QZsIg8VpJ5KsOxuv4', CAST(N'2024-07-01T23:33:29.613' AS DateTime), 10000, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000002', N'ThuPM87', N'60524134-add', NULL, N'R003', NULL, NULL, 100000, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000003', N'ThaiDV35', N'ddcfe47829289a0fda5ec98d176ae99c3de35605d559b38e6f61b684c6afb453', NULL, N'R003', NULL, NULL, 10000, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000004', N'PhatPT98', N'64964cc5-12f', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAwNCIsIlVzZXJuYW1lIjoiUGhhdFBUOTgiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjUyMCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.AmGmcjYX9I80zCLIqDDsXpn0bRunO508MiRuv7YJZx4', CAST(N'2024-07-01T23:33:40.050' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000005', N'ThanhDH81', N'92a214c2-8a5', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAwNSIsIlVzZXJuYW1lIjoiVGhhbmhESDgxIiwiU3RhdHVzIjoiRmFsc2UiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJSMDAzIiwiUm9sZSI6IlIwMDMiLCJleHAiOjE3MTk4NTI1MjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIn0.oEm1X-HuY-k5hmHenJUb8_oXc8x2pDVJxMQnHcAQC-4', CAST(N'2024-07-01T23:33:44.010' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000006', N'LuatLP95', N'e6791e2e-784', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAwNiIsIlVzZXJuYW1lIjoiTHVhdExQOTUiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjUyNywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.XhE60D0KyAtLWiiSKANVTTRUR5YSP-IEliIbdR1oZ7o', CAST(N'2024-07-01T23:33:47.380' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000007', N'NhungPT59', N'5aaaf365-a33', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAwNyIsIlVzZXJuYW1lIjoiTmh1bmdQVDU5IiwiU3RhdHVzIjoiRmFsc2UiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJSMDAzIiwiUm9sZSI6IlIwMDMiLCJleHAiOjE3MTk4NTI1MzEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIn0.GmyIqtbw7xFdAJr4_cAG92ci15BF3S1pmYPAmfT_b5I', CAST(N'2024-07-01T23:33:51.400' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000008', N'TriTT68', N'aad62cd2-8e2', NULL, N'R003', NULL, NULL, 30000, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000009', N'HoangNV21', N'835ccf5c-4d4', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAwOSIsIlVzZXJuYW1lIjoiSG9hbmdOVjIxIiwiU3RhdHVzIjoiRmFsc2UiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJSMDAzIiwiUm9sZSI6IlIwMDMiLCJleHAiOjE3MTk4NTI1MzgsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIn0.vxd9Woy6FzCVW1SxSTiZx02ugtZwDNlHawlCSrSvEd0', CAST(N'2024-07-01T23:33:58.037' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000010', N'TriTT66', N'f7e872b9-237', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAxMCIsIlVzZXJuYW1lIjoiVHJpVFQ2NiIsIlN0YXR1cyI6IkZhbHNlIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUjAwMyIsIlJvbGUiOiJSMDAzIiwiZXhwIjoxNzE5ODUyNTQxLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyJ9.Q7Oa7zGUUCUKr7mL8jX-i-a0gl65gGnX7F2t929cHCs', CAST(N'2024-07-01T23:34:01.410' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000011', N'HueTTT25', N'5e85ba00-d4b', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAxMSIsIlVzZXJuYW1lIjoiSHVlVFRUMjUiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjU0NCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.EfZj3wFR4XpmPzaNbJwXpVzYuTBsgE8N5kkkKOe7ESc', CAST(N'2024-07-01T23:34:04.793' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000012', N'NguyenPTT63', N'339b6545-275', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAxMiIsIlVzZXJuYW1lIjoiTmd1eWVuUFRUNjMiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjU3OSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.fAEievjlYC-JREQWhUaLj87Y00YzYeBhEUWIvdy0oQQ', CAST(N'2024-07-01T23:34:39.500' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000013', N'ThuPM03', N'48b7cd7b-995', NULL, N'R003', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000014', N'ThaiDV88', N'c0072294-ad5', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAxNCIsIlVzZXJuYW1lIjoiVGhhaURWODgiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjU4OCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.e8qosnefybiIPNA960ldricei9wPSIdsiCx2T_5PzDs', CAST(N'2024-07-01T23:34:48.010' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000015', N'PhatPT77', N'817cfad7-59b', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAxNSIsIlVzZXJuYW1lIjoiUGhhdFBUNzciLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjU5MSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.6n8M_ZcV6vS96-6Wm3HmaZJic1zOxNkTrvG0AYsh4tY', CAST(N'2024-07-01T23:34:51.373' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000016', N'ThanhDH39', N'51ecca94-e5c', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAxNiIsIlVzZXJuYW1lIjoiVGhhbmhESDM5IiwiU3RhdHVzIjoiRmFsc2UiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJSMDAzIiwiUm9sZSI6IlIwMDMiLCJleHAiOjE3MTk4NTI1OTQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIn0.axBEwEziBUXkW256zOrbEPM_4RUvRHoBhBzYHqZzQyc', CAST(N'2024-07-01T23:34:54.673' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000017', N'LuatLP83', N'a5c9ea43-790', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAxNyIsIlVzZXJuYW1lIjoiTHVhdExQODMiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjU5OCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.kjnUkCf9X595ShXuiG27k0tjL7GlsTNrKkipoH93hFM', CAST(N'2024-07-01T23:34:58.887' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000018', N'NhungPT99', N'97368401-40a', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAxOCIsIlVzZXJuYW1lIjoiTmh1bmdQVDk5IiwiU3RhdHVzIjoiRmFsc2UiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJSMDAzIiwiUm9sZSI6IlIwMDMiLCJleHAiOjE3MTk4NTI2MDIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIn0.1vIZHl_2BFGEfXXwqGvM67RHKg7OCubD8UP1J4sBfW8', CAST(N'2024-07-01T23:35:02.770' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000019', N'TriTT94', N'c7405a5f-89e', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAxOSIsIlVzZXJuYW1lIjoiVHJpVFQ5NCIsIlN0YXR1cyI6IkZhbHNlIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUjAwMyIsIlJvbGUiOiJSMDAzIiwiZXhwIjoxNzE5ODUyNjA2LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyJ9.64hRr2K7AlHAnhmo3SzKATLNuN_Q3wHN0xcr0JkoW6g', CAST(N'2024-07-01T23:35:06.927' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000020', N'HoangNV55', N'96a4ec8f-d6f', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAyMCIsIlVzZXJuYW1lIjoiSG9hbmdOVjU1IiwiU3RhdHVzIjoiRmFsc2UiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJSMDAzIiwiUm9sZSI6IlIwMDMiLCJleHAiOjE3MTk4NTI2MTAsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIn0.1RsXAFeF55UCp2tILMHZztC0o61V9PJA5QsozrfySJw', CAST(N'2024-07-01T23:35:10.243' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000021', N'TriTT53', N'90cae1b8-cf5', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAyMSIsIlVzZXJuYW1lIjoiVHJpVFQ1MyIsIlN0YXR1cyI6IkZhbHNlIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUjAwMyIsIlJvbGUiOiJSMDAzIiwiZXhwIjoxNzE5ODUyNjEzLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyJ9.hirdIRnndx5hlez8rijS_A3vttts0AhgyTKNFTPvXzY', CAST(N'2024-07-01T23:35:13.577' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000022', N'HueTTT90', N'4dfccedb-0ce', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAyMiIsIlVzZXJuYW1lIjoiSHVlVFRUOTAiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjYxNywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.6cxv-M0902dJ2-LJ_JnzeqPsPRdSyP5dFDaK-wfSKhI', CAST(N'2024-07-01T23:35:17.910' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000023', N'TienNQ40', N'6d6fd403-77c', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAyMyIsIlVzZXJuYW1lIjoiVGllbk5RNDAiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcxOTg1MjYyMSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.uQ1OY_KaXBvAC5p9TxHkDArEMhZpd4XVLfLR0gzQcKw', CAST(N'2024-07-01T23:35:21.897' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000024', N'DatLN26', N'829b3fd5-ec3', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAyNCIsIlVzZXJuYW1lIjoiRGF0TE4yNiIsIlN0YXR1cyI6IkZhbHNlIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUjAwMyIsIlJvbGUiOiJSMDAzIiwiZXhwIjoxNzE5ODUyNjI1LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyJ9.QTob5PEEyRUuPbIPEWnnS19d69vJNXCFhnfggaataPU', CAST(N'2024-07-01T23:35:25.687' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000025', N'DatPT33', N'c5e3bb8f-223', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAyNSIsIlVzZXJuYW1lIjoiRGF0UFQzMyIsIlN0YXR1cyI6IkZhbHNlIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUjAwMyIsIlJvbGUiOiJSMDAzIiwiZXhwIjoxNzE5ODUyNjI4LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyJ9.kIe8X7S6QECF9ZQG2mi2G4MG9i0NnDfEP0OAQXEnwhU', CAST(N'2024-07-01T23:35:28.980' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000026', N'NhatVV11', N'7f0736f1-995', NULL, N'R003', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000027', N'admin', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', NULL, N'R001', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000028', N'duccoi', N'173af653133d964edfc16cafe0aba33c8f500a07f3ba3f81943916910c257705', NULL, N'R003', NULL, NULL, 9905000, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000029', N'staff', N'75bdebd45687b37cfdd178dd5c7084686d22d56855e70f92a27dd7bf1a04525d', NULL, N'R002', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000030', N'', N'', NULL, N'R003', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000031', N'demo', N'Duc0977300916@', NULL, N'R003', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000032', N'minhduccoi', N'Duc0977300916@', NULL, N'R001', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000033', N'minhduccoi23', N'Duc0977300916@', NULL, N'R001', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000034', N'minhđucoi123124', N'Duc0977300916@', NULL, N'R001', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000035', N'minhduccoi123124', N'Duc0977300916@', NULL, N'R003', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000036', N'duccoaiwe12', N'Duc0977300916@', NULL, N'R003', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000037', NULL, N'78f90b3fae1423adf001d44d4ae4601c7d43daa1f3433eb4a7722d91dc753199', NULL, N'R003', NULL, NULL, 45000, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000038', N'ngoc', N'78f90b3fae1423adf001d44d4ae4601c7d43daa1f3433eb4a7722d91dc753199', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAzOCIsIlVzZXJuYW1lIjoibmdvYyIsIlN0YXR1cyI6IkZhbHNlIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUjAwMyIsIlJvbGUiOiJSMDAzIiwiZXhwIjoxNzIwODAyODg0LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjUyNjYvIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyJ9.GFRZe6XER5B_gK8clGwet8rBC2D1RG9rSyZcF2zySFo', CAST(N'2024-07-12T23:33:04.423' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000039', N'ngoc2', N'78f90b3fae1423adf001d44d4ae4601c7d43daa1f3433eb4a7722d91dc753199', NULL, N'R003', N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJVMDAwMDAzOSIsIlVzZXJuYW1lIjoibmdvYzIiLCJTdGF0dXMiOiJGYWxzZSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlIwMDMiLCJSb2xlIjoiUjAwMyIsImV4cCI6MTcyMDgwMjk2NywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjY2LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI2Ni8ifQ.gviFhKopoI4W9XGAt2HMEtr3kTl3Jfe46977GTj_DTk', CAST(N'2024-07-12T23:34:27.760' AS DateTime), 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000040', N'ngoc3', N'78f90b3fae1423adf001d44d4ae4601c7d43daa1f3433eb4a7722d91dc753199', NULL, N'R003', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([userID], [userName], [password], [branchID], [roleID], [token], [actionPeriod], [balance], [accessFail], [lastFail], [activeStatus]) VALUES (N'U0000041', N'demo12345', N'75bdebd45687b37cfdd178dd5c7084686d22d56855e70f92a27dd7bf1a04525d', NULL, N'R003', NULL, NULL, 0, 0, CAST(N'1900-01-01T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000001', N'Phan Thị Thảo', N'Nguyên', N'NguyenPTT16804@yahoo.com', N'0201060943', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000002', N'Phạm Minh', N'Thư', N'ThuPM87572@yahoo.com', N'0293881846', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000003', N'Đặng Văn', N'Thái', N'ThaiDV35610@gmail.com', N'0903157204', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000004', N'Phan Trung', N'Phát', N'PhatPT98769@outlook.com', N'0367038081', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000005', N'Đặng Hồng', N'Thanh', N'ThanhDH81781@gmail.com', N'0961082840', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000006', N'Lê Pháp', N'Luật', N'LuatLP95050@outlook.com', N'0824708851', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000007', N'Phạm Thùy', N'Nhung', N'NhungPT59368@outlook.com', N'0820866631', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000008', N'Trần Tài', N'Trí', N'TriTT68811@yahoo.com', N'0376086631', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000009', N'Nguyễn Việt', N'Hoàng', N'HoangNV21446@outlook.com', N'0306258019', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000010', N'Trần Tài', N'Trí', N'TriTT66874@yahoo.com', N'0262919590', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000011', N'Trần Thị Thu', N'Huệ', N'HueTTT25223@outlook.com', N'0311496483', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000012', N'Phan Thị Thảo', N'Nguyên', N'NguyenPTT63019@gmail.com', N'0202807589', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000013', N'Phạm Minh', N'Thư', N'ThuPM03718@gmail.com', N'0363168967', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000014', N'Đặng Văn', N'Thái', N'ThaiDV88409@yahoo.com', N'0966449982', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000015', N'Phan Trung', N'Phát', N'PhatPT77034@outlook.com', N'0263887251', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000016', N'Đặng Hồng', N'Thanh', N'ThanhDH39827@gmail.com', N'0916361684', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000017', N'Lê Pháp', N'Luật', N'LuatLP83800@yahoo.com', N'0303258783', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000018', N'Phạm Thùy', N'Nhung', N'NhungPT99431@outlook.com', N'0359367625', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000019', N'Trần Tài', N'Trí', N'TriTT94800@yahoo.com', N'0202846787', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000020', N'Nguyễn Việt', N'Hoàng', N'HoangNV55646@yahoo.com', N'0866987219', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000021', N'Trần Tài', N'Trí', N'TriTT53739@yahoo.com', N'0353559652', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000022', N'Trần Thị Thu', N'Huệ', N'HueTTT90532@outlook.com', N'0243905446', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000023', N'Nguyễn Quyết', N'Tiến', N'TienNQ40735@outlook.com', N'0388666093', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000024', N'Lê Ngọc', N'Đạt', N'DatLN26400@outlook.com', N'0817614855', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000025', N'Phạm Tiến', N'Đạt', N'DatPT33487@gmail.com', N'0365045156', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000026', N'Võ Văn', N'Nhất', N'NhatVV11428@outlook.com', N'0891631388', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000027', N'Admin', N'Admin', N'duc@gmail.com', N'0977300914', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000028', N'Đặng Minh', N'Đức', N'abc@gmail.com', N'0900000000', NULL, N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2Fdd5f52b6-7963-4dd5-a10d-a4998cb1eb05?alt=media')
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000029', N'Nhân Viên', N'1', N'duccc@gmail.com', N'0977302421', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000030', N'a', N'b', N'abc2@gmai.com', N'', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000031', N'minhduc', N'duc', N'ducdm160804@gmail.com', N'0977329912', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000032', N'minhduc', N'duccoi', N'duccoi@gmail.com', N'0933888412', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000033', N'minhduc', N'duccoi', N'ducco23i@gmail.com', N'0933888411', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000034', N'minh', N'duc', N'duccoi169823@gmail.com', N'0977300162', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000035', N'minhduc', N'duccoi', N'duccoi124124@gmail.com', N'0988377412', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000036', N'duccoi', N'minh', N'duc138@gmail.com', N'0988300123', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000037', N'dang', N'ngoc', N'dangngoc4332@gmail.com', N'0846410449', NULL, N'https://firebasestorage.googleapis.com/v0/b/badmintoncourtbooking-183b2.appspot.com/o/files%2F9404725a-9b67-4dee-8c23-7b3ea7a25ffe?alt=media&token=4d462ef9-a54e-470c-a83a-d4f2cee0060e')
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000038', N'dang', N'ngoc', N'ngocdtse183959@outlook.com', N'0812345679', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000039', N'dang', N'ngoc', N'ngocdang10449@outlook.com', N'0812345678', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000040', N'dang', N'ngoc', N'acceptpls10@gmail.com', N'0812345677', NULL, NULL)
INSERT [dbo].[UserDetail] ([userID], [firstName], [lastName], [email], [phone], [facebook], [img]) VALUES (N'U0000041', N'Minh', N'Duc', N'duccoi12345623@gmail.com', N'0977465287', NULL, NULL)
GO
ALTER TABLE [dbo].[BookedSlot]  WITH CHECK ADD  CONSTRAINT [FKBookedSlot690847] FOREIGN KEY([bookingID])
REFERENCES [dbo].[Booking] ([bookingID])
GO
ALTER TABLE [dbo].[BookedSlot] CHECK CONSTRAINT [FKBookedSlot690847]
GO
ALTER TABLE [dbo].[BookedSlot]  WITH CHECK ADD  CONSTRAINT [FKBookedSlot778580] FOREIGN KEY([courtID])
REFERENCES [dbo].[Court] ([courtID])
GO
ALTER TABLE [dbo].[BookedSlot] CHECK CONSTRAINT [FKBookedSlot778580]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FKBooking923627] FOREIGN KEY([userID])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FKBooking923627]
GO
ALTER TABLE [dbo].[Court]  WITH CHECK ADD  CONSTRAINT [FKCourt788847] FOREIGN KEY([branchID])
REFERENCES [dbo].[CourtBranch] ([branchID])
GO
ALTER TABLE [dbo].[Court] CHECK CONSTRAINT [FKCourt788847]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FKFeedback274984] FOREIGN KEY([userID])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FKFeedback274984]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FKFeedback632553] FOREIGN KEY([branchID])
REFERENCES [dbo].[CourtBranch] ([branchID])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FKFeedback632553]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FKPayment444730] FOREIGN KEY([userID])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FKPayment444730]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FKPayment887923] FOREIGN KEY([bookingID])
REFERENCES [dbo].[Booking] ([bookingID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FKPayment887923]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FKUser135985] FOREIGN KEY([branchID])
REFERENCES [dbo].[CourtBranch] ([branchID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FKUser135985]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FKUser635730] FOREIGN KEY([roleID])
REFERENCES [dbo].[Role] ([roleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FKUser635730]
GO
ALTER TABLE [dbo].[UserDetail]  WITH CHECK ADD  CONSTRAINT [FKUserDetail940563] FOREIGN KEY([userID])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[UserDetail] CHECK CONSTRAINT [FKUserDetail940563]
GO
USE [master]
GO
ALTER DATABASE [BadmintonCourt] SET  READ_WRITE 
GO
