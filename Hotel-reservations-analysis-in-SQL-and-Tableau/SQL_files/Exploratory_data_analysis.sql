-- EXPLORATORY DATA ANALYSIS
-- Average week_nights stay
SELECT AVG(stays_in_week_nights)
FROM hotel_reservations; -- 2 days on average

-- average weekend nights stay
SELECT AVG(stays_in_weekend_nights)
FROM hotel_reservations; -- 1 day on average

-- average average daily rate
SELECT AVG(average_daily_rate)
FROM hotel_reservations; -- 106

-- 1. percentage of people who prefer using a booking agent 
SELECT 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations))
FROM hotel_reservations 
WHERE booking_agent <> 'NULL'; -- 86% reservations booked using a booking agent

-- percentage of people who have booked using a booking company
SELECT 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) 
FROM hotel_reservations 
WHERE booking_company <> 'NULL'; -- 6% reservations booked using travelling agent

-- percentage of people who prefer not using either booking agent or booking company
SELECT 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations))
FROM hotel_reservations 
WHERE booking_agent  = 'NULL' AND booking_company = 'NULL'; -- 8% did not use booking agents or company

 -- Do people get assigned the room types they reserved?
 SELECT 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS reserved_is_assigned
 FROM hotel_reservations
 WHERE reserved_room_type = assigned_room_type; -- 85% bookings get assigned the rooms they reserved

