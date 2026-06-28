# Data Dictionary

This document is a repository of information about the data within this Olist Brazilian ecommerce public dataset such as:

* Context regarding the meaning of tables and their respective columns.
* The data types of each column within the tables.
* The relationships between each table.

---

## Tables

|Table|Description|PK|Row Count|
|-|-|-|-|
|orders|Customer Purchase Activity|order_id|99441|
|order_reviews|data about the reviews made by the customers|review_id|98410|
|order_payments|data about the orders payment options|(order_id, payment_sequential)|99440|
|order_items|data about the reviews made by the customers|(order_id, order_item_id)|98666|
|customers|information about the customer and its location|customer_id|99441|
|sellers|information about the sellers that fulfilled orders made at Olist.|seller_id|3095|
|geolocation|Brazilian zip codes and lat/lng coordinates|N/A|1000163|
|products|data about the products sold by Olist|product_id|32951|

---

## Relationships

### Relational Lookups

|Parent Table|Parent PK|Child Table|Child FK|
|-|-|-|-|
|orders|order_id|order_payments|order_id|
|orders|order_id|order_items|order_id|
|orders|order_id|order_reviews|order_id|
|products|product_id|order_items|product_id|
|sellers|seller_id|order_items|seller_id|
|customers|customer_id|orders|customer_id|



### Non-unique Lookups

|Lookup Table|Lookup Column|Referencing Table|Referencing Column|
|-|-|-|-|
|geolocation|zip_code_prefix|customers|customer_zip_code_prefix|
|geolocation|zip_code_prefix|sellers|seller_zip_code_prefix|

---

## Table Columns

### Orders Table (olist_orders_dataset)

Contains order lifecycle information including purchase, approval, delivery and estimated delivery dates.

|Column|Type|Description|Additional Info|
|-|-|-|-|
|order_id|VARCHAR|unique identifier of the order|PRIMARY KEY|
|customer_id|VARCHAR|key to the customer dataset. Each order has a unique customer_id|FOREIGN KEY → customers(customer_id)|
|order_status|VARCHAR|Reference to the order status (delivered, shipped, etc.)||
|order_purchase_timestamp|TIMESTAMP|Shows the purchase timestamp||
|order_approved_at|TIMESTAMP|Shows the payment approval timestamp.||
|order_delivered_carrier_date|TIMESTAMP|Shows the order posting timestamp. When it was handled to the logistic partner.||
|order_delivered_customer_date|TIMESTAMP|Shows the actual order delivery date to the customer||
|order_estimated_delivery_date|TIMESTAMP|Shows the estimated delivery date that was informed to customer at the moment of purchase.||

### Order Reviews Table (olist_order_reviews_dataset)

This table includes data about the reviews made by the customers.

|Column|Type|Description|Additional Info|
|-|-|-|-|
|review_id|VARCHAR|unique review identifier|PRIMARY KEY|
|order_id|VARCHAR|unique order identifier|FOREIGN KEY → orders(order_id)|
|review_score|INTEGER|Note ranging 1 to 5 given by the customer on a satisfaction survey.||
|review_comment_title|VARCHAR|Comment title from the review left by the customer, in Portuguese||
|review_comment_message|VARCHAR|Comment message from the review left by the customer, in Portuguese||
|review_creation_date|TIMESTAMP|Shows the date in which the satisfaction survey was sent to the customer||
|review_answer_timestamp|TIMESTAMP|Shows satisfaction survey answer timestamp||



### Order Payments Table (olist_order_payments_dataset)

This table includes data about the orders payment options.

|Column|Type|Description|Additional Info|
|-|-|-|-|
|order_id|VARCHAR|unique identifier of an order|PART OF COMPOUND PRIMARY KEY (order_id, payment_sequential)|
|payment_sequential|INTEGER|a customer may pay an order with more than one payment method. if so, a sequence will be created.||
|payment_type|VARCHAR|method of payment chosen by the customer||
|payment_installments|INTEGER|number of instalments chosen by the customer|<br />|
|payment_value|DECIMAL(10,2)|transaction value||

### 

### Order Items Table (olist_order_items_dataset)

This dataset includes data about the items purchased within each order.

|Column|Type|Description|Additional Info|
|-|-|-|-|
|order_id|VARCHAR|order unique identifier|PART OF COMPOUND PRIMARY KEY (order_id, order_item_id)|
|order_item_id|INTEGER|sequential number identifying number of items including in the same order.|PART OF COMPOUND PRIMARY KEY (order_id, order_item_id)|
|product_id|VARCHAR|product unique identifier|FOREIGN KEY → products(product_id)|
|seller_id|VARCHAR|seller unique identifier|FOREIGN KEY → sellers(seller_id)|
|price|DECIMAL(10,2)|item price||
|freight_value|DECIMAL(10,2)|item freight value item (if order has more than one item, the freight value is split between items)||

### Customers Table (olist_customers_dataset)

This dataset has information about the customer and its location.

|Column|Type|Description|Additional Info|
|-|-|-|-|
|customer_id|VARCHAR|unique customer record tied to an order|PRIMARY KEY|
|customer_unique_id|VARCHAR|Business identifier representing the actual customer.|Multiple customer_id values may belong to the same customer_unique_id, allowing repeat purchase analysis.|
|customer_zip_code_prefix|VARCHAR(5)|First 5 digits of a customer zip code|LOOKUP from zip_code_prefix in geolocation|
|customer_city|VARCHAR|Customer city name||
|customer_state|VARCHAR|Customer state||

### Sellers Table (olist_sellers_dataset)

This dataset includes data about the sellers that fulfilled orders made at Olist.

|Column|Type|Description|Additional Info|
|-|-|-|-|
|seller_id|VARCHAR|seller unique identifier|PRIMARY KEY|
|seller_zip_code_prefix|VARCHAR(5)|first 5 digits of sellers zip code|LOOKUP from zip_code_prefix in geolocation|
|seller_city|VARCHAR|seller city name||
|seller_state|VARCHAR|seller state||

### Geolocation Table (olist_geolocation_dataset)

This dataset has information Brazilian zip codes and its lat/lng coordinates.

|Column|Type|Description|Additional Info|
|-|-|-|-|
|geolocation_zip_code_prefix|VARCHAR(5)|first 5 digits of zip code|LOOKUP column|
|geolocation_lat|FLOAT|latitude||
|geolocation_lng|FLOAT|longitude||
|geolocation_city|VARCHAR|city name||
|geolocation_state|VARCHAR|state||

### Products Table (olist_products_dataset)

This dataset includes data about the products sold by Olist.

|Column|Type|Description|Additional Info|
|-|-|-|-|
|product_id|VARCHAR|unique product identifier|PRIMARY KEY|
|product_category_name|VARCHAR|root category of product, in Portuguese||
|product_name_length|INTEGER|number of characters extracted from the product name||
|product_description_length|INTEGER|number of characters extracted from the product description||
|product_photos_qty|INTEGER|number of product published photos||
|product_weight_g|INTEGER|product weight measured in grams||
|product_length_cm|INTEGER|product length measured in centimetres||
|product_height_cm|INTEGER|product height measured in centimetres.||
|product_width_cm|INTEGER|product width measured in centimetres||



