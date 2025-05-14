
-- إنشاء قاعدة البيانات والجداول
CREATE DATABASE BankManagement;
USE BankManagement;

-- جدول العملاء
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address TEXT,
    JoinDate DATE
);

-- جدول الفروع
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Location VARCHAR(100),
    Phone VARCHAR(20)
);

-- جدول الموظفين
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Role VARCHAR(50)
);

-- جدول الحسابات
CREATE TABLE Account (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    BranchID INT,
    Balance DECIMAL(12, 2),
    OpenDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

-- جدول المعاملات
CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    Type VARCHAR(50),
    Amount DECIMAL(10, 2),
    Date DATE,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- إنشاء مستخدمين وصلاحيات
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpass';
CREATE USER 'data_entry'@'localhost' IDENTIFIED BY 'entrypass';
CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'analystpass';

GRANT ALL PRIVILEGES ON BankManagement.* TO 'admin_user'@'localhost';
GRANT INSERT, SELECT ON BankManagement.Customer TO 'data_entry'@'localhost';
GRANT SELECT ON BankManagement.* TO 'analyst'@'localhost';

-- بيانات جدول العملاء
INSERT INTO Customer (Name, Email, Phone, Address, JoinDate) VALUES
('Ali Hassan', 'ali@example.com', '01012345678', 'Cairo', '2023-01-01'),
('Mona Salem', 'mona@example.com', '01098765432', 'Giza', '2023-02-15'),
('Youssef Kamal', 'youssef@example.com', '01122334455', 'Alexandria', '2023-03-10'),
('Sara Nabil', 'sara@example.com', '01234567890', 'Mansoura', '2023-04-20'),
('Ahmed Tarek', 'ahmed@example.com', '01199887766', 'Suez', '2023-05-12'),
('Nadia Osama', 'nadia@example.com', '01066778899', 'Cairo', '2023-06-30'),
('Khaled Samir', 'khaled@example.com', '01233445566', 'Tanta', '2023-07-18'),
('Layla Fathi', 'layla@example.com', '01144556677', 'Aswan', '2023-08-22'),
('Mahmoud Saad', 'mahmoud@example.com', '01055667788', 'Luxor', '2023-09-11'),
('Hanan Ali', 'hanan@example.com', '01277889900', 'Cairo', '2023-10-05');

-- بيانات جدول الفروع
INSERT INTO Branch (Name, Location, Phone) VALUES
('Main Branch', 'Cairo', '0221234567'),
('Giza Branch', 'Giza', '0231234567'),
('Alex Branch', 'Alexandria', '0341234567'),
('Delta Branch', 'Mansoura', '0501234567'),
('Upper Egypt Branch', 'Luxor', '0951234567'),
('South Branch', 'Aswan', '0971234567'),
('Suez Branch', 'Suez', '0621234567'),
('Port Said Branch', 'Port Said', '0661234567'),
('Tanta Branch', 'Tanta', '0401234567'),
('Zagazig Branch', 'Zagazig', '0551234567');

-- بيانات جدول الموظفين
INSERT INTO Employee (Name, Email, Phone, Role) VALUES
('Hani Youssef', 'hani@bank.com', '01012341111', 'Manager'),
('Dina Sami', 'dina@bank.com', '01112342222', 'Teller'),
('Omar Khaled', 'omar@bank.com', '01212343333', 'Auditor'),
('Marwa Adel', 'marwa@bank.com', '01312344444', 'IT'),
('Tarek Helmy', 'tarek@bank.com', '01412345555', 'HR'),
('Rania Yasser', 'rania@bank.com', '01512346666', 'Support'),
('Kareem Fouad', 'kareem@bank.com', '01612347777', 'Manager'),
('Nour Alaa', 'nour@bank.com', '01712348888', 'Teller'),
('Hesham Reda', 'hesham@bank.com', '01812349999', 'Auditor'),
('Mira Emad', 'mira@bank.com', '01912340000', 'Support');

-- بيانات جدول الحسابات
INSERT INTO Account (CustomerID, BranchID, Balance, OpenDate) VALUES
(1, 1, 5000.00, '2023-01-01'),
(2, 2, 10000.00, '2023-02-20'),
(3, 3, 7500.00, '2023-03-25'),
(4, 4, 3000.00, '2023-04-15'),
(5, 5, 8500.00, '2023-05-10'),
(6, 6, 9200.00, '2023-06-05'),
(7, 7, 11000.00, '2023-07-08'),
(8, 8, 15000.00, '2023-08-16'),
(9, 9, 2000.00, '2023-09-09'),
(10, 10, 6400.00, '2023-10-01');

-- بيانات جدول المعاملات
INSERT INTO Transaction (AccountID, Type, Amount, Date) VALUES
(1, 'Deposit', 1000, '2023-01-02'),
(2, 'Withdrawal', 500, '2023-02-21'),
(3, 'Deposit', 1500, '2023-03-26'),
(4, 'Withdrawal', 300, '2023-04-16'),
(5, 'Deposit', 2500, '2023-05-11'),
(6, 'Withdrawal', 800, '2023-06-06'),
(7, 'Deposit', 3000, '2023-07-09'),
(8, 'Withdrawal', 1200, '2023-08-17'),
(9, 'Deposit', 400, '2023-09-10'),
(10, 'Withdrawal', 1000, '2023-10-02');

-- استعلامات مطلوبة
-- 1. بحث عن العملاء بالاسم
SELECT * FROM Customer WHERE Name LIKE '%Ali%';

-- 2. مجموع المبالغ حسب نوع المعاملة
SELECT Type, SUM(Amount) AS TotalAmount FROM Transaction GROUP BY Type;

-- 3. ترتيب الحسابات تنازليًا حسب الرصيد
SELECT * FROM Account ORDER BY Balance DESC;

-- 4. المعاملات لحساب معين بترتيب تصاعدي
SELECT * FROM Transaction WHERE AccountID = 2 ORDER BY Date ASC;

-- 5. عدد الحسابات لكل فرع
SELECT Branch.Name, COUNT(AccountID) AS TotalAccounts
FROM Account
JOIN Branch ON Account.BranchID = Branch.BranchID
GROUP BY Branch.Name;
