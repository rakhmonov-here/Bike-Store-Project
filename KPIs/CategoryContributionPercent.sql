-- CategoryContributionPercent
SELECT
    category_id,
	category_name,
	TotalQuantity,
    CAST((TotalSales/ SUM(TotalSales) OVER()) * 100 AS DECIMAL(5,2)) AS CategoryContributionPercent
FROM vw_SalesByCategory
ORDER BY CategoryContributionPercent DESC

