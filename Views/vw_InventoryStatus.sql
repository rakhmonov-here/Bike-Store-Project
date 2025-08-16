-- vw_InventoryStatus: Items running low on stock

CREATE VIEW vw_InventoryStatus AS
SELECT st.store_id,
       st.store_name,
       p.product_id,
       p.product_name,
       stks.quantity AS Available,
       CASE 
		   WHEN stks.quantity < 10 THEN 'Low' 
		   ELSE 'OK' 
	   END AS [Status]
FROM clean.stocks stks
JOIN clean.products p ON stks.product_id = p.product_id
JOIN clean.stores st ON stks.store_id = st.store_id
WHERE stks.quantity IS NOT NULL











