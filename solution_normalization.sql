
-- EXERCISE 1: Blog Database (Normalization)

CREATE DATABASE IF NOT EXISTS blog_db;
USE blog_db;

CREATE TABLE authors (
                         author_id INT AUTO_INCREMENT PRIMARY KEY,
                         author_name VARCHAR(255) NOT NULL
);

CREATE TABLE blog_posts (
                            post_id INT AUTO_INCREMENT PRIMARY KEY,
                            title VARCHAR(255) NOT NULL,
                            word_count INT,
                            views INT,
                            author_id INT,
                            FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

INSERT INTO authors (author_name) VALUES ('Maria Charlotte'), ('Juan Perez'), ('Gemma Alcocer');

INSERT INTO blog_posts (title, word_count, views, author_id) VALUES
                                                                 ('Best Paint Colors', 814, 14, 1),
                                                                 ('Small Space Decorating Tips', 1146, 221, 2),
                                                                 ('Hot Accessories', 986, 105, 1),
                                                                 ('Mixing Textures', 765, 22, 1),
                                                                 ('Kitchen Refresh', 1242, 307, 2),
                                                                 ('Homemade Art Hacks', 1002, 193, 1),
                                                                 ('Refinishing Wood Floors', 1571, 7542, 3);


-- EXERCISE 2: Airline Database (Normalization)

CREATE DATABASE IF NOT EXISTS airline_db;
USE airline_db;

CREATE TABLE aircrafts (
                           aircraft_model VARCHAR(50) PRIMARY KEY,
                           total_seats INT
);

CREATE TABLE flights (
                         flight_number VARCHAR(10) PRIMARY KEY,
                         aircraft_model VARCHAR(50),
                         flight_mileage INT,
                         FOREIGN KEY (aircraft_model) REFERENCES aircrafts(aircraft_model)
);

CREATE TABLE customers (
                           customer_id INT AUTO_INCREMENT PRIMARY KEY,
                           customer_name VARCHAR(100),
                           customer_status VARCHAR(20),
                           total_customer_mileage INT
);

CREATE TABLE bookings (
                          booking_id INT AUTO_INCREMENT PRIMARY KEY,
                          customer_id INT,
                          flight_number VARCHAR(10),
                          FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
                          FOREIGN KEY (flight_number) REFERENCES flights(flight_number)
);


INSERT INTO aircrafts VALUES ('Boeing 747', 400), ('Airbus A330', 236), ('Boeing 777', 264);
INSERT INTO flights VALUES ('DL143', 'Boeing 747', 135), ('DL122', 'Airbus A330', 4370), ('DL222', 'Boeing 777', 1765);
INSERT INTO customers (customer_name, customer_status, total_customer_mileage)
VALUES ('Agustine Riviera', 'Silver', 115235), ('Tom Jones', 'Gold', 205767), ('Sam Rio', 'None', 2653);
INSERT INTO bookings (customer_id, flight_number) VALUES (1, 'DL143'), (2, 'DL222'), (3, 'DL143');


-- EXERCISE 3: Airline Database Queries

SELECT COUNT(*) FROM flights;


SELECT AVG(flight_mileage) FROM flights;


SELECT AVG(total_seats) FROM aircrafts;


SELECT customer_status, AVG(total_customer_mileage) FROM customers GROUP BY customer_status;


SELECT customer_status, MAX(total_customer_mileage) FROM customers GROUP BY customer_status;


SELECT COUNT(*) FROM aircrafts WHERE aircraft_model LIKE '%Boeing%';


SELECT * FROM flights WHERE flight_mileage BETWEEN 300 AND 2000;


SELECT c.customer_status, AVG(f.flight_mileage)
FROM bookings b
         JOIN customers c ON b.customer_id = c.customer_id
         JOIN flights f ON b.flight_number = f.flight_number
GROUP BY c.customer_status;