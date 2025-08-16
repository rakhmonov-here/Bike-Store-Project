-- Revenue by Store
SELECT
    store_id,
    store_name,
    TotalRevenue
FROM vw_StoreSalesSummary
ORDER BY TotalRevenue DESC

