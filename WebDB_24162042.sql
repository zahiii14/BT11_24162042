USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'WebDB_24162042')
BEGIN
    DROP DATABASE WebDB_24162042;
END
GO

CREATE DATABASE WebDB_24162042;
GO

USE WebDB_24162042;
GO

-- Table: Category
CREATE TABLE Category (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    Categoryname NVARCHAR(100) NOT NULL,
    Categorycode NVARCHAR(100) NULL,
    Images NVARCHAR(500) NULL,
    Status BIT NULL DEFAULT 1
);
GO

-- Table: Users
CREATE TABLE Users (
    Username NVARCHAR(50) PRIMARY KEY,
    Password NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(15) NULL,
    Fullname NVARCHAR(50) NULL,
    Email NVARCHAR(150) NULL,
    Admin BIT NULL DEFAULT 0,
    Active BIT NULL DEFAULT 1,
    Images NVARCHAR(500) NULL,
    Otp NVARCHAR(10) NULL
);
GO

-- Table: Videos
CREATE TABLE Videos (
    VideoId NVARCHAR(50) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Poster NVARCHAR(500) NULL,
    Views INT NULL DEFAULT 0,
    Description NVARCHAR(500) NULL,
    Active BIT NULL DEFAULT 1,
    CategoryId INT FOREIGN KEY REFERENCES Category(CategoryId) ON DELETE SET NULL,
    Price DECIMAL(18,2) NULL DEFAULT 150000.00
);
GO

-- Table: Shares
CREATE TABLE Shares (
    ShareId INT IDENTITY(1,1) PRIMARY KEY,
    Emails NVARCHAR(50) NULL,
    SharedDate DATE NULL,
    Username NVARCHAR(50) FOREIGN KEY REFERENCES Users(Username) ON DELETE CASCADE,
    VideoId NVARCHAR(50) FOREIGN KEY REFERENCES Videos(VideoId) ON DELETE CASCADE
);
GO

-- Table: Favorites
CREATE TABLE Favorites (
    FavoriteId INT IDENTITY(1,1) PRIMARY KEY,
    LikedDate DATE NULL,
    VideoId NVARCHAR(50) FOREIGN KEY REFERENCES Videos(VideoId) ON DELETE CASCADE,
    Username NVARCHAR(50) FOREIGN KEY REFERENCES Users(Username) ON DELETE CASCADE
);
GO

-- Table: Orders
CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) FOREIGN KEY REFERENCES Users(Username) ON DELETE CASCADE,
    OrderDate DATETIME NULL DEFAULT GETDATE(),
    Fullname NVARCHAR(100) NULL,
    Phone NVARCHAR(20) NULL,
    Address NVARCHAR(500) NULL,
    Note NVARCHAR(500) NULL,
    TotalAmount DECIMAL(18,2) NULL DEFAULT 0,
    PaymentMethod NVARCHAR(50) NULL DEFAULT N'COD',
    Status NVARCHAR(50) NOT NULL DEFAULT N'Đơn hàng mới'
);
GO

-- Table: OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT FOREIGN KEY REFERENCES Orders(OrderId) ON DELETE CASCADE,
    VideoId NVARCHAR(50) FOREIGN KEY REFERENCES Videos(VideoId),
    Price DECIMAL(18,2) NULL,
    Quantity INT NULL,
    Amount DECIMAL(18,2) NULL
);
GO

-- INSERT SAMPLE DATA

-- Categories
INSERT INTO Category (Categoryname, Categorycode, Images, Status) VALUES
(N'Âm Nhạc', 'MUSIC', 'https://picsum.photos/300/200?random=1', 1),
(N'Phim Ảnh', 'MOVIE', 'https://picsum.photos/300/200?random=2', 1),
(N'Thể Thao', 'SPORT', 'https://picsum.photos/300/200?random=3', 1),
(N'Công Nghệ', 'TECH', 'https://picsum.photos/300/200?random=4', 1);

