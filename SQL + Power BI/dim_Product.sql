/****** Cleansed Dim_Product table ******/
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] AS ProductItemCode, 
  --,[ProductSubcategoryKey]
  --[WeightUnitMeasureCode]
  --,[SizeUnitMeasureCode]
  p.[EnglishProductName] AS ProductName, 
  ps.[EnglishProductSubcategoryName] AS [Sub Category], --joined in from dimSubcategory table
  pc.[EnglishProductCategoryName] AS [Product Category], --joined in from dimCategory table
  --,[SpanishProductName]
  --,[FrenchProductName]
  --,[StandardCost]
  --,[FinishedGoodsFlag]
  p.[Color] AS ProductColor, 
  --,[SafetyStockLevel]
  --,[ReorderPoint]
  --,[ListPrice]
  p.[Size] As ProductSize, 
  --,[SizeRange]
  --,[Weight]
  --,[DaysToManufacture]
  p.[ProductLine] AS ProductLine, 
  --,[DealerPrice]
  --,[Class]
  --,[Style]
  p.[ModelName] AS ProductModelName, 
  --,[LargePhoto]
  p.[EnglishDescription] AS ProductDescription, 
  --,[FrenchDescription]
  --,[ChineseDescription]
  --,[ArabicDescription]
  --,[HebrewDescription]
  --,[ThaiDescription]
  --,[GermanDescription]
  --,[JapaneseDescription]
  --,[TurkishDescription]
  --,[StartDate]
  --,[EndDate]
  --,[Status]
  ISNULL(p.Status, 'Outdated') AS ProductStatus --to make null values into Outdated
FROM 
  [dbo].[DimProduct] AS p 
  LEFT JOIN [dbo].[DimProductSubcategory] AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN [dbo].[DimProductCategory] AS pc ON pc.ProductCategoryKey = ps.ProductCategoryKey 
ORDER BY 
  p.ProductKey ASC    --ordered them by productkey
