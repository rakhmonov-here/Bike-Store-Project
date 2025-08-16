-- sp_CalculateStoreKPI: Input store ID, return full KPI breakdown
CREATE PROCEDURE sp_CalculateStoreKPI @StoreID INT
AS
BEGIN
    SELECT s.store_id, s.store_name,
           COUNT(DISTINCT o.order_id) AS OrdersCount,
           SUM(oi.quantity * oi.list_price * (1 - ISNULL(oi.discount,0))) AS TotalRevenue,
           CASE 
				WHEN COUNT(DISTINCT o.order_id)= 0 THEN 0 
				ELSE SUM(oi.quantity * oi.list_price * (1 - ISNULL(oi.discount,0))) * 1.0 / COUNT(DISTINCT o.order_id) 
		   END AS AverageOrderValue,
           (SELECT COUNT(*) FROM clean.stocks st WHERE st.store_id = s.store_id AND st.quantity < 10) AS LowStockItems
    FROM clean.stores s
    LEFT JOIN clean.orders o ON s.store_id = o.store_id
    LEFT JOIN clean.order_items oi ON o.order_id = oi.order_id
    WHERE s.store_id = @StoreID
    GROUP BY s.store_id, s.store_name;
END
