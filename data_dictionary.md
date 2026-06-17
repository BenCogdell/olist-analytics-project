# Data Dictionary

This document is a repository of information about the data within this Olist Brazilian ecommerce public dataset such as:

- Context regarding the meaning of tables and their respective columns.
- The data types of each column within the tables.
- The relationships between each table.

---

## Tables

| Table | Description | PK | Row Count |
| ----------- | ----------- | ----------- | ----------- |
| orders | Customer Purchase Activity | order_id | 99441 |
| order_reviews | data about the reviews made by the customers | review_id | 98410 |
| order_payments | data about the orders payment options | (order_id, payment_sequential) | 99440 |
| order_items | data about the reviews made by the customers | (order_id, order_item_id)  | 98666 |
| customers | information about the customer and its location | customer_id  | 99441 |
| sellers | information about the sellers that fufilled orders made at Olist. | seller_id  | 3095 |
| geolocation | Brazillian zip codes and lat/lng coordinates| N/A | 1000163 |
| products | data about the products sold by Olist | product_id  | 32951 |

---

## Relationships 

### Relational Lookups

| Parent Table | Parent PK | Child Table | Child FK |
| ----------- | ----------- | ----------- | ----------- |
| orders | order_id | order_payments | order_id |
| orders | order_id | order_items | order_id |
| orders | order_id | order_reviews | order_id |
| products | product_id | order_items | product_id |
| sellers | seller_id | order_items | seller_id |
| customers | customer_id | orders | customer_id |


### Non-unique lookups

| Lookup Table | Lookup Column | Referencing Table  | Referencing Column |
| ----------- | ----------- | ----------- | ----------- |
| geolocation | zip_code_prefix | customers | customer_zip_code_prefix |
| geolocation | zip_code_prefix | sellers | seller_zip_code_prefix |

---
