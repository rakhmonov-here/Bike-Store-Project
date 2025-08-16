-- sp_CompareSalesYearOverYear: Compare sales between two years

CREATE PROCEDURE sp_CompareSalesYearOverYear @Year1 INT, @Year2 INT
AS
BEGIN
    ;WITH orders_with_year AS(
        SELECT 
			o.order_id, 
			YEAR(o.order_date) AS yr
        FROM clean.orders o
        WHERE o.order_date IS NOT NULL
    )
    SELECT 'Year' = yr,
           COUNT(DISTINCT o.order_id) AS OrdersCount,
           SUM(oi.quantity * oi.list_price * (1 - ISNULL(oi.discount,0))) AS TotalRevenue
    FROM orders_with_year o
    LEFT JOIN clean.order_items oi ON o.order_id = oi.order_id
    WHERE yr IN (@Year1, @Year2)
    GROUP BY yr
    ORDER BY yr
END

