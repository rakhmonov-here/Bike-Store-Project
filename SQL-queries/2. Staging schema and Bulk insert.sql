-- Use BULK INSERT or OPENROWSET to load all .csv files into staging tables
-- Staging tables
CREATE SCHEMA staging;
GO

CREATE TABLE staging.brands(
    brand_id INT,
    brand_name NVARCHAR(100)
)

CREATE TABLE staging.categories(
    category_id INT,
    category_name VARCHAR(100)
)

CREATE TABLE staging.products(
    product_id INT,
    product_name VARCHAR(100),
    brand_id INT,
    category_id INT,
    model_year INT,
    list_price DECIMAL(10,2)
)

CREATE TABLE staging.stores(
    store_id INT,
    store_name VARCHAR(150),
	phone VARCHAR(20),
	email VARCHAR(100),
	street VARCHAR(100),
    city VARCHAR(100),
    [state] VARCHAR(100),
    zip_code INT
)

CREATE TABLE staging.customers(
    customer_id INT,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    phone VARCHAR(20),
	email VARCHAR(100),
	street VARCHAR(100),
	city VARCHAR(100),
	[state] VARCHAR(100),
	zip_code INT
)

CREATE TABLE staging.staffs(
    staff_id INT,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
	email VARCHAR(150),
	phone VARCHAR(20),
	active INT,
    store_id INT,
	manager_id INT
)

CREATE TABLE staging.orders(
    order_id INT,
    customer_id INT,
    order_status VARCHAR(100),
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    store_id INT,
    staff_id INT
)

CREATE TABLE staging.order_items(
    order_id INT,
    item_id INT,
    product_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(10,2)
)

CREATE TABLE staging.stocks(
    store_id INT,
    product_id INT,
    quantity INT
)

-- BULK INSERT 

BULK INSERT staging.brands
FROM 'C:\Users\Admin\Desktop\Project\Project files\brands.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

BULK INSERT staging.categories
FROM 'C:\Users\Admin\Desktop\Project\Project files\categories.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

BULK INSERT staging.customers
FROM 'C:\Users\Admin\Desktop\Project\Project files\customers.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

BULK INSERT staging.order_items
FROM 'C:\Users\Admin\Desktop\Project\Project files\order_items.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

BULK INSERT staging.orders
FROM 'C:\Users\Admin\Desktop\Project\Project files\orders.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

BULK INSERT staging.products
FROM 'C:\Users\Admin\Desktop\Project\Project files\products.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

BULK INSERT staging.staffs
FROM 'C:\Users\Admin\Desktop\Project\Project files\staffs.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

BULK INSERT staging.stocks
FROM 'C:\Users\Admin\Desktop\Project\Project files\stocks.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

BULK INSERT staging.stores
FROM 'C:\Users\Admin\Desktop\Project\Project files\stores.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)
