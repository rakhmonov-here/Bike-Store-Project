-- vw_SalesByCategory: Sales volume and margin by product category

CREATE VIEW vw_SalesByCategory AS
SELECT 
	cat.category_id,
	category_name, 
	SUM(item.quantity) AS TotalQuantity,
	CAST(SUM(quantity * (item.list_price - (item.list_price * ISNULL(discount,0)))) AS DECIMAL(10,2)) AS TotalSales
FROM clean.categories AS cat
LEFT JOIN clean.products AS pro
ON cat.category_id = pro.category_id
LEFT JOIN clean.order_items AS item
ON pro.product_id = item.product_id
GROUP BY cat.category_id, category_name