-- Users (15 users for testing pagination 6 per page)
INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images) VALUES
('admin', '123', '0901234567', N'Quản Trị Viên', 'admin@gmail.com', 1, 1, 'https://i.pravatar.cc/150?img=1'),
('user1', '123', '0912345678', N'Nguyễn Văn A', 'user1@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=2'),
('user2', '123', '0923456789', N'Trần Thị B', 'user2@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=3'),
('user3', '123', '0934567890', N'Lê Văn C', 'user3@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=4'),
('user4', '123', '0945678901', N'Phạm Thị D', 'user4@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=5'),
('user5', '123', '0956789012', N'Hoàng Văn E', 'user5@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=6'),
('user6', '123', '0967890123', N'Đỗ Thị F', 'user6@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=7'),
('user7', '123', '0978901234', N'Vũ Văn G', 'user7@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=8'),
('user8', '123', '0989012345', N'Bùi Thị H', 'user8@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=9'),
('user9', '123', '0990123456', N'Đặng Văn I', 'user9@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=10'),
('user10', '123', '0909876543', N'Nô Thị K', 'user10@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=11'),
('user11', '123', '0918765432', N'Đinh Văn L', 'user11@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=12'),
('user12', '123', '0927654321', N'Trịnh Thị M', 'user12@gmail.com', 0, 1, 'https://i.pravatar.cc/150?img=13');

-- Videos (Multiple videos per category with Price)
INSERT INTO Videos (VideoId, Title, Poster, Views, Description, Active, CategoryId, Price) VALUES
('V01', N'Sơn Tùng M-TP - Lạc Trôi', 'https://picsum.photos/400/250?random=11', 1500, N'Music Video hit của Sơn Tùng M-TP', 1, 1, 150000.00),
('V02', N'Đen Vâu - Trốn Tìm ft. MTV band', 'https://picsum.photos/400/250?random=12', 1200, N'Bài hát chill nổi tiếng của Đen Vâu', 1, 1, 120000.00),
('V03', N'Hoàng Thùy Linh - See Tình', 'https://picsum.photos/400/250?random=13', 2500, N'Ca khúc gây bão toàn thế giới', 1, 1, 200000.00),
('V04', N'Mỹ Tâm - Hẹn Ước Từ Hư Vô', 'https://picsum.photos/400/250?random=14', 980, N'Live show Tri Âm Mỹ Tâm', 1, 1, 180000.00),
('V05', N'Hòa Minzy - Thị Mầu', 'https://picsum.photos/400/250?random=15', 850, N'Ca khúc mang âm hưởng chèo dân gian', 1, 1, 130000.00),
('V06', N'Vũ - Bước Qua Nhau', 'https://picsum.photos/400/250?random=16', 1100, N'Bản ballad nhẹ nhàng sâu lắng', 1, 1, 140000.00),
('V07', N'Jack - J97 - Lót Ly', 'https://picsum.photos/400/250?random=17', 500, N'Sản phẩm âm nhạc mới', 1, 1, 110000.00),
('V08', N'Mai - Phim Trấn Thành', 'https://picsum.photos/400/250?random=18', 3500, N'Bộ phim điện ảnh doanh thu kỷ kỷ lục', 1, 2, 250000.00),
('V09', N'Lật Mặt 7: Một Điều Ước', 'https://picsum.photos/400/250?random=19', 4200, N'Phim gia đình xúc động của Lý Hải', 1, 2, 220000.00),
('V10', N'Đất Rừng Phương Nam', 'https://picsum.photos/400/250?random=20', 1800, N'Phim chuyển thể từ tác phẩm văn học', 1, 2, 190000.00);

-- Favorites (Likes)
INSERT INTO Favorites (LikedDate, VideoId, Username) VALUES
('2026-09-01', 'V01', 'user1'), ('2026-09-02', 'V01', 'user2'), ('2026-09-03', 'V01', 'user3'), ('2026-09-04', 'V01', 'user4'),
('2026-09-01', 'V02', 'user1'), ('2026-09-02', 'V02', 'user5'),
('2026-09-01', 'V08', 'user2'), ('2026-09-02', 'V08', 'user3'), ('2026-09-03', 'V08', 'user6');

