-- Staff Revenue Contribution
SELECT
    StaffName,
    store_name,
    OrdersHandled,
    RevenueHandled,
    CAST((RevenueHandled / SUM(RevenueHandled) OVER()) * 100 AS DECIMAL(5,2)) AS RevenueContributionPercent
FROM vw_StaffPerformance
ORDER BY RevenueHandled DESC
