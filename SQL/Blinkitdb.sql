CREATE DATABASE Blinkit_db;
use Blinkit_db;
create table Sales(
Order_id varchar(50) primary key,
Order_date date,
Item_id varchar(50),
Outlet_id varchar(50),
Quantity_Sold int,
MRP decimal(10),
Discount_Percentage int,
Sales_Amount decimal(10),
Delivery_time_min int,
Payment_Mode varchar(50),
Customer_Rating int);

create table Outlets(
Outlet_id varchar(50) primary key,
Outlet_Name Varchar(100),
City varchar(50),
Location_Tier varchar(50),
Outlet_Size varchar(50),
Outlet_Type varchar(50),
Establisment_Year year);

create table Items(
Item_id varchar(50) primary key,
Item_Name varchar(50),
Category varchar(50),
Brand varchar(50),
MRP decimal,
Pack_Size varchar(50),
Fat_Content varchar(50),
Shelf_life_days int);

ALTER TABLE Items
ADD PRIMARY KEY (Item_id);

ALTER TABLE Sales
ADD CONSTRAINT FK_Sales_Items
FOREIGN KEY (Item_id)
REFERENCES Items(Item_id);

ALTER TABLE Sales
ADD CONSTRAINT FK_Sales_Outlets
FOREIGN KEY (Outlet_ID)
REFERENCES Outlets(Outlet_ID);

SELECT
    s.Order_ID,
    i.Item_Name,
    o.Outlet_Name,
    s.Quantity_Sold,
    s.Sales_Amount
FROM Sales s
JOIN Items i
    ON s.Item_ID = i.Item_ID
JOIN Outlets o
    ON s.Outlet_ID = o.Outlet_ID
LIMIT 10;

select sum(Sales_Amount) as Total_Revenue
from Sales;

SELECT
    i.Item_Name,
    SUM(s.Quantity_Sold) AS Quantity
FROM Sales s
JOIN Items i
ON s.Item_ID = i.Item_ID
GROUP BY i.Item_Name
ORDER BY Quantity DESC
LIMIT 10;

SELECT
    o.City,
    SUM(s.Sales_Amount) AS Revenue
FROM Sales s
JOIN Outlets o
ON s.Outlet_ID = o.Outlet_ID
GROUP BY o.City
ORDER BY Revenue DESC;

SELECT
    o.Outlet_Name,
    SUM(s.Sales_Amount) AS Revenue
FROM Sales s
JOIN Outlets o
ON s.Outlet_ID = o.Outlet_ID
GROUP BY o.Outlet_Name
ORDER BY Revenue DESC;

CREATE VIEW vw_sales_analysis AS
SELECT
    s.Order_ID,
    s.Order_Date,
    i.Item_Name,
    i.Category,
    i.Brand,
    o.Outlet_Name,
    o.City,
    s.Quantity_Sold,
    s.Sales_Amount
FROM Sales s
JOIN Items i
ON s.Item_ID = i.Item_ID
JOIN Outlets o
ON s.Outlet_ID = o.Outlet_ID;














