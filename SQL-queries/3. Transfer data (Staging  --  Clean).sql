-- Normalize and transfer data into final tables using INSERT INTO ... SELECT logic…
--Brands
INSERT INTO clean.brands (brand_id, brand_name)
SELECT DISTINCT brand_id, brand_name
FROM staging.brands
WHERE brand_id IS NOT NULL

--Categories
INSERT INTO clean.categories (category_id, category_name)
SELECT DISTINCT category_id, category_name
FROM staging.categories
WHERE category_id IS NOT NULL

--Products
INSERT INTO clean.products (product_id, product_name, brand_id, category_id, model_year, list_price)
SELECT DISTINCT
    product_id,
    product_name,
    brand_id,
    category_id,
    model_year,
    list_price
FROM staging.products
WHERE product_id IS NOT NULL

--Stores
INSERT INTO clean.stores (store_id, store_name,phone, email, street, city, [state], zip_code)
SELECT DISTINCT 
	store_id, 
	store_name,
	phone,
	email,
	street,
	city, 
	[state], 
	CAST(zip_code AS INT) AS zip_code
FROM staging.stores
WHERE store_id IS NOT NULL

--Customers
INSERT INTO clean.customers (customer_id, first_name, last_name, phone, email, street, city, [state], zip_code)
SELECT DISTINCT 
	customer_id, 
	first_name, 
	last_name, 
	phone,
	email, 
	street,
	city,
	[state],
	zip_code
FROM staging.customers
WHERE customer_id IS NOT NULL

--Staffs
INSERT INTO clean.staffs (staff_id, first_name, last_name, email, phone, active, store_id, manager_id)
SELECT DISTINCT 
	staff_id, 
	first_name, 
	last_name,
	email,
	phone,
	active,
	store_id,
	TRY_CAST(manager_id AS INT) AS manager_id
FROM staging.staffs
WHERE staff_id IS NOT NULL

--Orders
INSERT INTO clean.orders (order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
SELECT DISTINCT
    order_id,
    customer_id,
    CAST(order_status AS INT) AS order_status,
    TRY_CAST(order_date AS DATE),
    TRY_CAST(required_date AS DATE),
    TRY_CAST(shipped_date AS DATE),
    store_id,
    staff_id
FROM staging.orders
WHERE order_id IS NOT NULL

--Order_items
INSERT INTO clean.order_items (order_id, item_id, product_id, quantity, list_price, discount)
SELECT DISTINCT
    order_id,
	item_id,
    product_id,
    quantity,
    list_price,
    discount
FROM staging.order_items
WHERE order_id IS NOT NULL AND item_id IS NOT NULL

--Stocks
INSERT INTO clean.stocks (store_id, product_id, quantity)
SELECT 
	store_id, 
	product_id, 
	quantity
FROM staging.stocks
WHERE store_id IS NOT NULL AND product_id IS NOT NULL