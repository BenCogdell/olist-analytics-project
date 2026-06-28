-- ==========================================
-- Olist Analytics Project
-- Table Creation
-- Author: Ben Cogdell
-- ==========================================

-- ==========================================
-- Orders
-- ==========================================

CREATE TABLE orders(
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR REFERENCES customers(customer_id),
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- ==========================================
-- Order Reviews
-- ==========================================

CREATE TABLE order_reviews(
   review_id VARCHAR PRIMARY KEY,
   order_id VARCHAR REFERENCES orders(order_id),
   review_score INT,
   review_comment_title VARCHAR,
   review_comment_message VARCHAR,
   review_creation_date TIMESTAMP,
   review_answer_timestamp TIMESTAMP
);

-- ==========================================
-- Order Payments
-- ==========================================

CREATE TABLE order_payments(
    order_id VARCHAR,
    payment_sequential INT,
    payment_type VARCHAR,
    payment_installments INT, 
    payment_value DECIMAL(10,2),
    PRIMARY KEY (order_id, payment_sequential)
);

-- ==========================================
-- Order Items
-- ==========================================

CREATE TABLE order_items(
    order_id VARCHAR,
    order_item_id INT,
    product_id VARCHAR REFERENCES products(product_id),
    seller_id VARCHAR  REFERENCES sellers(seller_id),
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY(order_id, order_item_id)
);

-- ==========================================
-- Customers
-- ==========================================

CREATE TABLE customers(
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix VARCHAR(5),
    customer_city VARCHAR,
    customer_state VARCHAR
);

-- ==========================================
-- Sellers
-- ==========================================

CREATE TABLE sellers(
    seller_id VARCHAR PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(5),
    seller_city VARCHAR,
    seller_state VARCHAR
);

-- ==========================================
-- Geolocation
-- ==========================================

CREATE TABLE geolocation(
    geolocation_zip_code_prefix VARCHAR(5),
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR,
    geolocation_state VARCHAR
);

-- ==========================================
-- Products
-- ==========================================

CREATE TABLE products(
    product_id VARCHAR PRIMARY KEY,
    product_category_name VARCHAR,
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
