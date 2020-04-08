CREATE DATABASE IF NOT EXISTS sakila_dw;

USE sakila_dw;

#Dimension de fecha
CREATE TABLE dim_date(
    date_key BIGINT PRIMARY KEY DEFAULT 0,
    date DATE NOT NULL DEFAULT '2000-01-01',
    year VARCHAR(4),
    month VARCHAR(2),
    day VARCHAR(2)
);

#Dimension de Tiempo

CREATE TABLE dim_time(
    time_seq INT PRIMARY KEY NOT NULL,
    hour_id VARCHAR(2),
    minute_id VARCHAR(2),
    time_desc VARCHAR(5),
    hour_type VARCHAR(2)
);

CREATE TABLE dim_customer(
    customer_id INT NOT NULL,
    store_id INT DEFAULT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    active INT,
    address_id INT,
    address VARCHAR(70),
    city_id INT,
    city VARCHAR(50),
    country_id INT,
    country VARCHAR(50),
    active_desc VARCHAR(3),
    create_date DATETIME,
    last_update DATETIME
);

DROP TABLE fact_rental;
CREATE TABLE fact_rental (
    rental_id INT(11) PRIMARY KEY,
    rental_hours DECIMAL(5,2),
    rental_days DECIMAL(4,2),
    rental_payment DECIMAL(6,2),
    date_key BIGINT, #Llave foranea
    customer_id INT, #Llave foranea
    time_seq INT,#Llave foranea
    last_update DATE
);

-- Llaves

ALTER TABLE dim_customer
    ADD PRIMARY KEY (customer_id);

-- Llaves foraneas

ALTER TABLE  fact_rental
    ADD CONSTRAINT FK_dim_date FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key);

ALTER TABLE  fact_rental
    ADD CONSTRAINT FK_dim_customer FOREIGN KEY (customer_id)
        REFERENCES dim_customer(customer_id);

ALTER TABLE  fact_rental
    ADD CONSTRAINT FK_dim_time FOREIGN KEY (time_seq)
        REFERENCES dim_time(time_seq);