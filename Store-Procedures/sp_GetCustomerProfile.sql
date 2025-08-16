-- sp_GetCustomerProfile: Returns total spend, orders, and most bought items

CREATE PROCEDURE sp_GetCustomerProfile @CustomerID INT
AS
BEGIN
    SELECT 
		c.customer_id, 
		c.first_name, 
		c.last_name,
		COUNT(DISTINCT o.order_id) AS OrdersCount,
		SUM(oi.quantity * oi.list_price * (1 - ISNULL(oi.discount,0))) AS TotalSpend
    FROM clean.customers c
    LEFT JOIN clean.orders o ON c.customer_id = o.customer_id
    LEFT JOIN clean.order_items oi ON o.order_id = oi.order_id
    WHERE c.customer_id = @CustomerID
    GROUP BY c.customer_id, c.first_name, c.last_name

    SELECT TOP 5 
		p.product_id, 
		p.product_name, 
		SUM(oi.quantity) AS QuantityBought
    FROM clean.orders o
    JOIN clean.order_items oi ON o.order_id = oi.order_id
    JOIN clean.products p ON oi.product_id = p.product_id
    WHERE o.customer_id = @CustomerID
    GROUP BY p.product_id, p.product_name
    ORDER BY QuantityBought DESC;
END
