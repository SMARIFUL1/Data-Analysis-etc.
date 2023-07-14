/****** Some advanced SQL command from SSMS  ******/


SELECT *
  FROM [Unique].[dbo].[sales_data_sample]


Select distinct STATUS
From [Unique].[dbo].[sales_data_sample]

Select distinct YEAR_ID
From [Unique].[dbo].[sales_data_sample]


--Since in 2005 they had less revenue so need to check that how many months they had completed--
Select distinct MONTH_ID
From [Unique].[dbo].[sales_data_sample]
Where YEAR_ID = 2005


Select PRODUCTLINE, SUM(SALES) AS Revenue
From [Unique].[dbo].[sales_data_sample]
Group by PRODUCTLINE
Order by 2 desc

Select DEALSIZE, SUM(SALES) AS Revenue
From [Unique].[dbo].[sales_data_sample]
Group by DEALSIZE
Order by 2 desc

--to check best month for the sales for a specific year--
Select MONTH_ID, SUM(SALES) AS Revenue, count(ORDERNUMBER) AS Frequency
From [Unique].[dbo].[sales_data_sample]
Where YEAR_ID = 2005
Group by MONTH_ID
Order by 2 desc

--Since November is the best selling month, so want to see which product they sold most--
Select MONTH_ID, PRODUCTLINE, SUM(SALES) AS Revenue, count(ORDERNUMBER) AS Frequency
From [Unique].[dbo].[sales_data_sample]
Where MONTH_ID = 11 AND YEAR_ID = 2003
Group by MONTH_ID, PRODUCTLINE 
Order by 4 desc


/****** RFM analysis to segment the customers
  R = recency (how long ago their last purchase was) 
  F = frequency(how often they purchase), and
  M = monetary (how much they spent) ******/


DROP TABLE IF exists #RFM

;with RFM as
(
	SELECT CUSTOMERNAME,
		 SUM(SALES) AS Monetary_Value,
		 AVG(SALES) AS Avg_Monetary_Value,
		 COUNT(ORDERNUMBER) AS Frequency,
		 MAX(ORDERDATE) AS Last_Order_date,
		 (Select MAX(Orderdate) from [Unique].[dbo].[sales_data_sample]) AS MAX_Order_date,
		 DATEDIFF(DD, MAX(Orderdate),(Select MAX(Orderdate) from [Unique].[dbo].[sales_data_sample])) AS Recency
	From [Unique].[dbo].[sales_data_sample]
	Group by CUSTOMERNAME
),
RFM_calc as
(
	SELECT r.*,
		NTILE(4) OVER (ORDER BY RECENCY desc) RFM_Recency,
		NTILE(4) OVER (ORDER BY Frequency) RFM_Frequency,
		NTILE(4) OVER (ORDER BY Monetary_Value) RFM_Monetary
	FROM RFM r
)
SELECT 
	c.*, RFM_Recency+RFM_Frequency+RFM_Monetary AS RFM_cell,
	CAST(RFM_Recency AS varchar)+CAST(RFM_Frequency AS varchar)+CAST(RFM_Monetary AS varchar) AS RFM_string_cell
into #RFM
FROM RFM_calc c

--local temp table #RFM

SELECT CUSTOMERNAME,RFM_Recency,RFM_Frequency,RFM_Monetary,
     CASE 
	      When RFM_string_cell in (111,112,113,114,121,122,123,124,132,131,141,142,143,211,212) THEN 'lost_cutomers'
    	  When RFM_string_cell in (133,134,143,144,244,334,343,344) THEN 'slipping_away'
		  When RFM_string_cell in (311,411,412,421,422,331) THEN 'new_cutomers'
		  When RFM_string_cell in (221,222,223,232,233,234,322,332,333,423) THEN 'potential_cutomers'
		  When RFM_string_cell in (433,434,443,444) THEN 'loyal'
	 end RFM_segment
FROM #RFM


--NTILE() in Standard Query Language (SQL) is a window function that is used to divide sorted rows of a partition into a specified number of equal size buckets or group



--which products are often sell together

SELECT Distinct ORDERNUMBER, STUFF(
	(SELECT ','+ PRODUCTCODE
	FROM [Unique].[dbo].[sales_data_sample] p
	WHERE ORDERNUMBER in
	(
		SELECT ORDERNUMBER
		FROM(
			SELECT ORDERNUMBER, COUNT(*) rn
			FROM [Unique].[dbo].[sales_data_sample]
			WHERE STATUS = 'shipped'
			GROUP BY ORDERNUMBER
		)m
		where rn =2
		and p.ORDERNUMBER = s.ORDERNUMBER
	)for xml path ('')), 
1,1,'') AS ProductCodes
FROM [Unique].[dbo].[sales_data_sample] s
ORDER BY 2 desc



--To see which city of GERMANY ordered most

Select CITY,COUNT(*) rn, SUM(QUANTITYORDERED) AS Ordered_quantity
From [Unique].[dbo].[sales_data_sample]
WHERE COUNTRY = 'GERMANY' and STATUS = 'Shipped'
GROUP BY CITY

