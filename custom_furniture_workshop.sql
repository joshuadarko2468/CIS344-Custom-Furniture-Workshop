-- CIS 344 Individual Project
-- Mini World: Custom Furniture Workshop

DROP DATABASE IF EXISTS custom_furniture_workshop_db;
CREATE DATABASE custom_furniture_workshop_db;
USE custom_furniture_workshop_db;

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(150)
);

CREATE TABLE Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL
);

CREATE TABLE Custom_Order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    order_date DATE NOT NULL,
    expected_completion_date DATE,
    status VARCHAR(30) NOT NULL DEFAULT 'Pending',
    total_price DECIMAL(10,2) NOT NULL,
    notes VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Furniture_Item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_type VARCHAR(60) NOT NULL,
    description VARCHAR(255),
    dimensions VARCHAR(100),
    wood_type VARCHAR(50),
    finish VARCHAR(50),
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Custom_Order(order_id)
);

CREATE TABLE Material (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(100) NOT NULL UNIQUE,
    material_type VARCHAR(60) NOT NULL,
    unit VARCHAR(30) NOT NULL,
    unit_cost DECIMAL(10,2) NOT NULL,
    quantity_in_stock DECIMAL(10,2) NOT NULL DEFAULT 0
);

CREATE TABLE Order_Material (
    order_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity_needed DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, material_id),
    FOREIGN KEY (order_id) REFERENCES Custom_Order(order_id),
    FOREIGN KEY (material_id) REFERENCES Material(material_id)
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Custom_Order(order_id)
);

-- SAMPLE DATA
INSERT INTO Customer (first_name, last_name, phone, email, address) VALUES
('Marcus','Johnson','914-555-0101','marcus.johnson@email.com','Mount Vernon, NY'),
('Ashley','Williams','914-555-0102','ashley.williams@email.com','New Rochelle, NY'),
('Daniel','Brown','718-555-0103','daniel.brown@email.com','Bronx, NY'),
('Nicole','Davis','914-555-0104','nicole.davis@email.com','Yonkers, NY'),
('Kevin','Thomas','914-555-0105','kevin.thomas@email.com','White Plains, NY');

INSERT INTO Employee (first_name, last_name, job_title, phone, hire_date) VALUES
('James','Carter','Lead Carpenter','914-555-0201','2023-02-10'),
('Maria','Lopez','Furniture Designer','914-555-0202','2024-04-15'),
('Andre','Wilson','Carpenter','914-555-0203','2025-01-08');

INSERT INTO Custom_Order
(customer_id, employee_id, order_date, expected_completion_date, status, total_price, notes) VALUES
(1,1,'2026-09-01','2026-10-05','In Progress',1450.00,'Custom dining table for six people'),
(2,2,'2026-09-05','2026-10-15','Pending',950.00,'Walnut writing desk with two drawers'),
(3,1,'2026-08-20','2026-09-25','Completed',1800.00,'Queen platform bed with headboard'),
(4,3,'2026-09-10','2026-10-20','In Progress',1200.00,'Custom bookshelf for living room'),
(5,2,'2026-09-15','2026-11-01','Pending',2200.00,'Dining set with table and four chairs');

INSERT INTO Furniture_Item
(order_id,item_type,description,dimensions,wood_type,finish,quantity,unit_price) VALUES
(1,'Dining Table','Six-person rectangular dining table','72 x 38 x 30 in','Oak','Natural',1,1450.00),
(2,'Desk','Writing desk with two drawers','55 x 25 x 30 in','Walnut','Dark stain',1,950.00),
(3,'Bed Frame','Queen platform bed and headboard','Queen size','Maple','Clear coat',1,1800.00),
(4,'Bookshelf','Five-shelf custom bookcase','72 x 36 x 14 in','Pine','White paint',1,1200.00),
(5,'Dining Table','Four-person dining table','60 x 36 x 30 in','Oak','Medium stain',1,1400.00),
(5,'Dining Chair','Matching dining chair','Standard','Oak','Medium stain',4,200.00);

INSERT INTO Material
(material_name,material_type,unit,unit_cost,quantity_in_stock) VALUES
('Oak Lumber','Wood','board foot',8.50,250),
('Walnut Lumber','Wood','board foot',13.00,120),
('Maple Lumber','Wood','board foot',9.25,160),
('Pine Lumber','Wood','board foot',5.50,300),
('Wood Screws','Hardware','box',12.00,25),
('Wood Glue','Adhesive','bottle',9.00,30),
('Natural Finish','Finish','gallon',42.00,12),
('White Furniture Paint','Finish','gallon',38.00,10);

INSERT INTO Order_Material (order_id, material_id, quantity_needed) VALUES
(1,1,65),(1,5,1),(1,6,2),(1,7,1),
(2,2,40),(2,5,1),(2,6,1),
(3,3,75),(3,5,2),(3,6,2),
(4,4,60),(4,5,1),(4,6,2),(4,8,1),
(5,1,95),(5,5,2),(5,6,3),(5,7,2);

INSERT INTO Payment (order_id,payment_date,amount,payment_method) VALUES
(1,'2026-09-01',725.00,'Credit Card'),
(2,'2026-09-05',300.00,'Cash'),
(3,'2026-08-20',900.00,'Credit Card'),
(3,'2026-09-25',900.00,'Credit Card'),
(4,'2026-09-10',600.00,'Debit Card'),
(5,'2026-09-15',700.00,'Credit Card');

-- USEFUL QUERIES
SELECT * FROM Customer;
SELECT * FROM Custom_Order;
SELECT * FROM Furniture_Item;
SELECT * FROM Material;
SELECT * FROM Payment;

-- Show orders with customer and employee names
SELECT o.order_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer,
       CONCAT(e.first_name, ' ', e.last_name) AS employee,
       o.status, o.total_price
FROM Custom_Order o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Employee e ON o.employee_id = e.employee_id;

-- Show materials needed for each order
SELECT om.order_id, m.material_name, om.quantity_needed, m.unit
FROM Order_Material om
JOIN Material m ON om.material_id = m.material_id
ORDER BY om.order_id;

-- Show total amount paid and remaining balance
SELECT o.order_id, o.total_price,
       COALESCE(SUM(p.amount),0) AS amount_paid,
       o.total_price - COALESCE(SUM(p.amount),0) AS balance_remaining
FROM Custom_Order o
LEFT JOIN Payment p ON o.order_id = p.order_id
GROUP BY o.order_id, o.total_price;

-- Show orders currently in progress
SELECT * FROM Custom_Order
WHERE status = 'In Progress';

-- Show low-stock materials
SELECT material_name, quantity_in_stock, unit
FROM Material
WHERE quantity_in_stock < 50;
