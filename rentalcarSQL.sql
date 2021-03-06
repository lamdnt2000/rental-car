USE [master]
GO
/****** Object:  Database [RentalCar]    Script Date: 4/24/2021 8:20:10 AM ******/
CREATE DATABASE [RentalCar]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RentalCar', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\RentalCar.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RentalCar_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\RentalCar_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RentalCar] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RentalCar].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RentalCar] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RentalCar] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RentalCar] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RentalCar] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RentalCar] SET ARITHABORT OFF 
GO
ALTER DATABASE [RentalCar] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RentalCar] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RentalCar] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RentalCar] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RentalCar] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RentalCar] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RentalCar] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RentalCar] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RentalCar] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RentalCar] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RentalCar] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RentalCar] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RentalCar] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RentalCar] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RentalCar] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RentalCar] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RentalCar] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RentalCar] SET RECOVERY FULL 
GO
ALTER DATABASE [RentalCar] SET  MULTI_USER 
GO
ALTER DATABASE [RentalCar] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RentalCar] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RentalCar] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RentalCar] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [RentalCar] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'RentalCar', N'ON'
GO
USE [RentalCar]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/24/2021 8:20:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NULL,
	[description] [varchar](50) NULL,
	[createDate] [datetime] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 4/24/2021 8:20:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Discount](
	[id] [varchar](10) NOT NULL,
	[title] [varchar](50) NULL,
	[createDate] [datetime] NULL,
	[expiryDate] [datetime] NULL,
	[sale] [float] NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Member]    Script Date: 4/24/2021 8:20:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Member](
	[email] [varchar](50) NOT NULL,
	[phone] [varchar](10) NULL,
	[name] [varchar](30) NULL,
	[address] [varchar](100) NULL,
	[createDate] [datetime] NULL,
	[password] [varchar](50) NULL,
	[role] [varchar](10) NULL,
	[status] [varchar](10) NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 4/24/2021 8:20:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[orderId] [int] NOT NULL,
	[productId] [varchar](10) NOT NULL,
	[amount] [int] NULL,
	[price] [float] NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[discount] [float] NULL,
 CONSTRAINT [PK_OrderDetail_1] PRIMARY KEY CLUSTERED 
(
	[orderId] ASC,
	[productId] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 4/24/2021 8:20:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rentalDate] [datetime] NULL,
	[returnDate] [datetime] NULL,
	[createDate] [datetime] NULL,
	[member] [varchar](50) NULL,
	[total] [float] NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/24/2021 8:20:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[id] [varchar](10) NOT NULL,
	[catId] [int] NOT NULL,
	[price] [float] NULL,
	[quantity] [int] NULL,
	[name] [varchar](50) NULL,
	[color] [varchar](15) NULL,
	[year] [int] NULL,
	[createDate] [datetime] NULL,
	[userCreate] [varchar](50) NULL,
	[userUpdate] [varchar](50) NULL,
	[updateDate] [datetime] NULL,
	[status] [bit] NULL,
	[saleId] [varchar](10) NULL,
 CONSTRAINT [PK_Produc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([id], [name], [description], [createDate]) VALUES (1, N'Merce', N'1234567', CAST(N'2021-02-24 16:08:08.717' AS DateTime))
INSERT [dbo].[Category] ([id], [name], [description], [createDate]) VALUES (2, N'Model 1', N'This is a model 1 for car', CAST(N'2021-02-25 09:30:54.857' AS DateTime))
INSERT [dbo].[Category] ([id], [name], [description], [createDate]) VALUES (3, N'Model 2', N'This is a model 2 for car', CAST(N'2021-02-25 09:30:59.063' AS DateTime))
INSERT [dbo].[Category] ([id], [name], [description], [createDate]) VALUES (4, N'Model 3', N'This is a model 3 for car', CAST(N'2021-02-25 09:31:02.407' AS DateTime))
INSERT [dbo].[Category] ([id], [name], [description], [createDate]) VALUES (5, N'Model 4', N'This is a model 4 for car', CAST(N'2021-02-25 09:31:05.960' AS DateTime))
INSERT [dbo].[Category] ([id], [name], [description], [createDate]) VALUES (6, N'Model 5', N'This is a model 5 for car', CAST(N'2021-02-25 09:31:08.660' AS DateTime))
INSERT [dbo].[Category] ([id], [name], [description], [createDate]) VALUES (13, N'cat v3', N'new car v3', NULL)
INSERT [dbo].[Category] ([id], [name], [description], [createDate]) VALUES (14, N'cat v3', N'new car v3', NULL)
SET IDENTITY_INSERT [dbo].[Category] OFF
INSERT [dbo].[Discount] ([id], [title], [createDate], [expiryDate], [sale]) VALUES (N'sale1', N'sale 20%', CAST(N'2021-03-06 18:44:29.597' AS DateTime), CAST(N'2021-03-11 18:44:29.597' AS DateTime), 0.2)
INSERT [dbo].[Discount] ([id], [title], [createDate], [expiryDate], [sale]) VALUES (N'sale2', N'sale 30%', CAST(N'2021-03-06 18:44:57.740' AS DateTime), CAST(N'2021-04-05 18:44:57.740' AS DateTime), 0.3)
INSERT [dbo].[Discount] ([id], [title], [createDate], [expiryDate], [sale]) VALUES (N'sale3', N'sale 15%', CAST(N'2021-03-15 12:15:44.670' AS DateTime), CAST(N'2021-03-25 12:15:44.670' AS DateTime), 0.15)
INSERT [dbo].[Discount] ([id], [title], [createDate], [expiryDate], [sale]) VALUES (N'sale4', N'sale 10%', CAST(N'2021-03-15 12:16:00.750' AS DateTime), CAST(N'2021-03-22 12:16:00.750' AS DateTime), 0.1)
INSERT [dbo].[Discount] ([id], [title], [createDate], [expiryDate], [sale]) VALUES (N'sale6', N'Sale 15%', CAST(N'2021-04-24 08:04:22.297' AS DateTime), CAST(N'2021-05-04 08:04:22.297' AS DateTime), 0.15)
INSERT [dbo].[Discount] ([id], [title], [createDate], [expiryDate], [sale]) VALUES (N'sale7', N'Sale 10%', CAST(N'2021-04-24 08:04:43.653' AS DateTime), CAST(N'2021-04-25 08:04:43.653' AS DateTime), 0.1)
INSERT [dbo].[Member] ([email], [phone], [name], [address], [createDate], [password], [role], [status]) VALUES (N'dntlam123@gmail.com', N'0969352492', N'thanh lam', N'84/2 dien bien phu', CAST(N'2021-02-24 15:28:06.010' AS DateTime), N'123456', N'member', N'Active')
INSERT [dbo].[Member] ([email], [phone], [name], [address], [createDate], [password], [role], [status]) VALUES (N'dntlam1234@gmail.com', N'0987654321', N'lam', NULL, NULL, N'123456', N'member', N'Active')
INSERT [dbo].[Member] ([email], [phone], [name], [address], [createDate], [password], [role], [status]) VALUES (N'h3nzyblog@gmail.com', N'0364334370', N'thanhlam', N'daskdjak', CAST(N'2021-04-22 09:00:27.380' AS DateTime), N'123456', N'member', N'New')
INSERT [dbo].[Member] ([email], [phone], [name], [address], [createDate], [password], [role], [status]) VALUES (N'h3nzyblog1@gmail.com', N'0969352492', N'thanh lam', N'sky 9', CAST(N'2021-04-22 09:03:21.917' AS DateTime), N'123456', N'member', N'New')
INSERT [dbo].[Member] ([email], [phone], [name], [address], [createDate], [password], [role], [status]) VALUES (N'khanhkt@fe.edu.vn', N'0987654321', N'khanh dai ca', N'abc', CAST(N'2021-03-10 13:45:06.000' AS DateTime), N'123456789', N'member', N'Active')
INSERT [dbo].[Member] ([email], [phone], [name], [address], [createDate], [password], [role], [status]) VALUES (N'lamdntse140089@fpt.edu.vn', N'0969352492', N'bbbbbbbbbbbbbbbb', N'bbbbbbbbbbbbbbbb', CAST(N'2021-03-19 11:52:12.030' AS DateTime), N'123456', N'member', N'Active')
INSERT [dbo].[Member] ([email], [phone], [name], [address], [createDate], [password], [role], [status]) VALUES (N'sasukeanos@gmail.com', N'0969352492', N'lam thanh', N'sky9, liên phu?ng, phú h?u', CAST(N'2021-03-06 21:46:02.073' AS DateTime), N'123456', N'member', N'Active')
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (6, N'siZZy', 5, 30143283.691, 7, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (7, N'siZZy', 5, 30143283.691, 8, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (8, N'dI9ub', 1, 4000000, 57, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (8, N'siZZy', 3, 30143283.691, 9, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (78, N'zRqTo', 2, 69607446.289, 70, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (79, N'l4cTt', 4, 41509194.336, 71, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (80, N'zRqTo', 9, 69607446.289, 72, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (81, N'zRqTo', 1, 69607446.289, 73, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (82, N'zRqTo', 3, 69607446.289, 74, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (86, N'dI9ub', 1, 161828662.109, 78, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (87, N'dI9ub', 1, 161828662.109, 79, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (88, N'zRqTo', 2, 69607446.289, 80, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (89, N'cieEC', 2, 128736376.953, 81, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (90, N'dI9ub', 1, 161828662.109, 83, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (90, N'xYLYh', 1, 27706330.566, 82, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (91, N'l4cTt', 3, 41509194.336, 85, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (91, N'xYLYh', 3, 27706330.566, 84, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (92, N'xYLYh', 12, 27706330.566, 87, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (92, N'zRqTo', 1, 69607446.289, 86, NULL)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1094, N'siZZy', 2, 454673, 1091, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1094, N'ss2VN', 1, 1071396, 1092, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1095, N'siZZy', 1, 454673, 1093, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1095, N'ss2VN', 1, 1071396, 1094, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1096, N'dI9ub', 1, 1351982, 1097, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1096, N'siZZy', 1, 454673, 1095, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1096, N'ss2VN', 1, 1071396, 1096, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1097, N'siZZy', 1, 454673, 1098, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1097, N'ss2VN', 1, 1071396, 1099, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1098, N'dI9ub', 1, 1351982, 1103, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1098, N'j3d3O', 1, 1251576, 1102, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1098, N'ss2VN', 1, 1071396, 1101, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1098, N'xEu2S', 1, 1482569, 1100, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1100, N'j3d3O', 1, 1251576, 1106, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1100, N'ss2VN', 1, 1071396, 1105, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1100, N'xEu2S', 1, 1482569, 1104, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1101, N'ss2VN', 1, 1071396, 1107, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1102, N'ABC', 2, 703053, 1108, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1103, N'ss2VN', 1, 1071396, 1110, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1103, N'ZnMI0', 1, 1170275, 1109, 0.15)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1104, N'ss2VN', 2, 1071396, 1112, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1104, N'zRqTo', 1, 766004, 1111, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1105, N'xEu2S', 3, 1482569, 1113, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (1105, N'ZnMI0', 1, 1170275, 1114, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (2105, N'dI9ub', 3, 1351982, 2114, 0)
INSERT [dbo].[OrderDetail] ([orderId], [productId], [amount], [price], [id], [discount]) VALUES (2105, N'ZnMI0', 1, 1170275, 2113, 0)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (6, CAST(N'2021-03-05 00:00:00.000' AS DateTime), CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-05 21:04:14.730' AS DateTime), N'dntlam123@gmail.com', 301432840, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (7, CAST(N'2021-03-05 00:00:00.000' AS DateTime), CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-05 21:06:00.990' AS DateTime), N'dntlam123@gmail.com', 301432840, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (8, CAST(N'2021-03-05 00:00:00.000' AS DateTime), CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-05 22:22:01.393' AS DateTime), N'dntlam1234@gmail.com', 180859700, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (66, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 12:52:38.027' AS DateTime), N'dntlam1234@gmail.com', 3388615940, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (67, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 12:53:58.320' AS DateTime), N'dntlam1234@gmail.com', 1786695320, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (78, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 14:56:35.340' AS DateTime), N'dntlam123@gmail.com', 1670578760, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (79, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 15:06:51.637' AS DateTime), N'dntlam1234@gmail.com', 166036780, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (80, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 15:07:21.527' AS DateTime), N'dntlam123@gmail.com', 0, -1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (81, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 19:37:11.227' AS DateTime), N'dntlam123@gmail.com', 69607440, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (82, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 19:37:32.607' AS DateTime), N'dntlam123@gmail.com', 208822340, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (86, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 21:58:10.820' AS DateTime), N'sasukeanos@gmail.com', 161828660, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (87, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 21:58:27.987' AS DateTime), N'sasukeanos@gmail.com', 161828660, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (88, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 22:03:29.743' AS DateTime), N'sasukeanos@gmail.com', 139214900, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (89, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-07 00:00:00.000' AS DateTime), CAST(N'2021-03-06 22:09:06.943' AS DateTime), N'sasukeanos@gmail.com', 205978200, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (90, CAST(N'2021-03-06 00:00:00.000' AS DateTime), CAST(N'2021-03-09 00:00:00.000' AS DateTime), CAST(N'2021-03-06 22:18:48.493' AS DateTime), N'sasukeanos@gmail.com', 398023480, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (91, CAST(N'2021-03-08 00:00:00.000' AS DateTime), CAST(N'2021-03-10 00:00:00.000' AS DateTime), CAST(N'2021-03-06 22:38:10.127' AS DateTime), N'sasukeanos@gmail.com', 415293120, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (92, CAST(N'2021-03-10 00:00:00.000' AS DateTime), CAST(N'2021-03-11 00:00:00.000' AS DateTime), CAST(N'2021-03-10 13:52:06.203' AS DateTime), N'khanhkt@fe.edu.vn', 402083440, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1094, CAST(N'2021-03-17 00:00:00.000' AS DateTime), CAST(N'2021-03-18 00:00:00.000' AS DateTime), CAST(N'2021-03-17 13:02:20.223' AS DateTime), N'sasukeanos@gmail.com', 1820032.625, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1095, CAST(N'2021-03-17 00:00:00.000' AS DateTime), CAST(N'2021-03-18 00:00:00.000' AS DateTime), CAST(N'2021-03-17 13:12:19.750' AS DateTime), N'sasukeanos@gmail.com', 1365359.625, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1096, CAST(N'2021-03-17 00:00:00.000' AS DateTime), CAST(N'2021-03-18 00:00:00.000' AS DateTime), CAST(N'2021-03-17 13:26:56.183' AS DateTime), N'sasukeanos@gmail.com', 2717341.5, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1097, CAST(N'2021-03-19 00:00:00.000' AS DateTime), CAST(N'2021-03-20 00:00:00.000' AS DateTime), CAST(N'2021-03-17 13:47:47.377' AS DateTime), N'sasukeanos@gmail.com', 1365359.625, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1098, CAST(N'2021-03-19 00:00:00.000' AS DateTime), CAST(N'2021-03-21 00:00:00.000' AS DateTime), CAST(N'2021-03-17 14:30:25.020' AS DateTime), N'sasukeanos@gmail.com', 9548856, 0)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1100, CAST(N'2021-03-19 00:00:00.000' AS DateTime), CAST(N'2021-03-20 00:00:00.000' AS DateTime), CAST(N'2021-03-19 11:56:27.820' AS DateTime), N'lamdntse140089@fpt.edu.vn', 3422446.25, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1101, CAST(N'2021-03-22 00:00:00.000' AS DateTime), CAST(N'2021-03-26 00:00:00.000' AS DateTime), CAST(N'2021-03-19 11:58:31.633' AS DateTime), N'lamdntse140089@fpt.edu.vn', 3642746.5, 0)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1102, CAST(N'2021-03-19 00:00:00.000' AS DateTime), CAST(N'2021-03-20 00:00:00.000' AS DateTime), CAST(N'2021-03-19 12:45:50.860' AS DateTime), N'lamdntse140089@fpt.edu.vn', 1406106, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1103, CAST(N'2021-03-23 00:00:00.000' AS DateTime), CAST(N'2021-03-24 00:00:00.000' AS DateTime), CAST(N'2021-03-19 14:44:01.087' AS DateTime), N'sasukeanos@gmail.com', 1905420.375, 0)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1104, CAST(N'2021-03-20 00:00:00.000' AS DateTime), CAST(N'2021-03-21 00:00:00.000' AS DateTime), CAST(N'2021-03-20 12:53:27.377' AS DateTime), N'dntlam1234@gmail.com', 2908796, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (1105, CAST(N'2021-03-24 00:00:00.000' AS DateTime), CAST(N'2021-03-25 00:00:00.000' AS DateTime), CAST(N'2021-03-24 10:48:50.267' AS DateTime), N'sasukeanos@gmail.com', 5617982, 1)
INSERT [dbo].[Orders] ([id], [rentalDate], [returnDate], [createDate], [member], [total], [status]) VALUES (2105, CAST(N'2021-04-24 00:00:00.000' AS DateTime), CAST(N'2021-04-25 00:00:00.000' AS DateTime), CAST(N'2021-04-24 08:05:15.967' AS DateTime), N'sasukeanos@gmail.com', 5226221, 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'0GXye', 3, 867534, 2, N'car-42304', N'pink', 2006, CAST(N'2021-02-25 10:03:38.000' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'0lT8J', 5, 193684, 7, N'car-82780', N'white', 2007, CAST(N'2021-02-25 10:03:38.003' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'0mZXa', 3, 474442, 2, N'car-44489', N'orange', 2012, CAST(N'2021-02-25 10:03:37.927' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'0ncFO', 6, 576282, 4, N'car-5A2A4', N'pink', 2001, CAST(N'2021-02-25 10:03:38.040' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'0PhX3', 4, 1500982, 3, N'car-86601', N'black', 1992, CAST(N'2021-02-25 10:03:38.003' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'0S7nj', 6, 609740, 10, N'car-66378', N'orange', 1991, CAST(N'2021-02-25 10:03:37.847' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'0ua06', 5, 414450, 2, N'car-64122', N'purple', 2005, CAST(N'2021-02-25 10:03:37.877' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'1KEq2', 6, 1355435, 2, N'car-53451', N'blue', 2010, CAST(N'2021-02-25 10:03:38.020' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'1LgAG', 4, 276299, 6, N'car-41745', N'orange', 2001, CAST(N'2021-02-25 10:03:37.913' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'1TQLq', 2, 948417, 4, N'car-2A434', N'orange', 2003, CAST(N'2021-02-25 10:03:38.050' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'1wlzc', 5, 537661, 7, N'car-39422', N'blue', 2021, CAST(N'2021-02-25 10:03:37.857' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'22HXP', 5, 772516, 4, N'car-A4691', N'pink', 1994, CAST(N'2021-02-25 10:03:37.893' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'2NfPx', 5, 1643467, 7, N'car-57678', N'white', 2013, CAST(N'2021-02-25 10:03:37.967' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'2qcbx', 2, 263530, 4, N'car-44564', N'yellow', 2020, CAST(N'2021-02-25 10:03:37.863' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'3moIT', 4, 1188127, 1, N'car-87526', N'blue', 2018, CAST(N'2021-02-25 10:03:38.010' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'3RY9n', 2, 1289959, 8, N'car-8055A', N'black', 2009, CAST(N'2021-02-25 10:03:38.030' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'3zqOu', 2, 707983, 8, N'car-50108', N'pink', 2013, CAST(N'2021-02-25 10:03:37.953' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'464eh', 4, 237192, 6, N'car-87A79', N'yellow', 2016, CAST(N'2021-02-25 10:03:37.833' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'4CLKE', 5, 1280992, 10, N'car-93A22', N'purple', 2014, CAST(N'2021-02-25 10:03:38.027' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'4lYm4', 2, 922570, 6, N'car-73078', N'yellow', 2010, CAST(N'2021-02-25 10:03:37.990' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'63Czo', 2, 635705, 5, N'car-64739', N'orange', 2006, CAST(N'2021-02-25 10:03:37.903' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'6avZk', 4, 456734, 10, N'car-75389', N'red', 2006, CAST(N'2021-02-25 10:03:37.997' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'6yyCu', 3, 722253, 5, N'car-05647', N'orange', 1997, CAST(N'2021-02-25 10:03:38.043' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'7EGYF', 3, 1465879, 5, N'car-82620', N'orange', 1999, CAST(N'2021-02-25 10:03:37.940' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'7gMGs', 4, 626475, 8, N'car-77688', N'yellow', 2013, CAST(N'2021-02-25 10:03:37.997' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'7IIOp', 6, 1030992, 7, N'car-70518', N'red', 1999, CAST(N'2021-02-25 10:03:37.840' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'7Mqmj', 6, 1058536, 4, N'car-90A02', N'orange', 2017, CAST(N'2021-02-25 10:03:37.930' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'7rpwm', 5, 1333449, 2, N'car-58495', N'purple', 1997, CAST(N'2021-02-25 10:03:37.863' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'7voD7', 5, 842943, 6, N'car-06809', N'pink', 2004, CAST(N'2021-02-25 10:03:37.997' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'8alLi', 4, 602881, 10, N'car-A1994', N'white', 2001, CAST(N'2021-02-25 10:03:37.810' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'8Jm60', 6, 1442150, 3, N'car-91490', N'yellow', 2002, CAST(N'2021-02-25 10:03:37.923' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'93fw7', 4, 1411867, 6, N'car-97093', N'pink', 2008, CAST(N'2021-02-25 10:03:37.867' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'9Q89i', 2, 1176433, 8, N'car-80507', N'red', 2015, CAST(N'2021-02-25 10:03:37.937' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'9zxOx', 2, 208662, 5, N'car-80837', N'pink', 1999, CAST(N'2021-02-25 10:03:37.987' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'a1FcO', 4, 1200785, 7, N'car-0AA94', N'orange', 2007, CAST(N'2021-02-25 10:03:37.987' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'ABC', 1, 703053, 3, N'car-123', N'yellow', 2020, CAST(N'2021-02-25 09:29:24.900' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'acyJN', 3, 1191151, 10, N'car-95305', N'yellow', 2013, CAST(N'2021-02-25 10:03:38.027' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'AiYMF', 4, 402069, 8, N'car-35779', N'white', 2011, CAST(N'2021-02-25 10:03:38.050' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'AO59B', 5, 577435, 5, N'car-97691', N'orange', 2016, CAST(N'2021-02-25 10:03:38.017' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'AoZ1T', 3, 994803, 3, N'car-29341', N'white', 1997, CAST(N'2021-02-25 10:03:37.957' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'AqTkF', 2, 1491627, 4, N'car-08A09', N'purple', 2018, CAST(N'2021-02-25 10:03:37.930' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'b5ozY', 3, 467015, 1, N'car-A0549', N'green', 2007, CAST(N'2021-02-25 10:03:37.887' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'bIS6t', 5, 1157992, 1, N'car-955A7', N'red', 2015, CAST(N'2021-02-25 10:03:37.880' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'BjfQL', 5, 260255, 6, N'car-3A176', N'purple', 2020, CAST(N'2021-02-25 10:03:37.847' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'BLHEn', 4, 1397410, 2, N'car-97380', N'blue', 1995, CAST(N'2021-02-25 10:03:37.870' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'bq2Hg', 5, 620660, 1, N'car-33831', N'purple', 1998, CAST(N'2021-02-25 10:03:37.913' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'BYhWT', 4, 364755, 2, N'car-193A4', N'purple', 2019, CAST(N'2021-02-25 10:03:37.850' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'BYUpx', 5, 1223714, 4, N'car-01A21', N'blue', 2002, CAST(N'2021-02-25 10:03:38.020' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'cieEC', 2, 1215660, 5, N'car-93435', N'blue', 1996, CAST(N'2021-02-25 10:03:38.057' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'CKumY', 3, 1339442, 6, N'car-324AA', N'blue', 2014, CAST(N'2021-02-25 10:03:37.810' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'cQJiE', 3, 708082, 8, N'car-8A11A', N'red', 1992, CAST(N'2021-02-25 10:03:37.827' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'crooE', 5, 629623, 3, N'car-88130', N'yellow', 1992, CAST(N'2021-02-25 10:03:38.040' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'cTaNU', 3, 198653, 5, N'car-62099', N'orange', 2007, CAST(N'2021-02-25 10:03:37.907' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'CXO37', 2, 962752, 7, N'car-A875A', N'red', 1998, CAST(N'2021-02-25 10:03:37.957' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'D61IZ', 2, 1283927, 3, N'car-93353', N'blue', 2007, CAST(N'2021-02-25 10:03:37.843' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'dEQOw', 6, 947974, 3, N'car-84797', N'blue', 1993, CAST(N'2021-02-25 10:03:38.000' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'dI9ub', 2, 1351982, 5, N'car-A779A', N'black', 1999, CAST(N'2021-02-25 10:03:38.063' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'DKyd5', 3, 955088, 1, N'car-A5625', N'pink', 2006, CAST(N'2021-02-25 10:03:38.007' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'E4181', 2, 889087, 5, N'car-7A902', N'purple', 2005, CAST(N'2021-02-25 10:03:37.953' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'e7z27', 6, 1467155, 5, N'car-15611', N'red', 2004, CAST(N'2021-02-25 10:03:38.033' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'eCwwB', 3, 558267, 7, N'car-A9321', N'purple', 1991, CAST(N'2021-02-25 10:03:37.923' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'edpVz', 5, 1300962, 8, N'car-45202', N'purple', 2014, CAST(N'2021-02-25 10:03:37.967' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'fEjnw', 6, 1458003, 1, N'car-76A62', N'yellow', 1993, CAST(N'2021-02-25 10:03:38.030' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'fMvcl', 5, 986526, 1, N'car-85710', N'yellow', 1999, CAST(N'2021-02-25 10:03:37.850' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'FQASv', 5, 194330, 4, N'car-748A9', N'pink', 1997, CAST(N'2021-02-25 10:03:38.000' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'Fqros', 2, 823217, 1, N'car-60164', N'purple', 2019, CAST(N'2021-02-25 10:03:37.847' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'fWX9d', 6, 1193215, 10, N'car-7593A', N'pink', 1997, CAST(N'2021-02-25 10:03:37.950' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'g0yxI', 6, 1172180, 4, N'car-6A639', N'red', 2013, CAST(N'2021-02-25 10:03:37.917' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'G0zCN', 4, 1485349, 4, N'car-51088', N'orange', 2002, CAST(N'2021-02-25 10:03:37.837' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'gBSUt', 6, 1021986, 10, N'car-33829', N'orange', 2006, CAST(N'2021-02-25 10:03:37.963' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'gHl96', 4, 1505814, 8, N'car-0A0A4', N'orange', 1992, CAST(N'2021-02-25 10:03:38.017' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'gjuNv', 6, 1462375, 4, N'car-73456', N'pink', 1999, CAST(N'2021-02-25 10:03:37.993' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'gqRq1', 4, 1512476, 5, N'car-71889', N'purple', 2001, CAST(N'2021-02-25 10:03:37.860' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'H5QR2', 3, 1555919, 1, N'car-29565', N'black', 1996, CAST(N'2021-02-25 10:03:37.960' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'haLYT', 4, 591119, 3, N'car-94961', N'blue', 2021, CAST(N'2021-02-25 10:03:37.907' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'hCTDA', 2, 446242, 4, N'car-01A12', N'white', 2009, CAST(N'2021-02-25 10:03:37.833' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'hewiV', 3, 1122878, 6, N'car-A8580', N'orange', 1992, CAST(N'2021-02-25 10:03:37.980' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'hGhBo', 5, 543638, 4, N'car-33365', N'pink', 2015, CAST(N'2021-02-25 10:03:37.960' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'HKMtm', 2, 1098948, 10, N'car-7A399', N'pink', 1996, CAST(N'2021-02-25 10:03:37.887' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'hsWMm', 3, 1599986, 4, N'car-74016', N'black', 2019, CAST(N'2021-02-25 10:03:37.890' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'hyDoT', 6, 650272, 4, N'car-51A39', N'blue', 2018, CAST(N'2021-02-25 10:03:38.023' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'i9nV5', 6, 1313202, 6, N'car-72A64', N'purple', 1998, CAST(N'2021-02-25 10:03:37.907' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'Iejs6', 3, 1573233, 9, N'car-176A7', N'purple', 2011, CAST(N'2021-02-25 10:03:37.830' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'iliQf', 6, 1130581, 4, N'car-15387', N'white', 2003, CAST(N'2021-02-25 10:03:37.800' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'IoY9g', 2, 712712, 5, N'car-43217', N'orange', 1994, CAST(N'2021-02-25 10:03:38.053' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'Iu861', 5, 1615448, 5, N'car-44673', N'black', 2019, CAST(N'2021-02-25 10:03:37.973' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'iYmcR', 5, 1564832, 1, N'car-72051', N'pink', 2007, CAST(N'2021-02-25 10:03:37.980' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'j3d3O', 2, 1251576, 3, N'car-6993A', N'blue', 1992, CAST(N'2021-02-25 10:03:38.063' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'JBHXD', 3, 1287489, 9, N'car-143A0', N'blue', 1996, CAST(N'2021-02-25 10:03:38.037' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'JITt2', 5, 1243481, 6, N'car-07A81', N'red', 1991, CAST(N'2021-02-25 10:03:37.830' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'JjwLi', 4, 408544, 1, N'car-67954', N'white', 2011, CAST(N'2021-02-25 10:03:37.840' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'jrzZ3', 4, 477488, 7, N'car-13831', N'yellow', 2009, CAST(N'2021-02-25 10:03:37.947' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'K2DpY', 2, 1393695, 8, N'car-67222', N'red', 1992, CAST(N'2021-02-25 10:03:37.820' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'KhSw5', 4, 210137, 4, N'car-29074', N'black', 1995, CAST(N'2021-02-25 10:03:37.917' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'Kjq6a', 6, 426469, 10, N'car-25297', N'red', 2009, CAST(N'2021-02-25 10:03:38.047' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'km3Us', 3, 635958, 4, N'car-09387', N'purple', 2007, CAST(N'2021-02-25 10:03:37.923' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'KPCLS', 2, 885447, 4, N'car-22315', N'white', 1993, CAST(N'2021-02-25 10:03:37.933' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'KPI2j', 4, 1138723, 2, N'car-45A76', N'pink', 1998, CAST(N'2021-02-25 10:03:38.007' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'kvoOh', 5, 1335770, 7, N'car-87811', N'green', 1993, CAST(N'2021-02-25 10:03:37.857' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'KzDQr', 4, 1161577, 2, N'car-09120', N'pink', 2015, CAST(N'2021-02-25 10:03:37.960' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
GO
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'KzmeK', 6, 369998, 10, N'car-10698', N'purple', 1994, CAST(N'2021-02-25 10:03:37.987' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'l19La', 6, 738047, 2, N'car-78583', N'pink', 2003, CAST(N'2021-02-25 10:03:37.910' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'l4cTt', 4, 1593472, 2, N'car-79684', N'black', 1996, CAST(N'2021-02-25 10:03:38.057' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'L95IZ', 4, 1597026, 3, N'car-60626', N'blue', 1993, CAST(N'2021-02-25 10:03:37.827' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'ld9Tw', 2, 1014964, 9, N'car-36962', N'pink', 2018, CAST(N'2021-02-25 10:03:37.950' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'lgnov', 5, 722772, 5, N'car-64553', N'yellow', 1995, CAST(N'2021-02-25 10:03:37.833' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'lMDA5', 3, 1137984, 3, N'car-85527', N'blue', 2002, CAST(N'2021-02-25 10:03:38.013' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'LnIKd', 4, 1384416, 7, N'car-55301', N'pink', 1994, CAST(N'2021-02-25 10:03:37.817' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'LQe3J', 4, 663275, 5, N'car-56828', N'blue', 2019, CAST(N'2021-02-25 10:03:38.040' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'LqHsn', 4, 389804, 4, N'car-9682A', N'purple', 2021, CAST(N'2021-02-25 10:03:37.983' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'lrQDz', 4, 1461156, 5, N'car-A3782', N'green', 2008, CAST(N'2021-02-25 10:03:37.823' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'LUjB2', 6, 1528135, 2, N'car-02527', N'green', 2018, CAST(N'2021-02-25 10:03:37.873' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'LZpWF', 6, 1335583, 2, N'car-36635', N'green', 2012, CAST(N'2021-02-25 10:03:37.947' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'm4V4U', 2, 469408, 6, N'car-626A6', N'green', 2019, CAST(N'2021-02-25 10:03:37.820' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'N0Z1g', 4, 924163, 5, N'car-26095', N'green', 2008, CAST(N'2021-02-25 10:03:37.963' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'N8OjJ', 2, 1305446, 9, N'car-59407', N'purple', 2012, CAST(N'2021-02-25 10:03:37.867' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'nBGPl', 4, 863391, 5, N'car-957A2', N'blue', 2014, CAST(N'2021-02-25 10:03:37.940' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'NblkH', 3, 445343, 6, N'car-7A746', N'red', 1994, CAST(N'2021-02-25 10:03:37.943' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'nFnYt', 5, 945862, 1, N'car-529A6', N'green', 2002, CAST(N'2021-02-25 10:03:38.057' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'NQTPK', 2, 641575, 3, N'car-50795', N'white', 2012, CAST(N'2021-02-25 10:03:37.977' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'nu8Vg', 3, 467314, 3, N'car-40403', N'red', 2018, CAST(N'2021-02-25 10:03:38.060' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'O7hT2', 6, 1247209, 1, N'car-44926', N'yellow', 1996, CAST(N'2021-02-25 10:03:37.903' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'oHTN8', 4, 1428977, 2, N'car-85309', N'pink', 1996, CAST(N'2021-02-25 10:03:38.010' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'oI9LV', 5, 851052, 4, N'car-839A9', N'green', 2014, CAST(N'2021-02-25 10:03:37.917' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'oLuWD', 6, 1062827, 7, N'car-779A6', N'black', 2016, CAST(N'2021-02-25 10:03:37.977' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'om1Nf', 4, 1336570, 6, N'car-90575', N'red', 2011, CAST(N'2021-02-25 10:03:37.837' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'OTuXb', 4, 153551, 7, N'car-11935', N'purple', 2018, CAST(N'2021-02-25 10:03:38.053' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'OZEf6', 3, 867258, 7, N'car-35262', N'purple', 2010, CAST(N'2021-02-25 10:03:37.813' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'PDAKF', 5, 564914, 3, N'car-16901', N'blue', 2021, CAST(N'2021-02-25 10:03:37.967' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'peIL4', 2, 784250, 1, N'car-8A475', N'red', 2007, CAST(N'2021-02-25 10:03:37.837' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'pW5W4', 2, 688807, 1, N'car-48876', N'white', 2005, CAST(N'2021-02-25 10:03:37.927' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'pwnoQ', 4, 1533168, 9, N'car-297A3', N'white', 2012, CAST(N'2021-02-25 10:03:37.820' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'pWwpO', 3, 1249068, 2, N'car-1A94A', N'yellow', 2012, CAST(N'2021-02-25 10:03:37.823' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'Q1BSD', 6, 757974, 8, N'car-62937', N'purple', 2012, CAST(N'2021-02-25 10:03:38.057' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'Q7t4f', 3, 1047889, 5, N'car-0A121', N'orange', 1996, CAST(N'2021-02-25 10:03:37.853' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'QatgV', 2, 1026712, 10, N'car-40004', N'yellow', 2001, CAST(N'2021-02-25 10:03:37.880' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'QbBl4', 5, 821768, 6, N'car-54755', N'orange', 2004, CAST(N'2021-02-25 10:03:38.037' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'qBI5M', 6, 545532, 8, N'car-7396A', N'green', 1994, CAST(N'2021-02-25 10:03:38.000' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'qByIb', 3, 543336, 2, N'car-20086', N'red', 2015, CAST(N'2021-02-25 10:03:37.817' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'QF6X5', 5, 1322609, 10, N'car-9A302', N'red', 1995, CAST(N'2021-02-25 10:03:38.053' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'QFTbX', 4, 1035770, 5, N'car-A84A7', N'pink', 2007, CAST(N'2021-02-25 10:03:38.007' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'qnFhI', 5, 1458872, 9, N'car-80A45', N'white', 2016, CAST(N'2021-02-25 10:03:37.870' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'qoYWr', 6, 233098, 3, N'car-50814', N'purple', 2017, CAST(N'2021-02-25 10:03:37.883' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'rcyva', 6, 464985, 9, N'car-91874', N'yellow', 2021, CAST(N'2021-02-25 10:03:38.047' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'RFomY', 3, 936205, 5, N'car-A5945', N'white', 2016, CAST(N'2021-02-25 10:03:38.013' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'rmllY', 3, 235253, 2, N'car-11672', N'pink', 2009, CAST(N'2021-02-25 10:03:37.983' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'RuESs', 3, 816397, 2, N'car-81945', N'blue', 1995, CAST(N'2021-02-25 10:03:38.033' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'rXQ7Z', 6, 859883, 7, N'car-044A0', N'blue', 2018, CAST(N'2021-02-25 10:03:37.807' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'ryLbP', 6, 153027, 7, N'car-47126', N'blue', 2015, CAST(N'2021-02-25 10:03:37.827' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N's4MDL', 5, 1448633, 6, N'car-27693', N'pink', 2010, CAST(N'2021-02-25 10:03:38.017' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'sGsBq', 4, 539942, 2, N'car-2879A', N'red', 2013, CAST(N'2021-02-25 10:03:37.920' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'sh4rh', 2, 436058, 8, N'car-A8412', N'black', 2015, CAST(N'2021-02-25 10:03:37.943' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'sHlox', 4, 1175770, 7, N'car-39674', N'purple', 2014, CAST(N'2021-02-25 10:03:37.803' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'siZZy', 4, 454673, 0, N'car-67553', N'green', 2019, CAST(N'2021-02-25 10:03:38.067' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'SkbTF', 3, 1054799, 9, N'car-94579', N'pink', 1991, CAST(N'2021-02-25 10:03:37.813' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'sKZ3n', 3, 751426, 6, N'car-25557', N'blue', 2007, CAST(N'2021-02-25 10:03:37.947' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'sQmWL', 4, 1167623, 3, N'car-93547', N'red', 1994, CAST(N'2021-02-25 10:03:38.053' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale1')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'ss2VN', 3, 1071396, 0, N'car-A6431', N'red', 2000, CAST(N'2021-02-25 10:03:38.067' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale3')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'SssjE', 4, 1628951, 8, N'car-36043', N'pink', 1994, CAST(N'2021-02-25 10:03:37.867' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'T7TLO', 2, 281549, 4, N'car-4A289', N'yellow', 1997, CAST(N'2021-02-25 10:03:37.977' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale4')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'tayJv', 4, 846089, 1, N'car-461A3', N'blue', 2020, CAST(N'2021-02-25 10:03:37.963' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale3')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'tfTjK', 5, 1082770, 7, N'car-74A91', N'white', 2005, CAST(N'2021-02-25 10:03:38.007' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale1')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'tfTSP', 5, 1425172, 4, N'car-031A0', N'pink', 1994, CAST(N'2021-02-25 10:03:37.853' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'TSPwX', 3, 632656, 2, N'car-50152', N'pink', 2017, CAST(N'2021-02-25 10:03:37.997' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale4')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'UBOT1', 6, 229791, 1, N'car-37553', N'yellow', 1994, CAST(N'2021-02-25 10:03:37.937' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale3')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'ubwbt', 4, 151246, 10, N'car-72A39', N'white', 2016, CAST(N'2021-02-25 10:03:37.930' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'uk1nn', 5, 1101631, 4, N'car-04496', N'red', 1994, CAST(N'2021-02-25 10:03:37.893' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'uoBEd', 2, 845610, 1, N'car-31210', N'white', 2013, CAST(N'2021-02-25 10:03:37.873' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale1')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'UR7TH', 5, 1392528, 10, N'car-50371', N'purple', 2001, CAST(N'2021-02-25 10:03:37.840' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'UvBjM', 3, 1366118, 7, N'car-02841', N'black', 2011, CAST(N'2021-02-25 10:03:37.890' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale1')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'uYCPM', 6, 1228510, 5, N'car-98299', N'blue', 1993, CAST(N'2021-02-25 10:03:37.947' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'v5U9q', 6, 1259175, 7, N'car-74881', N'orange', 2006, CAST(N'2021-02-25 10:03:38.023' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'VEcnV', 2, 412497, 2, N'car-A0963', N'white', 2009, CAST(N'2021-02-25 10:03:37.843' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'vhNQD', 4, 243568, 10, N'car-92912', N'red', 2021, CAST(N'2021-02-25 10:03:38.057' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale1')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'vNNY8', 3, 359723, 8, N'car-58A35', N'purple', 1996, CAST(N'2021-02-25 10:03:37.937' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale4')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'VqSfV', 4, 482500, 1, N'car-70975', N'pink', 1991, CAST(N'2021-02-25 10:03:38.043' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale4')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'vuQXf', 6, 1466879, 4, N'car-99464', N'black', 1993, CAST(N'2021-02-25 10:03:38.037' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'VxtJI', 4, 1244520, 9, N'car-4A253', N'black', 1995, CAST(N'2021-02-25 10:03:37.973' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale3')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'VYI6Y', 2, 1118587, 9, N'car-08384', N'yellow', 2008, CAST(N'2021-02-25 10:03:38.030' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'w29QC', 3, 1319748, 10, N'car-14A52', N'orange', 2001, CAST(N'2021-02-25 10:03:38.037' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale1')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'wMppj', 3, 808161, 7, N'car-92639', N'blue', 2007, CAST(N'2021-02-25 10:03:38.027' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale1')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'WUWnr', 3, 534426, 7, N'car-28479', N'green', 2015, CAST(N'2021-02-25 10:03:37.970' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'Ww9YW', 6, 1188656, 9, N'car-5000A', N'green', 2019, CAST(N'2021-02-25 10:03:37.883' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale4')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'xA7BO', 2, 621301, 2, N'car-89695', N'pink', 2018, CAST(N'2021-02-25 10:03:38.050' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale3')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'xdVvF', 4, 776080, 5, N'car-0AAA6', N'black', 1991, CAST(N'2021-02-25 10:03:37.807' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'XeJZc', 6, 1133580, 8, N'car-99245', N'red', 1997, CAST(N'2021-02-25 10:03:37.937' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale4')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'xEu2S', 5, 1482569, 0, N'car-86A46', N'blue', 2020, CAST(N'2021-02-25 10:03:38.063' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale3')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'xg3hM', 3, 1567743, 1, N'car-39915', N'red', 2006, CAST(N'2021-02-25 10:03:38.043' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'XS0UH', 5, 290259, 5, N'car-87286', N'yellow', 2013, CAST(N'2021-02-25 10:03:37.993' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale1')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'xYLYh', 5, 553764, 1, N'car-5311A', N'red', 2014, CAST(N'2021-02-25 10:03:38.060' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'ycjhB', 5, 1416945, 3, N'car-2379A', N'yellow', 2012, CAST(N'2021-02-25 10:03:37.973' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale3')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'YK3Ox', 4, 192481, 3, N'car-4336A', N'white', 2021, CAST(N'2021-02-25 10:03:38.047' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale4')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'ymMqK', 5, 688278, 9, N'car-22277', N'blue', 1995, CAST(N'2021-02-25 10:03:37.877' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale4')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'YP69F', 6, 708620, 4, N'car-A4A99', N'black', 2015, CAST(N'2021-02-25 10:03:38.020' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale3')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'ywkTW', 5, 795977, 4, N'car-4887A', N'blue', 2005, CAST(N'2021-02-25 10:03:37.987' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'YZ7xC', 2, 683117, 10, N'car-15523', N'red', 2008, CAST(N'2021-02-25 10:03:37.970' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale1')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'YZIwl', 4, 1544766, 8, N'car-A764A', N'black', 2001, CAST(N'2021-02-25 10:03:38.047' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale4')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'z1HrY', 6, 975057, 2, N'car-20804', N'white', 1998, CAST(N'2021-02-25 10:03:37.927' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale3')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'Z8kbL', 5, 428766, 1, N'car-274A5', N'pink', 2008, CAST(N'2021-02-25 10:03:37.990' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, N'sale2')
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'ZnMI0', 5, 1170275, 0, N'edit-58917', N'pink', 2011, CAST(N'2021-02-25 10:03:38.070' AS DateTime), N'dntlam2000@gmail.com', N'dntlam2000@gmail.com', CAST(N'2021-02-25 15:41:06.000' AS DateTime), 1, N'sale3')
GO
INSERT [dbo].[Product] ([id], [catId], [price], [quantity], [name], [color], [year], [createDate], [userCreate], [userUpdate], [updateDate], [status], [saleId]) VALUES (N'zRqTo', 6, 766004, 0, N'car-53510', N'red', 2002, CAST(N'2021-02-25 10:03:38.063' AS DateTime), N'dntlam2000@gmail.com', NULL, NULL, 1, NULL)
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([orderId])
REFERENCES [dbo].[Orders] ([id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Order_Member] FOREIGN KEY([member])
REFERENCES [dbo].[Member] ([email])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Order_Member]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([catId])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Discount] FOREIGN KEY([saleId])
REFERENCES [dbo].[Discount] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Discount]
GO
USE [master]
GO
ALTER DATABASE [RentalCar] SET  READ_WRITE 
GO
