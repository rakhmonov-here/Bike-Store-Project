-- vw_TopSellingProducts: Rank products by total sales

CREATE VIEW vw_TopSellingProducts AS 
SELECT TOP 10
	p.product_id,
	p.product_name,
	b.brand_name,
	c.category_name,
	SUM(item.quantity) AS TotalQuantitySold,
	CAST(SUM(item.quantity * (item.list_price - (item.list_price * ISNULL(discount, 0)))) AS DECIMAL (10,2)) AS TotalSales 
FROM clean.products AS p
LEFT JOIN clean.order_items AS item
ON p.product_id = item.product_id
LEFT JOIN clean.brands AS b
ON p.brand_id = b.brand_id
LEFT JOIN clean.categories AS c
ON p.category_id = c.category_id
GROUP BY p.product_id, p.product_name, b.brand_name, c.category_name
ORDER BY TotalSales DESC












