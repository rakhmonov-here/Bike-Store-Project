-- Sales by Brand
SELECT
    brand_name,
    SUM(TotalQuantitySold) AS TotalUnitsSold,
    SUM(TotalSales) AS TotalRevenue
FROM vw_TopSellingProducts
GROUP BY brand_name
ORDER BY TotalRevenue DESC;
