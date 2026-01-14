# Data Catalog for Gold Layer

## **1. gold.dim_customers**

Stores customer details.

| Column name      | Data type   | Description                                                  |
| ---------------- | ----------- | ------------------------------------------------------------ |
| **customer_key** | INT8        | Surrogate primary key uniquely identifying each customer record in the dimension table. |
| customer_id      | INT4        | Unique numerical identifier assigned to each customer.       |
| customer_name    | TEXT        | Customer's first and last name.                              |
| gender           | VARCHAR(10) | Customer's gender.                                           |
| country          | VARCHAR(20) | Customer's country of residence.                             |
| marital_status   | VARCHAR(10) | The marital status of the customer.                          |
| birthdate        | DATE        | Date birth of the customer.                                  |
| create_date      | DATE        | The date when the customer record was created.               |

## **2. gold.dim_customers**

Stores product details.

| Column name    | Data type   | Description                                                  |
| -------------- | ----------- | ------------------------------------------------------------ |
| product_key    | INT8        | Surrogate primary key uniquely  identifying each customer record in the dimension table. |
| product_number | VARCHAR(10) | Alphanumeric code representing the product often used for categorization or inventory. |
| product_line   | VARCHAR(15) | Specific product line or series.                             |
| category       | VARCHAR     | Broader classification of the product.                       |
| subcategory    | VARCHAR     | A more detailed classification of the product within the category. |
| product_name   | VARCHAR(40) | Name of the product.                                         |
| maintenance    | VARCHAR(5)  | Indicate whether the product requires maintenance.           |
| cost           | NUMERIC     | The cost of the product measured in monetary units.          |
| start_date     | DATE        | The date when the product became available for sale or use.  |

****

## **3. gold.fact_sales**

Stores transactional sales data. 

| Column name   | Data type   | Description                                                  |
| ------------- | ----------- | ------------------------------------------------------------ |
| order_number  | VARCHAR(10) | Unique alphanumerical identifier for each sales order.       |
| product_key   | INT8        | Surrogate key linking the order to the product dimension table. |
| customer_key  | INT8        | Surrogate key linking the order to the customer dimension table. |
| order_date    | DATE        | The date when the order was placed.                          |
| shipping_date | DATE        | The date when the order was shipped to the customer.         |
| due_date      | DATE        | The date when the order payment was due.                     |
| quantity      | INT4        | The number of units of the product ordered for the line item . |
| price         | NUMERIC     | The price per unit of the product for the line item, in whole currency units . |
| sales_amount  | NUMERIC     | The total monetary value of the sale for the line item, in whole currency units. |

