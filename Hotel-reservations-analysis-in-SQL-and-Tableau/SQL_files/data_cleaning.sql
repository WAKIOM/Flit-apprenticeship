-- DATA CLEANING
-- check if there are duplicates
SELECT COUNT(*) as `duplicate groups found`
FROM (
SELECT *
FROM reservations
GROUP BY hotel, is_canceled, lead_time, arrival_year, arrival_month, arrival_week_number,
       arrival_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children,
       babies, meal, country, market_segment, distribution_channel, is_repeated_guest,
       previous_cancellations, previous_bookings_not_canceled, reserved_room_type,
       assigned_room_type, booking_changes, deposit_type, booking_agent, booking_company,
       days_in_waiting_list, customer_type, average_daily_rate, required_car_parking_spaces,
       total_special_requests, reservation_status, reservation_status_date
HAVING COUNT(*) > 1
) AS dups;

-- check total duplicate rows
WITH duplicates AS (
    SELECT *, ROW_NUMBER() OVER (
			PARTITION BY hotel, is_canceled, lead_time, arrival_year, arrival_month, arrival_week_number,
			arrival_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children,
			babies, meal, country, market_segment, distribution_channel, is_repeated_guest,
			previous_cancellations, previous_bookings_not_canceled, reserved_room_type,
			assigned_room_type, booking_changes, deposit_type, booking_agent, booking_company,
			days_in_waiting_list, customer_type, average_daily_rate, required_car_parking_spaces,
			total_special_requests, reservation_status, reservation_status_date
			ORDER BY hotel
		) AS row_num
FROM reservations
)
SELECT COUNT(*) AS duplicated_rows, 100 * (COUNT(*)/(SELECT COUNT(*) FROM reservations)) AS duplicated_rows_percentage
FROM duplicates
WHERE row_num > 1; -- 32,019 rows of duplicates , 26.8 % of the data is duplicated

-- create a new table without duplicates, then clean the columns of the new table, leaving the original table untouched
CREATE TABLE hotel_reservations AS
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY hotel, is_canceled, lead_time, arrival_year, arrival_month, arrival_week_number,
               arrival_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children,
               babies, meal, country, market_segment, distribution_channel, is_repeated_guest,
               previous_cancellations, previous_bookings_not_canceled, reserved_room_type,
               assigned_room_type, booking_changes, deposit_type, booking_agent, booking_company,
               days_in_waiting_list, customer_type, average_daily_rate, required_car_parking_spaces,
               total_special_requests, reservation_status, reservation_status_date
               ORDER BY hotel
           ) AS row_num
    FROM reservations
) AS duplicates
WHERE row_num = 1;

-- Drop the row num column
ALTER TABLE hotel_reservations
DROP COLUMN row_num;

-- DEEPER DATA CLEANING
ALTER TABLE hotel_reservations
MODIFY COLUMN is_canceled VARCHAR(255),
MODIFY COLUMN is_repeated_guest VARCHAR(255);
UPDATE hotel_reservations
SET 
	is_canceled = CASE
		WHEN is_canceled = 0 THEN 'not canceled'
		WHEN is_canceled = 1 THEN 'canceled'
	END,
	is_repeated_guest = CASE
		WHEN is_repeated_guest = 0 THEN 'not repeated guest'
		WHEN is_repeated_guest = 1 THEN 'repeated guest'
	END,
-- Update the meal column based on the description mapping
	meal = CASE 
        WHEN meal = 'BB' THEN 'Bed & Breakfast'  
        WHEN meal IN ('Undefined', 'SC') THEN 'No meal package'
        WHEN meal = 'HB' THEN 'Half board' 
        WHEN meal = 'FB' THEN 'Full board' 
        ELSE meal
    END,
-- update market segment column
	market_segment = CASE
		WHEN market_segment = 'Online TA' THEN 'Online Travel Agents'
        WHEN market_segment = 'Offline TA/TO' THEN 'Offline Travel Agents/Tour Operators'
        ELSE market_segment
	END,
-- update distribution channel column
	distribution_channel = CASE
        WHEN distribution_channel = 'TA/TO' THEN 'Travel Agents/Tour Operators'
        ELSE distribution_channel
	END;

-- clean the reservation status date column
-- Alter the table to add a new date column
ALTER TABLE hotel_reservations
ADD COLUMN rsvp_status_date DATE;
-- Update the new date column by converting the varchar column
UPDATE hotel_reservations
SET rsvp_status_date = STR_TO_DATE(reservation_status_date, '%d/%m/%Y');
-- Drop the old varchar column
ALTER TABLE hotel_reservations
DROP COLUMN reservation_status_date;
-- Rename the new date column back to reservation_status_date
ALTER TABLE hotel_reservations
CHANGE COLUMN rsvp_status_date reservation_status_date DATE;

-- update the country column with their respective country names from the countries table
UPDATE hotel_reservations AS h
JOIN countries AS c
ON h.country = c.country_code
SET h.country = c.country_name;

-- how many countries are missing?
SELECT 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS missing_countries
FROM hotel_reservations
WHERE country = 'NULL'; -- 0.51 % of the whole dataset