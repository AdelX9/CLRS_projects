--Assignment 4
--Q1106

CREATE DATABASE Manufacturer;
GO
CREATE SCHEMA tab1;
GO
USE Manufacturer;

CREATE TABLE Product (
    prod_id INT PRIMARY KEY,
    prod_name VARCHAR(50) NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE Component (
    comp_id INT PRIMARY KEY,
    comp_name VARCHAR(50) NOT NULL,
    description VARCHAR(50),
    quantity_comp INT NOT NULL
);

CREATE TABLE Supplier (
    supp_id INT PRIMARY KEY,
    supp_name VARCHAR(50) NOT NULL,
    supp_location VARCHAR(50) NOT NULL,
    supp_country VARCHAR(50) NOT NULL,
    is_active BIT NOT NULL
);

CREATE TABLE Comp_Supp (
    comp_id INT,
    supp_id INT,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (comp_id, supp_id),
    FOREIGN KEY (comp_id) REFERENCES Component (comp_id),
    FOREIGN KEY (supp_id) REFERENCES Supplier (supp_id)
);

CREATE TABLE Prod_Comp (
    comp_id INT,
    prod_id INT,
    PRIMARY KEY (comp_id, prod_id),
    FOREIGN KEY (comp_id) REFERENCES Component (comp_id),
    FOREIGN KEY (prod_id) REFERENCES Product (prod_id)
);

-- a product cannot exist without components
ALTER TABLE Prod_Comp
ADD CONSTRAINT FK_Product_Prod_Comp
FOREIGN KEY (prod_id) REFERENCES Product (prod_id);
