-- vw_StoreSalesSummary: Revenue, #Orders, AOV per store

CREATE VIEW vw_StoreSalesSummary AS
SELECT
	sto.store_id,
	store_name,
	COUNT(DISTINCT ord.order_id) AS OrderAmount,
	CAST(SUM(quantity * (list_price-(list_price * ISNULL(discount,0)))) AS DECIMAL(10,2)) AS TotalRevenue, 
	CASE
		WHEN COUNT(DISTINCT ord.order_id) = 0 THEN 0
		ELSE CAST(SUM(quantity * (list_price-(list_price * ISNULL(discount,0)))) AS DECIMAL(10,2)) * 1.0 / COUNT(DISTINCT ord.order_id)
	END AS AverageOrderValue
FROM clean.stores AS sto
LEFT JOIN clean.orders AS ord
ON sto.store_id = ord.store_id
LEFT JOIN clean.order_items AS item
ON ord.order_id = item.order_id
GROUP BY sto.store_id, store_name;
 

select * from vw_StoreSalesSummary


