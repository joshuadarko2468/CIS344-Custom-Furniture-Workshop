# CIS344-Custom-Furniture-Workshop
custom furniture workshop database project 
# Custom Furniture Workshop Database

## CIS 344 – Fall 2026

This project is a relational database designed for a custom furniture workshop. The purpose of the database is to help the business keep track of customers, employees, custom orders, furniture items, materials, and payments.

## Database Overview

The database is named:

`custom_furniture_workshop_db`

It contains seven tables:

1. Customer
2. Employee
3. Custom_Order
4. Furniture_Item
5. Material
6. Order_Material
7. Payment

## Main Relationships

- One customer can place many custom orders.
- One employee can handle many custom orders.
- One custom order can contain many furniture items.
- One custom order can have multiple payments.
- One custom order can use many materials.
- One material can be used for many different orders.
- Order_Material connects Custom_Order and Material and stores the quantity of material needed.

## Project Features

The database can be used to:

- Store customer information.
- Keep track of custom furniture orders.
- Assign employees to orders.
- Store furniture specifications such as dimensions, wood type, finish, quantity, and price.
- Track materials and inventory.
- Record materials needed for each order.
- Record customer payments.
- Check order status.
- View customer balances.
- Find materials that are low in stock.

## Software Used

- MySQL
- MySQL Workbench
- SQL

## Project Files

- `custom_furniture_workshop.sql` – Creates the database, tables, sample data, and queries.
- `Custom_Furniture_Workshop.mwb` – MySQL Workbench database model and EER diagram.
- `Custom_Furniture_Workshop_Final_Report_Human_Friendly.docx` – Final written project report.
- `Chen_ER_Diagram` – Hand-drawn Chen-style ER diagram.
- `README.md` – Overview of the project.

## ER Diagrams

This project includes two database diagrams:

**Chen-Style ER Diagram:**  
A hand-drawn conceptual diagram showing the main entities, attributes, relationships, and cardinalities.

**MySQL Workbench EER Diagram:**  
Shows the seven database tables, primary keys, foreign keys, and relationships used in the actual database.

## How to Run the Database

1. Open MySQL Workbench.
2. Open `custom_furniture_workshop.sql`.
3. Run the SQL script.
4. Refresh the Schemas panel.
5. Open `custom_furniture_workshop_db`.
6. Expand the Tables section to view the seven tables.
7. Run the included SELECT queries to view and test the data.

## Author

Joshua Darko  
CIS 344 – Fall 2026
