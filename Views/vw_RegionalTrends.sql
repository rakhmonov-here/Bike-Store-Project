-- vw_RegionalTrends: Revenue by city or region

CREATE VIEW vw_RegionalTrends AS
SELECT
	s.city, s.[state],
	COUNT(DISTINCT ord.order_id) AS number_of_orders,
	CAST(SUM(quantity * (list_price - (list_price * ISNULL(discount,0)))) AS DECIMAL (10,2)) AS TotalRevenue
FROM clean.stores AS s
LEFT JOIN clean.orders AS ord
ON s.store_id = ord.store_id
LEFT JOIN clean.order_items AS item
ON ord.order_id = item.order_id
GROUP BY s.city, s.[state]


