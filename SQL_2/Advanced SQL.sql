
/****** Advanced SQL queries  ******/

--To find all the employee who have base rate more than average base rate


SELECT [FirstName]+[LastName] AS Full_Name
      ,[Gender]
	  ,[BaseRate]
      ,[DepartmentName]
      ,[StartDate]
  FROM [AdventureWorksDW2019].[dbo].[DimEmployee]
  Where BaseRate > (Select AVG(BaseRate) FROM DimEmployee)
  ORDER BY 3 DESC

  --To find all the employee from IT department who have base rate more than average base rate in IT

Select  [FirstName]+[LastName] AS Full_Name
       ,[BaseRate]
	   ,[DepartmentName]
FROM [dbo].[DimEmployee]
Where BaseRate > (Select avg([BaseRate]) FROM [dbo].[DimEmployee] WHERE [DepartmentName] ='Information Services')
ORDER BY 2 DESC



--Stored Procedure

CREATE Procedure Expensive_Products
AS
BEGIN
SELECT [ProductKey]
      ,[EnglishProductName] AS Product_Name
      ,[StandardCost]
      ,[ListPrice]
      ,[DealerPrice]
FROM [AdventureWorksDW2019].[dbo].[DimProduct]
Where [StandardCost] IS NOT NULL and [StandardCost] >=1000
ORDER BY 3 asc

END

--To run the statement inside stored procedure

EXEC Expensive_Products;

--#2 stored procedure

CREATE Procedure Products_name_price
AS
BEGIN
SELECT [Name]
      ,[UnitPrice]
FROM [AdventureWorksLT2019].[SalesLT].[SalesOrderDetail]
JOIN [AdventureWorksLT2019].[SalesLT].[Product] ON
[AdventureWorksLT2019].[SalesLT].[SalesOrderDetail].[ProductID] =[AdventureWorksLT2019].[SalesLT].[Product].[ProductID]
ORDER BY UnitPrice desc

END

exec Products_name_price

--Create temporary table and push all the values from SP table

CREATE TABLE Top_products(
    Name varchar(255),
    UnitPrice int)     --make price int instead of float

INSERT INTO Top_products
exec Products_name_price

--Now we can select desired number of records from our stored table Products_name_price

Select Top (10) *
FROM Top_products


--to see those records who are female and getting top salary regarding others criterion

SELECT[FirstName]+[LastName] AS Full_Name
      ,[Gender]
      ,[YearlyIncome]
      ,[EnglishEducation] AS Education
      ,[EnglishOccupation] AS Occupation
      ,[CommuteDistance]
FROM [AdventureWorksDW2019].[dbo].[DimCustomer]
Where YearlyIncome >=150000 and Gender='F'
ORDER BY 4,3 desc


--Views in SQL