-- Meal Package Analysis:
-- What are the most common meal packages reserved by guests?
SELECT meal, 100 *(COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS percentage_of_reservations
FROM hotel_reservations
GROUP BY meal
ORDER BY percentage_of_reservations DESC; -- Bed&breakfast 77.8%, No meal package 11%, half board 10%, full board 0.41%

-- Which countries contribute the most reservations? top 10
SELECT country, 100 *(COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS percentage_of_reservations
FROM hotel_reservations
GROUP BY country
ORDER BY percentage_of_reservations DESC
LIMIT 10;

-- How often do customers make changes or amendments to their reservation?
SELECT 
	CASE 
		WHEN booking_changes BETWEEN 1 AND 2 THEN '1 - 2 changes'
		WHEN booking_changes BETWEEN 3 AND 5  THEN '3 - 5 changes'
        WHEN booking_changes > 5 THEN '> 5 changes'
        ELSE booking_changes
	END AS Booking_changes
, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS percentage_of_reservations
FROM hotel_reservations
GROUP BY 
	CASE 
		WHEN booking_changes BETWEEN 1 AND 2 THEN '1 - 2 changes'
		WHEN booking_changes BETWEEN 3 AND 5  THEN '3 - 5 changes'
        WHEN booking_changes > 5 THEN '> 5 changes'
		ELSE booking_changes
	END
ORDER BY percentage_of_reservations DESC; -- only 18% of bookings made changes most of them making between  1 and 2 changes

-- What are the most common number of special requests made by customers?
SELECT 
	CASE 
		WHEN total_special_requests BETWEEN 1 AND 2 THEN '1 - 2 special requests'
		WHEN total_special_requests BETWEEN 3 AND 4  THEN '3 - 4 special requests'
        WHEN total_special_requests > 4 THEN '> 4 special requests'
        ELSE total_special_requests
	END AS total_special_requests
, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS percentage_of_reservations
FROM hotel_reservations
GROUP BY 
	CASE 
		WHEN total_special_requests BETWEEN 1 AND 2 THEN '1 - 2 special requests'
		WHEN total_special_requests BETWEEN 3 AND 4  THEN '3 - 4 special requests'
        WHEN total_special_requests > 4 THEN '> 4 special requests'
        ELSE total_special_requests
	END
ORDER BY percentage_of_reservations DESC; -- 46% of reservations had 1-2 special requests
 
-- successful reservations per hotel type
SELECT hotel, COUNT(hotel) AS num_of_reservations
FROM hotel_reservations
WHERE is_canceled = 'not canceled'
GROUP BY hotel
ORDER BY num_of_reservations DESC;

-- successful reservations per year
SELECT arrival_year, COUNT(*) as num_of_reservations
FROM hotel_reservations
WHERE is_canceled = 'not canceled'
GROUP BY arrival_year
ORDER BY num_of_reservations DESC; -- resrvations trippled from 2015 to 2016, then dropped from 2016 to 2017

-- successful reservations per month
SELECT arrival_month, COUNT(*) as num_of_reservations
FROM hotel_reservations
WHERE is_canceled = 'not canceled'
GROUP BY arrival_month
ORDER BY num_of_reservations DESC; -- August and July have the highest reservation  numbers while January and december have few reservations

-- How many customers require car parking spaces?
SELECT required_car_parking_spaces, COUNT(*) as num_of_reservations
FROM hotel_reservations
WHERE is_canceled = 'not canceled'
GROUP BY required_car_parking_spaces
ORDER BY num_of_reservations DESC; -- a large number of customers do not require parking spaces

-- Reservation status 
SELECT reservation_status, COUNT(*) as num_of_reservations
FROM hotel_reservations
GROUP BY reservation_status
ORDER BY num_of_reservations DESC; -- Majority of the reservations are successful, only a few No shows

-- customer distribution by market segment
SELECT market_segment, COUNT(*) as num_of_reservations
FROM hotel_reservations
GROUP BY market_segment
ORDER BY num_of_reservations DESC; -- Online travel agents make the highest number of reservations, followed by offline TA/TO

-- customer distribution by distribution_channel
SELECT distribution_channel, COUNT(*) as num_of_reservations
FROM hotel_reservations
GROUP BY distribution_channel
ORDER BY num_of_reservations DESC; -- Travel agents/Tour operators make the most reservations

-- customer distribution by reserved room type
SELECT reserved_room_type, COUNT(*) as num_of_reservations
FROM hotel_reservations
GROUP BY reserved_room_type
ORDER BY num_of_reservations DESC; -- A large number of the reservations reserve room type 	A, followed by D

-- reservations by repeat and non repeat guests
SELECT is_repeated_guest, COUNT(*) as num_of_reservations
FROM hotel_reservations
GROUP BY is_repeated_guest
ORDER BY num_of_reservations DESC; -- A very small number of reservations are repeat guests, high customer churn rate?

-- customer distribution by deposit type
SELECT deposit_type, COUNT(*) as num_of_reservations
FROM hotel_reservations
GROUP BY deposit_type
ORDER BY num_of_reservations DESC; -- 1. No deposit 2. Non refund 3. Refundable

-- customer distribution by customer_type
SELECT customer_type, COUNT(*) as num_of_reservations
FROM hotel_reservations
GROUP BY customer_type
ORDER BY num_of_reservations DESC; -- 1. Transient 2. Transient-Party 3. contract 4. group

-- Average days in waiting list
SELECT ROUND(AVG(days_in_waiting_list), 0) average_days_in_waiting_list
FROM hotel_reservations; -- 0 - 1 day in waiting list

-- do people like staying weekend nights ?
SELECT  100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) percentage_of_reservations
FROM hotel_reservations
WHERE stays_in_weekend_nights > 0; -- 59% book weekend nights

-- do people like staying week nights
SELECT  100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) percentage_of_reservations
FROM hotel_reservations
WHERE stays_in_week_nights > 0; -- 93% book week nights

-- do people stay in  both week nights and weekend nights
SELECT  100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) percentage_of_reservations
FROM hotel_reservations
WHERE stays_in_weekend_nights > 0 AND stays_in_week_nights; -- 53% book both weekday and weekend nights

-- do people reserve with children
SELECT  CASE
	WHEN children = 1 THEN '1 child'
    WHEN children = 2 THEN '2 children'
    WHEN children > 2 THEN '3+ children'
    ELSE children END AS children,
    100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) percentage_of_reservations
FROM hotel_reservations
GROUP BY CASE
	WHEN children = 1 THEN '1 child'
    WHEN children = 2 THEN '2 children'
    WHEN children > 2 THEN '3+ children'
    ELSE children END 
ORDER BY percentage_of_reservations DESC; -- 9.5% reserve with children, 1-2 children range

-- do people reserve with babies?
SELECT  100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) percentage_of_reservations
FROM hotel_reservations
WHERE babies > 0; -- 1% book with babies