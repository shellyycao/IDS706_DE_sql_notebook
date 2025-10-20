

-- Drop tables if they exist
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;

-- Create categories table
CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Create products table
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INTEGER,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE
);

-- Create orders table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create order_items table
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into categories
INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Electronics', 'Electronic devices and gadgets'),
(2, 'Books', 'Physical and digital books'),
(3, 'Clothing', 'Apparel and accessories'),
(4, 'Home & Garden', 'Home improvement and garden supplies'),
(5, 'Sports', 'Sports equipment and accessories');

-- Insert sample data into products
INSERT INTO products (product_id, product_name, category_id, price, stock_quantity) VALUES
(1, 'Laptop Pro 15', 1, 1299.99, 25),
(2, 'Wireless Mouse', 1, 29.99, 150),
(3, 'USB-C Cable', 1, 12.99, 200),
(4, 'Python Programming Guide', 2, 45.50, 80),
(5, 'SQL Mastery Book', 2, 38.99, 60),
(6, 'Cotton T-Shirt', 3, 19.99, 300),
(7, 'Denim Jeans', 3, 59.99, 120),
(8, 'Running Shoes', 5, 89.99, 75),
(9, 'Yoga Mat', 5, 24.99, 100),
(10, 'Garden Hose', 4, 34.99, 50),
(11, 'LED Desk Lamp', 4, 42.99, 90),
(12, 'Bluetooth Headphones', 1, 79.99, 65);

-- Insert sample data into customers
INSERT INTO customers (customer_id, first_name, last_name, email, city, country, registration_date) VALUES
(1, 'John', 'Smith', 'john.smith@email.com', 'New York', 'USA', '2024-01-15'),
(2, 'Emma', 'Johnson', 'emma.j@email.com', 'London', 'UK', '2024-02-20'),
(3, 'Michael', 'Brown', 'mbrown@email.com', 'Toronto', 'Canada', '2024-03-10'),
(4, 'Sarah', 'Davis', 'sarah.davis@email.com', 'Sydney', 'Australia', '2024-01-25'),
(5, 'David', 'Wilson', 'dwilson@email.com', 'Chicago', 'USA', '2024-04-05'),
(6, 'Lisa', 'Anderson', 'lisa.a@email.com', 'Los Angeles', 'USA', '2024-02-14'),
(7, 'James', 'Taylor', 'jtaylor@email.com', 'Manchester', 'UK', '2024-03-22'),
(8, 'Maria', 'Garcia', 'mgarcia@email.com', 'Madrid', 'Spain', '2024-01-30');

-- Insert sample data into orders
INSERT INTO orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1, 1, '2024-05-10', 1342.97, 'Delivered'),
(2, 2, '2024-05-15', 84.48, 'Delivered'),
(3, 3, '2024-06-01', 89.99, 'Shipped'),
(4, 1, '2024-06-05', 45.50, 'Delivered'),
(5, 4, '2024-06-10', 144.97, 'Processing'),
(6, 5, '2024-06-15', 109.98, 'Delivered'),
(7, 6, '2024-06-20', 1299.99, 'Shipped'),
(8, 2, '2024-06-22', 59.99, 'Delivered'),
(9, 7, '2024-07-01', 164.97, 'Processing'),
(10, 3, '2024-07-05', 42.99, 'Delivered');

-- Insert sample data into order_items
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 1299.99),
(2, 1, 2, 1, 29.99),
(3, 1, 3, 1, 12.99),
(4, 2, 4, 1, 45.50),
(5, 2, 5, 1, 38.99),
(6, 3, 8, 1, 89.99),
(7, 4, 4, 1, 45.50),
(8, 5, 6, 3, 19.99),
(9, 5, 9, 1, 24.99),
(10, 5, 2, 2, 29.99),
(11, 6, 12, 1, 79.99),
(12, 6, 2, 1, 29.99),
(13, 7, 1, 1, 1299.99),
(14, 8, 7, 1, 59.99),
(15, 9, 8, 1, 89.99),
(16, 9, 9, 3, 24.99),
(17, 10, 11, 1, 42.99);


