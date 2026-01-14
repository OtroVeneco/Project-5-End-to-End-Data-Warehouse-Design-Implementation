# Project #1: Data Warehouse and Analytics 

### Introduction

I developed this project to emulate a real-world data project, focusing on its engineering and analytical components. Throughout my learning journey, I encountered several challenges due to the lack of context in most online tutorials and courses, which often fail to demonstrate how real-world projects function. My goal with this project is to apply the best practices learned from books, papers, courses, and tutorials to practice and enhance my design, technical, and analytical skills.

### Project Overview 

This project involves various aspects of a real-world data project:

1. **Data Architecture**: design a data warehouse with a medallion architecture .
2. **ETL Pipelines**: extract, transform and load data from source system into the warehouse.
3. **Data Modeling**: developing fact and dimension tables optimized for analytical queries.
4. **Analytics and Reporting**: explore the data to create reports and dashboards

## Requirements

### Data Warehouse

**Objective**

Develop a data warehouse using PostgreSQL to consolidate sales data, enabling analytical reporting and informed decision-making.

**Specification**

* **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files. 
* **Data Quality**: Address and rectify data quality problems before conducting analysis.
* **Integration**: Combine both sources into a single, user-friendly data model designed for analytical reporting
* **Scope**: No historization is required.
* **Documentation**: Provide documentation of the data model to support both business stakeholders and analytical teams.

## 📂 Repository Structure

```
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                               # Project documentation and architecture details
│   ├── data_architecture               # file shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow                       # file for the data flow diagram
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│   ├── layers_desing           	    # Design of the layers bronze, silver and gold
│   ├── data_mars          	            # information of the transformed data
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── README.md                           # Project overview and instructions
```

