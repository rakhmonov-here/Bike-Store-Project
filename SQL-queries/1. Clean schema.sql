-- 1) Create a clean schema with proper keys, types, and constraints
--CREATE SCHEMA clean
GO

CREATE TABLE clean.brands(
	brand_id INT PRIMARY KEY,
	brand_name VARCHAR(100) NOT NULL
)


CREATE TABLE clean.categories(
	category_id INT PRIMARY KEY,
	category_name VARCHAR(100) NOT NULL
)

CREATE TABLE clean.products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100) NOT NULL,
	brand_id INT FOREIGN KEY REFERENCES clean.brands(brand_id),
	category_id INT FOREIGN KEY REFERENCES clean.categories(category_id),
	model_year INT NOT NULL,
	list_price DECIMAL(10,2)
)

CREATE TABLE clean.stores(
    store_id INT PRIMARY KEY,
    store_name VARCHAR(150) NOT NULL,
	phone VARCHAR(20),
	email VARCHAR(100),
	street VARCHAR(100),
    city VARCHAR(100),
    [state] VARCHAR(100),
	zip_code INT NOT NULL
)

CREATE TABLE clean.customers(
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(150) NOT NULL,
	last_name VARCHAR(150) NOT NULL,
	phone VARCHAR(20),
	email VARCHAR(150),
	street VARCHAR(100),
	city VARCHAR(100),
	[state] VARCHAR(100),
	zip_code INT NOT NULL
)	

CREATE TABLE clean.staffs(
	staff_id INT PRIMARY KEY,
	first_name VARCHAR(150) NOT NULL,
	last_name VARCHAR(150) NOT NULL,
	email VARCHAR(150),
	phone VARCHAR(20),
	active INT,
	store_id INT FOREIGN KEY REFERENCES clean.stores(store_id),
	manager_id INT FOREIGN KEY REFERENCES clean.staffs(staff_id)
)

CREATE TABLE clean.orders(
	order_id INT PRIMARY KEY,
	customer_id INT FOREIGN KEY REFERENCES clean.customers(customer_id),
	order_status VARCHAR(100),
	order_date DATE,
	required_date DATE,
	shipped_date DATE,
	store_id INT FOREIGN KEY REFERENCES clean.stores(store_id),
	staff_id INT FOREIGN KEY REFERENCES clean.staffs(staff_id)
)

CREATE TABLE clean.order_items(
	order_id INT FOREIGN KEY REFERENCES clean.orders(order_id),
	item_id INT NOT NULL,
	product_id INT NOT NULL FOREIGN KEY REFERENCES clean.products(product_id),
	quantity INT NOT NULL,
	list_price DECIMAL(10,2),
	discount DECIMAL(10,2),
	CONSTRAINT PK_order_items PRIMARY KEY (order_id, item_id)
)

CREATE TABLE clean.stocks (
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT PK_stocks PRIMARY KEY (store_id, product_id),
    CONSTRAINT FK_stocks_store FOREIGN KEY (store_id) REFERENCES clean.stores(store_id),
    CONSTRAINT FK_stocks_product FOREIGN KEY (product_id) REFERENCES clean.products(product_id)
);



