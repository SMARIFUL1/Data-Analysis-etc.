/****** Some sql queries from basic to intermediate in SSMS  ******/

#1
SELECT max([Quantity]) AS MaximumQuantity
  FROM [Project_1].[dbo].[TR_OrderDetails]

#2
SELECT MIN(Quantity) AS MinimunQuantity
FROM Project_1.dbo.TR_OrderDetails

#3

SELECT DISTINCT PRODUCTID, Quantity
FROM Project_1.dbo.TR_OrderDetails
WHERE Quantity = 3
ORDER BY PRODUCTID ASC, Quantity DESC

#4
SELECT DISTINCT PROPERTYID
FROM Project_1.dbo.TR_OrderDetails

#5 --to find the product category that has maximum products:

SELECT ProductCategory, COUNT(*) AS TOTAL
FROM [dbo].[TR_Products]
GROUP BY ProductCategory
ORDER BY TOTAL DESC

#6 --to find state where most stores are present

SELECT PropertyState, count(*)
FROM [dbo].[TR_PropertyInfo]
GROUP BY PropertyState
ORDER BY 2 DESC

#7 --to find top 5 product ids that did maximum sales in terms of quantity

ALTER TABLE [dbo].[TR_OrderDetails]
ALTER COLUMN QUANTITY INT --To convert Quantity column from nvarchar to INT

SELECT TOP (5) ProductID, SUM(Quantity) AS TOTAL_SALES
FROM [dbo].[TR_OrderDetails]
GROUP BY ProductID
ORDER BY 2 DESC

NOTE: Instead of limit statement I have used top statement to find my particular number.

#8 --to find top 5 property IDs that did maximum quanity

SELECT TOP (5) PropertyID, SUM(Quantity) AS Total_Sales
FROM [dbo].[TR_OrderDetails]
GROUP BY PropertyID
ORDER BY Total_Sales DESC

#9 --to JOIN two tables

ALTER TABLE [Project_1].[dbo].[TR_Products]
ALTER COLUMN Price INT

SELECT O.[OrderID]
      ,O.[OrderDate]
      ,O.[PropertyID]
      ,O.[Quantity]
	  ,O.ProductID
	  ,P.[ProductName]
      ,P.[ProductCategory]
      ,P.[Price]
FROM [Project_1].[dbo].[TR_OrderDetails] AS O
LEFT JOIN [Project_1].[dbo].[TR_Products] AS P
ON O.[ProductID] = P.[ProductID]
ORDER BY 8 DESC

#10 --to find top 5 product names that max. sales in terms of quantity

SELECT TOP (5)
       P.[ProductName]
      , SUM(O.Quantity) AS Total_Quantity
FROM [Project_1].[dbo].[TR_OrderDetails] AS O
LEFT JOIN [Project_1].[dbo].[TR_Products] AS P
ON O.[ProductID] = P.[ProductID]
GROUP BY P.[ProductName]
ORDER BY 2 DESC

#11 --TO find top 5 products that did maximum sales

SELECT TOP (5)
       P.[ProductName]
      , SUM(O.Quantity * P.Price) AS Sales
FROM [Project_1].[dbo].[TR_OrderDetails] AS O
LEFT JOIN [Project_1].[dbo].[TR_Products] AS P
ON O.[ProductID] = P.[ProductID]
GROUP BY  P.[ProductName]
ORDER BY 2 DESC

#12 --to find top 5 cities that maximum sales

SELECT TOP (5)
       PI.[PropertyCity]
      , SUM(O.Quantity * P.Price) AS Sales
FROM [Project_1].[dbo].[TR_OrderDetails] AS O
LEFT JOIN [Project_1].[dbo].[TR_Products] AS P ON O.[ProductID] = P.[ProductID]
LEFT JOIN [Project_1].[dbo].[TR_PropertyInfo] AS PI ON O.[PropertyID] = PI.[Prop ID]
GROUP BY  PI.[PropertyCity]
ORDER BY 2 DESC

#13 --to find products in specific city 

SELECT PI.[PropertyCity]
	   ,P.[Productname]
       ,SUM(O.Quantity * P.Price) AS Sales
FROM [Project_1].[dbo].[TR_OrderDetails] AS O
LEFT JOIN [Project_1].[dbo].[TR_Products] AS P ON O.[ProductID] = P.[ProductID]
LEFT JOIN [Project_1].[dbo].[TR_PropertyInfo] AS PI ON O.[PropertyID] = PI.[Prop ID]
WHERE PI.[PropertyCity] = 'Arlington'
GROUP BY  PI.[PropertyCity],P.[Productname]
ORDER BY 3 DESC
