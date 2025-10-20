# IDS706_DE_sql_notebook


## A sql Data set called "Mock" was created by GenAI for this project

**About the dataset:**
Mock is a sample SQLite database with simulating an online retail store. This is a relational database with 5 interconnected tables:  

- 5 categories of products
- 8 customers from various cities (New York, London, Toronto, Sydney, Madrid, etc.)
- 12 products across 5 categories (Electronics, Books, Clothing, Home & Garden, Sports)
- 10 orders placed between May-July 2024
- 17 order items representing individual products purchased in those orders

### SQL Query
0. Let's start with BUILDING the database:  
You should have a .sql file openned in your folder so you can write queries to create your own database! (Or you can upload any existing .db file and skip this step). 
After you have your .sql file written, let's say you name your .sql file < myfile.sql >you can run this in the terminal: ```myfile.db < myfile.sql ``` and a new document called "myfile.db" will pop up for you!  

To view your .db file, right click and chose Open With... -> SQLite Viewer (assume you already have this as an extension)  

1. **Create Table:**

For example, this code was used to create tabel "customers": 

```sql
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY, --This line indicate this variable type is integer, and is used as primary key in this table
    first_name VARCHAR(50) NOT NULL, --This line indicate this variable is a text/string, and the max length is 50, and this field is required
    last_name VARCHAR(50) NOT NULL, --Same as above
    email VARCHAR(100) UNIQUE NOT NULL, --Same as above, plus this field need to be unique
    city VARCHAR(50), 
    country VARCHAR(50),
    registration_date DATE --This line indicate this variable is in the formate as "DATE", which is 'YYYY-MM-DD'
);
```
The above code will build an empty table, the next step is to fill the table with some data. We use ```INSERT INTO ``` to do that:  

```bash
INSERT INTO customers (customer_id, first_name, last_name, email, city, country, registration_date) VALUES #This should follow the structure built above
(1, 'John', 'Smith', 'john.smith@email.com', 'New York', 'USA', '2024-01-15'),
(2, 'Emma', 'Johnson', 'emma.j@email.com', 'London', 'UK', '2024-02-20'),
(3, 'Michael', 'Brown', 'mbrown@email.com', 'Toronto', 'Canada', '2024-03-10'),
(4, 'Sarah', 'Davis', 'sarah.davis@email.com', 'Sydney', 'Australia', '2024-01-25'),
(5, 'David', 'Wilson', 'dwilson@email.com', 'Chicago', 'USA', '2024-04-05'),
(6, 'Lisa', 'Anderson', 'lisa.a@email.com', 'Los Angeles', 'USA', '2024-02-14'),
(7, 'James', 'Taylor', 'jtaylor@email.com', 'Manchester', 'UK', '2024-03-22'),
(8, 'Maria', 'Garcia', 'mgarcia@email.com', 'Madrid', 'Spain', '2024-01-30');
```

Note that this table does not have a FOREIGN KEY. Let's look at another table which does:  

```sql
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2), -- The data type is a float (number with decimal)
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Here, this line indicate that the customer_id in THIS table must match a customer_id that exists in the customer table
);
```
By doing this, we can prevent orphaned data and accidental deletion.  

Once the table(s) is created, we can use ```UPDATE``` to update the value in the existing table. For example, I want to discount the T-shirt by 10% since we have too many, I can run:  

```sql
UPDATE products --This indicate the update happens in the table "product"
SET price = price * 0.9 --Discount the price
WHERE product_name = 'Cotton T-Shirt'; --Specify that the T-shirt is discounted instead of everything in stock
```
After that, you can see that the price of T-shirt changed from $19.99 to 17.99!  

Great! To keep track of the discount(s), now I want to add a column to indicate that:  

```sql
ALTER TABLE products -- ALTER is used to modify the table
ADD COLUMN is_discounted INTEGER DEFAULT 0; --Add a column named "is_discounted", the variable type is set to "INTEGER"
```
Note that I set the variable type to integer and make 0 as default value which indicates no discount, since integer is easier to play around with compare to text.  

After that, I can update the value of T-shirt into 1 to show that this product is discounted:

```sql
UPDATE products
SET is_discounted = 1
WHERE product_name = 'Cotton T-Shirt';
```
Note that you can update multiple cells at a time, by using something like this:

```sql
UPDATE products
SET price = price * 0.9,
    is_discounted = 1
WHERE product_name IN ('Cotton T-Shirt', 'Denim Jeans', 'Yoga Mat') #This!! 
```
Which we will discuss more in the next part.  

Voila! This is how to setup and update a sql dataset!

2. **Run the query**

2.0 Before we continue to code, we should always ask a question: Why?
Good questions need to be asked before you can write anything down.  

Assume we already have some questions that we are interested in with this data, a good practice is to exam the data and get to know a little more of it. This database I have is very simple and was created for practice, but in real life, the data can and will be messy.

We might want to know how many products do we have in stock:

```sql
SELECT product_name, stock_quantity -- Give us prodcut name and stock quantity
FROM products -- From our target table: products
```
This will provide us with a whole list of every product we have, but we can add more elements to make it clearer:

```sql
SELECT product_name, price, stock_quantity -- Add price 
FROM products
WHERE price > 30 -- We only want to see the products if they have value ove $30
ORDER BY price DESC -- Add order to our list. DESC: descending, which means the greatest value will stay on top.
LIMIT 5; -- Only show the top 5
```
Laptop Pro 15|1299.99|25
Running Shoes|89.99|75
Bluetooth Headphones|79.99|65
Denim Jeans|59.99|120
Python Programming Guide|45.5|80

This is what we get out of that!

————————————  

**A powerful tool: Group By**

```GROUP BY``` Allow us to group observations before we do any thing to it.

For example:  

```sql
SELECT category_id,  COUNT(*) as product_count, AVG(price) as avg_price
FROM products
```
1|12|148.19925

By running this query, we can count the total number of product and calculate the average price for ALL the products. But with ```GROUP BY```, sql will spit out a list that tells us the number of products in each category, and calculate the average price for each category. Which gives us a little more insights!

```sql
SELECT category_id,  COUNT(*) as product_count, AVG(price) as avg_price
FROM products
GROUP BY category_id;
```
1|4|355.74
2|2|42.245
3|2|38.9905
4|2|38.99
5|2|57.49

Some might already noticed, this list is neat, but why it didn't explicitly tell us what categories we have?
Good question, if we look back at our table "products" we can see that the category info is stored with category_id, instead of the real category, all the info about category is stored in another table: "categories".

What do we do? We JOIN the tables together!

```sql
SELECT 
    categories.category_name, -- Show the name of each category
    COUNT(products.product_id) as product_count, -- Count how many products are in each category
    AVG(products.price) as avg_price -- Find the average price of products in each category
FROM products -- Use the products table as our starting point
JOIN categories ON products.category_id = categories.category_id -- Match each product to its category using the category_id column that exists in both tables
GROUP BY categories.category_name; -- Split products into separate groups by category, then calculate count and average for each group
```
This will provide a detailed table:

Books|2|42.245
Clothing|2|38.9905
Electronics|4|355.74
Home & Garden|2|38.99
Sports|2|57.49

**Note:**  
JOIN creates a **temporary result set in memory** - it does NOT:  
- Create a new permanent table
- Modify the original tables
- Save anything to disk
And it will disappear after the query is finished.










