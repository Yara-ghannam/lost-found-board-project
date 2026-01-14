-- 1. إنشاء قاعدة البيانات
CREATE DATABASE LostFoundDB;
GO

USE LostFoundDB;
GO

-- 2. جدول المستخدمين (سنستخدمه في الـ Login)
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(50) NOT NULL, -- في الواقع يجب أن تكون مشفرة
    Email NVARCHAR(100),
    Role NVARCHAR(20) DEFAULT 'Student' -- Admin or Student
);

-- 3. جدول المواقع (سنستخدمه كبيانات فقط)
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    BuildingName NVARCHAR(100) NOT NULL
);

-- 4. جدول الفئات (إلكترونيات، كتب...)
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL
);

-- 5. جدول المنشورات (سنستخدمه في الـ Dashboard)
CREATE TABLE Posts (
    PostID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100),
    Description NVARCHAR(255),
    Type NVARCHAR(10) CHECK (Type IN ('Lost', 'Found')),
    Status NVARCHAR(20) DEFAULT 'Active', -- Active, Claimed
    DatePosted DATETIME DEFAULT GETDATE(),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    LocationID INT FOREIGN KEY REFERENCES Locations(LocationID),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID)
);

-- 6. جدول المطالبات (هذا الجدول موجود ليكون الديزاين كامل لكن لن نستخدمه بالكود)
CREATE TABLE Claims (
    ClaimID INT PRIMARY KEY IDENTITY(1,1),
    PostID INT FOREIGN KEY REFERENCES Posts(PostID),
    ClaimerUserID INT FOREIGN KEY REFERENCES Users(UserID),
    ClaimDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Pending'
);
GO



-- إضافة مستخدمين
INSERT INTO Users (Username, Password, Email, Role) VALUES 
('admin', '123', 'admin@uni.edu.jo', 'Admin'),
('sereen', '123', 'sereen@uni.edu.jo', 'Student');

-- إضافة مواقع
INSERT INTO Locations (BuildingName) VALUES 
('IT College'), ('Library'), ('Main Cafeteria'), ('Engineering Building');

-- إضافة فئات
INSERT INTO Categories (CategoryName) VALUES 
('Electronics'), ('Books & Papers'), ('Keys'), ('Wallets');

-- إضافة منشورات (أهم جزء عشان تظهر في الشاشة عندك)
INSERT INTO Posts (Title, Description, Type, Status, UserID, LocationID, CategoryID) VALUES 
('Lost iPhone 13', 'Blue cover, lost in lab 3', 'Lost', 'Active', 2, 1, 1),
('Found Calculus Book', 'Found on table 5', 'Found', 'Active', 1, 2, 2);