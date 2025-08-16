-- sp_GenerateRestockList: Output low-stock items per store
CREATE PROCEDURE sp_GenerateRestockList @Threshold INT = 10
AS
BEGIN
    SELECT st.store_id, st.store_name, p.product_id, p.product_name, sk.quantity
    FROM clean.stocks sk
    JOIN clean.stores st ON sk.store_id = st.store_id
    JOIN clean.products p ON sk.product_id = p.product_id
    WHERE sk.quantity <= @Threshold
    ORDER BY st.store_id, sk.quantity ASC;
END