-- Shares
INSERT INTO Shares (Emails, SharedDate, Username, VideoId) VALUES
('friend1@gmail.com', '2026-09-01', 'user1', 'V01'),
('friend2@gmail.com', '2026-09-02', 'user2', 'V01'),
('friend3@gmail.com', '2026-09-03', 'user3', 'V01'),
('friend4@gmail.com', '2026-09-04', 'user1', 'V08');

-- Sample Orders for testing 8 status filters
INSERT INTO Orders (Username, OrderDate, Fullname, Phone, Address, Note, TotalAmount, PaymentMethod, Status) VALUES
('user1', '2026-09-25 10:00:00', N'Nguyễn Văn A', '0912345678', N'123 Lê Văn Việt, TP. Thủ Đức, TP.HCM', N'Giao giờ hành chính', 270000.00, 'COD', N'Đơn hàng mới'),
('user1', '2026-09-24 14:30:00', N'Nguyễn Văn A', '0912345678', N'123 Lê Văn Việt, TP. Thủ Đức, TP.HCM', N'Gọi trước khi giao', 200000.00, 'COD', N'Đã xác nhận'),
('user1', '2026-09-23 09:15:00', N'Nguyễn Văn A', '0912345678', N'123 Lê Văn Việt, TP. Thủ Đức, TP.HCM', N'', 450000.00, 'COD', N'Chuẩn bị hàng'),
('user1', '2026-09-22 16:45:00', N'Nguyễn Văn A', '0912345678', N'123 Lê Văn Việt, TP. Thủ Đức, TP.HCM', N'', 350000.00, 'COD', N'Vận chuyển'),
('user1', '2026-09-21 08:20:00', N'Nguyễn Văn A', '0912345678', N'123 Lê Văn Việt, TP. Thủ Đức, TP.HCM', N'Cẩn thận hàng dễ vỡ', 150000.00, 'COD', N'Giao hàng'),
('user1', '2026-09-20 11:10:00', N'Nguyễn Văn A', '0912345678', N'123 Lê Văn Việt, TP. Thủ Đức, TP.HCM', N'Đã xong', 390000.00, 'COD', N'Đã giao'),
('user1', '2026-09-19 13:00:00', N'Nguyễn Văn A', '0912345678', N'123 Lê Văn Việt, TP. Thủ Đức, TP.HCM', N'Đổi ý không mua', 120000.00, 'COD', N'Đơn hàng hủy'),
('user1', '2026-09-18 15:30:00', N'Nguyễn Văn A', '0912345678', N'123 Lê Văn Việt, TP. Thủ Đức, TP.HCM', N'Hàng bị lỗi vỏ hộp', 250000.00, 'COD', N'Đơn hàng hoàn');

-- Sample Order Details
INSERT INTO OrderDetails (OrderId, VideoId, Price, Quantity, Amount) VALUES
(1, 'V01', 150000.00, 1, 150000.00),
(1, 'V02', 120000.00, 1, 120000.00),
(2, 'V03', 200000.00, 1, 200000.00),
(3, 'V08', 250000.00, 1, 250000.00),
(3, 'V03', 200000.00, 1, 200000.00),
(4, 'V08', 250000.00, 1, 250000.00),
(4, 'V07', 110000.00, 1, 110000.00),
(5, 'V01', 150000.00, 1, 150000.00),
(6, 'V09', 220000.00, 1, 220000.00),
(6, 'V05', 130000.00, 1, 130000.00),
(7, 'V02', 120000.00, 1, 120000.00),
(8, 'V08', 250000.00, 1, 250000.00);

PRINT 'Database WebDB_24162042 initialized successfully!';
GO
VALUES
('friend1@gmail.com', '2026-09-01', 'user1', 'V01'),
('friend2@gmail.com', '2026-09-02', 'user2', 'V01'),
('friend3@gmail.com', '2026-09-03', 'user3', 'V01'),
('friend4@gmail.com', '2026-09-04', 'user1', 'V08');

PRINT 'Database WebDB_24162042 initialized successfully!';
GO
