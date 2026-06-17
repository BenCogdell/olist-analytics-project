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

## Table Columns

###  Orders Table (olist_orders_dataset)

Contains order lifecycle information including purchase, approval, delivery and estimated delivery dates.

| Column | Type | Description | Additional Info |
| ----------- | ----------- | ----------- | ----------- |
| order_id | text | unique identifier of the order | PRIMARY KEY |
| customer_id | text | key to the customer dataset. Each order has a unique customer_id | FOREIGN KEY (customers)|
| order_status | text | Reference to the order status (delivered, shipped, etc.) | N/A |
| order_purchase_timestamp | timestamp | Shows the purchase timestamp | N/A |
| order_approved_at | timestamp | Shows the payment approval timestamp. | N/A |
| order_delivered_carrier_date | timestamp | Shows the order posting timestamp. When it was handled to the logistic partner. | N/A |
| order_delivered_customer_date | timestamp | Shows the actual order delivery date to the customer | N/A |
| order_estimated_delivery_date | timestamp | Shows the estimated delivery date that was informed to customer at the moment of purchase. | N/A |

###  Order Reviews Table (olist_order_reviews_dataset)

This table includes data about the reviews made by the customers.

| Column | Type | Description | Additional Info |
| ----------- | ----------- | ----------- | ----------- |
| review_id | text | unique review identifier | PRIMARY KEY |
| order_id | text | unique order identifier | FOREIGN KEY |
| review_score | text | Note ranging 1 to 5 given by the customer on a satisfaction survey. | N/A |
| review_comment_title | text | Comment title from the review left by the customer, in Portuguese | N/A |
| review_comment_message | text | Comment message from the review left by the customer, in Portuguese | N/A |
| review_creation_date | timestamp | Shows the date in which the satisdaction survey was sent ot the customer | N/A|
| review_answer_timestamp | timestamp | Shows satisfaction survey answer timestamp | N/A |


###  Order Payments Table (olist_order_payments_dataset)

This table includes data about the orders payment options.

| Column | Type | Description | Additional Info |
| ----------- | ----------- | ----------- | ----------- |
| order_id | text | unique identifier of an order | PART OF COMPOUND PRIMARY KEY (order_id, payment_sequential) |
| payment_sequential | text | a customer may pay an order with more than one payment method. if so, a sequence will be created. | PART OF COMPOUND PRIMARY KEY (order_id, payment_sequential) |
| payment_type | text | method of payment chosen by the customer | N/A |
| payment_installments | text | number of installments chosen by the customer | N/A |

###  Order Items Table (olist_order_items_dataset)

This dataset includes data about the items purchased within each order.

| Column | Type | Description | Additional Info |
| ----------- | ----------- | ----------- | ----------- |
| order_id | text | order unique identifier | PART OF COMPOUND PRIMARY KEY (order_id, order_item_id) |
| order_item_id | text | sequential number identifying number of items including in the same order. | PART OF COMPOUND PRIMARY KEY (order_id, order_item_id) |
| product_id | text | product unique identifier | FOREIGN KEY |
| seller_id | text | seller unique identifier | FOREIGN KEY |
| price | float | item price | N/A |
| frieght_value | float | item freight value item (if order has more than one item, the freight value is split between items) | N/A  |

###  Customers Table (olist_customers_dataset)

This dataset has information about the customer and its location.

| Column | Type | Description | Additional Info |
| ----------- | ----------- | ----------- | ----------- |
| customer_id | text | unique customer record tied to an order | PRIMARY KEY | 
| customer_unique_id | text | Actual customer across multiple orders | N/A | 
| customer_zip_code_prefix | text(5) | First 5 digits of a customer zip code | LOOKUP from zip_code_prefix in geolocation |
| customer_city | text | Customer city name | N/A |
| customer_state | text | Customer state | N/A | 

### Sellers Table (olist_sellers_dataset)

This dataset includes data about the sellers that fulfilled orders made at Olist.

| Column | Type | Description | Additional Info |
| ----------- | ----------- | ----------- | ----------- |
| seller_id | text | seller unique identifier | PRIMARY KEY |
| seller_zip_code_prefix | text | first 5 digits of sellers zip code | LOOKUP from zip_code_prefix in geolocation |
| seller_city | text | seller city name | N/A |
| seller_state | text | seller state | N/A |

### Geolocation Table (olist_geolocation_dataset)

This dataset has information Brazilian zip codes and its lat/lng coordinates. 

| Column | Type | Description | Additional Info |
| ----------- | ----------- | ----------- | ----------- |
| geolocation_zip_code_prefix | text | first 5 digits of zip code | LOOKUP column|
| geolocation_lat | float | latitude | N/A |
| geolocation_lng | float | longitude | N/A |
| geolocation_city | text | city name | N/A |
| geolocation_state | text | state | N/A |

### Products Table (olist_products_dataset)

This dataset includes data about the products sold by Olist.

| Column | Type | Description | Additional Info |
| ----------- | ----------- | ----------- | ----------- |
| product_id | text | unique prodcut identifier | PRIMARY KEY |
| product_category_name | text | root category of product, in Portuguese | N/A |
| product_name_length | text | number of characters extracted from the product name | N/A |
| product_description_length | text | number of characters extracted from the product description | N/A |
| product_photos_qty | text | number of product published photos | N/A |
| product_weight_g | text | product weight measured in grams | N/A |
| product_length_cm | text | prodcut length measured in centimeters | N/A |
| product_height_cm | text | prodcut height measured in centimeters. | N/A |
| product_wigth_cm | text | product width measured in centimeters | N/A |
