
select *
from [PizzaDB].[dbo].[pizza_sales]

--To see total revenue for the company

SELECT SUM([total_price]) AS Total_wordRevenue
FROM [PizzaDB].[dbo].[pizza_sales]

--Average order

SELECT SUM([total_price])/ COUNT(DISTINCT [order_id]) AS Avg_Order   
FROM [PizzaDB].[dbo].[pizza_sales]

--Total Pizza sold

SELECT SUM ([quantity]) AS Total_Pizza_Sold
FROM [PizzaDB].[dbo].[pizza_sales]


--Total ordered ID

SELECT COUNT(DISTINCT order_id) AS Total_Ordered_ID
FROM [PizzaDB].[dbo].[pizza_sales]


--Average Pizza order per ID

SELECT CAST (CAST(SUM(quantity) AS decimal(10,2)) / 
       CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2)) AS Avg_Pizza_per_Order
FROM [PizzaDB].[dbo].[pizza_sales]


--For daily trend

--[Datename argument is used to find out the day of the week from given date--
--DW means Date of Week which is used to convert order day into string then we can retrieve datename--]

SELECT DATENAME(DW, order_date) AS Week_Days, COUNT(DISTINCT order_id) AS Pizza_Orders
FROM [PizzaDB].[dbo].[pizza_sales]
GROUP BY DATENAME(DW, order_date)


--For Hourly trend i.e. which hour is best for pizza selling-
--DATEPART argument is used for retrieving hour from order_time--

SELECT DATEPART(HOUR, order_time) AS Order_Hours, COUNT(DISTINCT order_id) AS Pizza_Orders
FROM [PizzaDB].[dbo].[pizza_sales]
Group by DATEPART(HOUR, order_time)
order by Pizza_Orders Desc


--Pizza sales and their Percentage per Category

SELECT pizza_category,SUM(total_price) AS Total_Sales, SUM(total_price)*100/ 
(SELECT SUM(total_price) FROM [PizzaDB].[dbo].[pizza_sales] ) AS Perctange
FROM [PizzaDB].[dbo].[pizza_sales]
--WHERE MONTH(order_date) = 2            --To see the month of feb use 2
--WHERE DATEPART(QUARTER, order_date)=1  --To see the first quarter use 1
Group by pizza_category


--Pizza sales by their Size

SELECT pizza_size, COUNT(pizza_size) AS total_sold
FROM [PizzaDB].[dbo].[pizza_sales]
--WHERE MONTH(order_date) = 2            --To see the month of feb use 2
--WHERE DATEPART(QUARTER, order_date)=1  --To see the first quarter use 1
GROUP BY pizza_size
ORDER BY 2 DESC


--Pizza sales percentage for first quarter based on pizza_size—

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales, CAST(SUM(total_price)*100/ 
(SELECT SUM(total_price) FROM [PizzaDB].[dbo].[pizza_sales]  WHERE DATEPART(QUARTER, order_date)=1) AS DECIMAL(10,2)) AS Percentage
FROM [PizzaDB].[dbo].[pizza_sales]
--WHERE MONTH(order_date) = 2            --To see the month of feb use 2
WHERE DATEPART(QUARTER, order_date)=1  --To see the first quarter use 1
Group BY pizza_size
ORDER BY Percentage DESC


--Total pizza sold per Category

SELECT pizza_category, SUM(quantity) as Total_Pizza_sold
FROM [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_category


--Top 10 best selling Pizza

SELECT TOP(10) pizza_name, SUM(quantity) as Total_Pizza_sold
FROM [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY 2 DESC

--Lowest 10 selling Pizza 

SELECT TOP(10) pizza_name, SUM(quantity) as Total_Pizza_sold
FROM [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY 2

