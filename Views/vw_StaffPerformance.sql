-- vw_StaffPerformance: Orders and revenue handled per staff

CREATE VIEW vw_StaffPerformance AS 
SELECT
	stf.staff_id,
	stf.first_name + ' ' + stf.last_name AS StaffName,
	s.store_name,
	COUNT(DISTINCT ord.order_id) AS OrdersHandled,
	CAST(SUM(quantity * (list_price - (list_price * ISNULL(discount,0)))) AS DECIMAL (10,2)) AS RevenueHandled 
FROM clean.staffs AS stf
LEFT JOIN clean.orders as ord
on stf.staff_id = ord.staff_id
LEFT JOIN clean.order_items AS item
ON ord.order_id = item.order_id
LEFT JOIN clean.stores AS s
ON stf.store_id = s.store_id
GROUP BY stf.staff_id, stf.first_name, stf.last_name, s.store_name




