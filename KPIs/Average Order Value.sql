-- Average Order Value (AOV)
SELECT
	CASE
		WHEN SUM(OrderAmount) = 0 THEN 0
		ELSE SUM(TotalRevenue)* 1.0 / SUM(OrderAmount)
	END AS CompanyAOV
FROM vw_StoreSalesSummary