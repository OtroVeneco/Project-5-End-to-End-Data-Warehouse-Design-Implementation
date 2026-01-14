# Naming Conventions

## General principles 

* Use **snake_case** 

* Avoid reserved SQL keywords

## Table naming conventions

### Bronze and Silver rules

* All names must start with the source system name, and table names must match their original names.
* **`<sourcesystem>_<entity>`**  

### Gold rules

* All names must use meaningful, business-aligned names for tables, starting with the category prefix.

* **`<category>_<entity>`**  

### Column naming conventions

* All primary keys in dimension tables must use the suffix `_key`.
* **`<table_name>_key`**  

### Technical columns 

* All technical columns must start with the prefix `dwh_`, followed by a descriptive name indicating the column's purpose.

* **`dwh_<column_name>`**  

### Stored procedure

* All stored procedures used for loading data must follow the naming pattern:

* **`load_<layer>`**.