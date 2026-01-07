# Sales Revenue Analysis (SQL)

## Data Source
The analysis is based on the **Northwind** sample database.

Source:
https://github.com/jpwhite3/northwind-SQLite3


## Overview
This project demonstrates an end-to-end SQL analytics workflow using the Northwind dataset.
The goal is to analyze revenue dynamics and product performance over time.

## Data
Dataset: Northwind (SQLite)  
Main tables:
- Orders
- Order Details
- Products

## Data Model
The analysis is built on a fact table at order-line level:
- Order Details (fact)
- Orders (time dimension)
- Products (product dimension)

## Metrics
- Monthly total revenue
- Top products by total revenue
- Top product per month
- Month-over-month revenue dynamics of the monthly leader

Window functions used:
- ROW_NUMBER()
- LAG()

## Key Findings
- A single product consistently leads monthly revenue across the entire period.
- No leadership change was detected month-over-month.
- Revenue dynamics of the leading product remain stable over time.

## Files
- analysis.sql — full analytical pipeline
