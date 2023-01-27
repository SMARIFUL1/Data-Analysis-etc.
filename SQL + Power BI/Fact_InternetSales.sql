/****** Cleansed fact_InternetSales table ******/
SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey] 
  --,[PromotionKey]
  --,[CurrencyKey]
  --,[SalesTerritoryKey]
  , 
  [SalesOrderNumber] 
  --,[SalesOrderLineNumber]
  --,[RevisionNumber]
  --,[OrderQuantity]
  --,[UnitPrice]
  --,[ExtendedAmount]
  --,[UnitPriceDiscountPct]
  --,[DiscountAmount]
  --,[ProductStandardCost]
  --,[TotalProductCost]
  , 
  [SalesAmount] 
  --,[TaxAmt]
  --,[Freight]
  -- ,[CarrierTrackingNumber]
  --,[CustomerPONumber]
  -- ,[OrderDate]
  -- ,[DueDate]
  -- ,[ShipDate]
FROM 
  [dbo].[FactInternetSales] 
WHERE 
  LEFT(OrderDateKey, 4) >= Year(GETDATE()) -2 --ensures we always only bring two years of date extraction
ORDER BY 
  OrderDateKey ASC
