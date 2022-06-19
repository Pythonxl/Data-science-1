CREATE DATABASE northwind_nbk;
\c northwind_nbk

--REGIONS

DROP TABLE IF EXISTS regions;
CREATE TABLE regions(
    regionID INT PRIMARY KEY,
    regionDescription VARCHAR(20) NOT NULL
);
  \COPY regions FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/regions.csv' DELIMITER ',' CSV HEADER;  
  
  -- TERRITORIES

  DROP TABLE IF EXISTS territories;
   CREATE TABLE territories(
    territoryID INT PRIMARY KEY,
    territoryDescription VARCHAR(50) NOT NULL,
    regionID INT 
   );

\COPY territories FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/territories.csv' DELIMITER ',' CSV HEADER;  
  
  --EMPLOYEES

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
    employeeID INT PRIMARY KEY,
    lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    titleOfCourtesy VARCHAR(50),
    birthdate TIMESTAMP,
    hireDate TIMESTAMP,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(20) NOT NULL,
    region VARCHAR(50),
    postalCode VARCHAR(20) NOT NULL,
    country VARCHAR(20) NOT NULL,
    homePhone TEXT NOT NULL,
    extension VARCHAR(20) NOT NULL,
    photo TEXT NOT NULL,
    notes TEXT NOT NULL,
    reportsTo VARCHAR(50) NOT NULL,
    PhotoPath TEXT
);

    
\COPY employees FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/employees.csv' DELIMITER ',' CSV HEADER;  
  
  --EMPLOYEE_TERRITORIES

DROP TABLE IF EXISTS employee_territories;
CREATE TABLE employee_territories(
    employeeID INT,
    territoryID INT
); 
\COPY employee_territories FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/employee_territories.csv' DELIMITER ',' CSV HEADER;  
--CUSTOMERS
DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
    customerID VARCHAR(20) PRIMARY KEY,
    companyName VARCHAR(50) NOT NULL,
    contactName VARCHAR(50) NOT NULL,
    contactTitle VARCHAR (50),
    address VARCHAR(100) NOT NULL,
    city VARCHAR(20) NOT NULL,
    region VARCHAR(50),
    postalCode VARCHAR(20) NOT NULL,
    country VARCHAR(20) NOT NULL,
    phone TEXT NOT NULL,
    fax TEXT
);
\COPY customers FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/customers.csv' DELIMITER ',' CSV HEADER;

--ORDERS

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
    orderID INTEGER PRIMARY KEY,
    customerID VARCHAR(20),
   --FOREIGN KEY (customerID) REFERENCES customers(customerID) ON DELETE CASCADE,
    employeeID INT,
    orderDate TIMESTAMP NOT NULL,
    requiredDate TIMESTAMP NOT NULL,
    shippedDate TIMESTAMP,
    shipVia INTEGER NOT NULL,
    freight FLOAT NOT NULL,
    shipName VARCHAR(50) NOT NULL,
    shipAddress VARCHAR(50) NOT NULL,
    shipCity VARCHAR(20) NOT NULL,
    shipRegion VARCHAR(50),
    shipPostalCode VARCHAR(10),
    shipCountry VARCHAR(20)
);
\COPY orders FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/orders.csv' WITH NULL as 'NULL' DELIMITER ',' CSV HEADER;
--SHIPPERS
DROP TABLE IF EXISTS shippers;

CREATE TABLE shippers (
    shipper_ID SERIAL PRIMARY KEY,
    company_Name VARCHAR(50) NOT NULL,
    phone TEXT NOT NULL
);
\COPY shippers FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/shippers.csv' WITH NULL as 'NULL' DELIMITER ',' CSV HEADER;

--ORDERDETAILS
DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details(
    orderID INTEGER,
    --FOREIGN KEY (orderID) REFERENCES orders(orderID) ON DELETE CASCADE,
    productID INTEGER,
    unitPrice FLOAT NOT NULL,
    quantity INTEGER,
    discount FLOAT

);
\COPY order_details FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/order_details.csv' DELIMITER ',' CSV HEADER;
--PRODUCTS

DROP TABLE IF EXISTS products;
CREATE TABLE products(
    ProductID INTEGER PRIMARY KEY,
    productName VARCHAR(40),
    quantityPerUnit INT,
    supplierID INT,
    categoryID TEXT,
    unitsInStock DECIMAL,
    unitPrice DECIMAL,
    unitsOnOrder INT,
    reorderLevel INT,
    discontinued BIT
);
\COPY products FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/products.csv' DELIMITER ',' CSV HEADER;
--CATEGORIES
DROP TABLE IF EXISTS categories;
CREATE TABLE categories(
    categoryID INTEGER PRIMARY KEY,
    categoryName VARCHAR(20),
    description TEXT,
    picture TEXT
);
\COPY categories FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/categories.csv' WITH NULL as 'NULL' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS suppliers;
-- SUPPLIERS
CREATE TABLE suppliers (
    supplier_ID SERIAL PRIMARY KEY,
    company_Name VARCHAR(100),
    contact_Name VARCHAR(150),
    contact_Title VARCHAR(100),
    address VARCHAR(150),
    city VARCHAR(20),
    region VARCHAR(20),
    postal_Code VARCHAR(20),
    country VARCHAR(20),
    phone VARCHAR(25),
    fax VARCHAR(25),
    home_Page VARCHAR(200)
);

\copy suppliers FROM '/Users/nihalbircankaya/Desktop/spiced_projects/week5/northwind_data_clean/data/suppliers.csv' DELIMITER ',' CSV HEADER NULL 'NULL';
