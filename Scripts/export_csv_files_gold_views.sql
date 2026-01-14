COPY (SELECT * FROM gold.dim_customers)
TO 'C:\Users\Oscar\OneDrive\PARA\1-Projects\Project #1\Analysis\Dataset\dim_customers.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

COPY (SELECT * FROM gold.dim_products)
TO 'C:\Users\Oscar\OneDrive\PARA\1-Projects\Project #1\Analysis\Dataset\dim_products.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

COPY (SELECT * FROM gold.fact_sales)
TO 'C:\Users\Oscar\OneDrive\PARA\1-Projects\Project #1\Analysis\Dataset\fact_sales.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');