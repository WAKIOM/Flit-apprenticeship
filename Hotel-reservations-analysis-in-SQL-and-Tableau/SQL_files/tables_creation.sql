-- DATABASE AND TABLES CREATION
CREATE DATABASE flit;
USE flit;
-- create table
CREATE TABLE reservations (
    hotel VARCHAR(255),
    is_canceled INT,
    lead_time INT,
    arrival_year INT,
    arrival_month VARCHAR(255),
    arrival_week_number INT,
    arrival_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children INT,
    babies INT,
    meal VARCHAR(255),
    country VARCHAR(255),
    market_segment VARCHAR(255),
    distribution_channel VARCHAR(255),
    is_repeated_guest INT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type VARCHAR(255),
    assigned_room_type VARCHAR(255),
    booking_changes INT,
    deposit_type VARCHAR(255),
    booking_agent VARCHAR(255),
    booking_company VARCHAR(255),
    days_in_waiting_list INT,
    customer_type VARCHAR(255),
    average_daily_rate INT,
    required_car_parking_spaces INT,
    total_special_requests INT,
    reservation_status VARCHAR(255),
    reservation_status_date TEXT
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\hotel_reservations.csv'
INTO TABLE reservations
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
-- sneek peak of the data
SELECT * 
FROM reservations
LIMIT 5;

-- Uploading a table with countries and their codes 
CREATE TABLE countries
(country_name VARCHAR(255),
country_code VARCHAR(255));

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\country_names.csv'
INTO TABLE countries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 lines;
