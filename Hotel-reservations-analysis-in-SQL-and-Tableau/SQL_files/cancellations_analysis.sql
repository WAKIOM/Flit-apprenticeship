-- Cancellation rates 
-- What is the overall cancelation rate?
SELECT 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_rsvp
FROM hotel_reservations
WHERE is_canceled = 'canceled'; -- 27.5% overall cancelation rate

-- Get a breakdown of the cancelation rates distribution across different fields.

-- cancellation rates across hotel groups
SELECT hotel, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY hotel; -- city hotels(18%) have a higher cancelation rate than resort hotels(9%)

-- are people with children likely to cancel?
SELECT  CASE
	WHEN children = 1 THEN '1 child'
    WHEN children = 2 THEN '2 children'
    WHEN children > 2 THEN '3+ children'
    ELSE children END AS children,
    100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) percentage_of_cancelations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY CASE
	WHEN children = 1 THEN '1 child'
    WHEN children = 2 THEN '2 children'
    WHEN children > 2 THEN '3+ children'
    ELSE children END 
ORDER BY percentage_of_cancelations DESC; -- number of children has no correlation with cancelation rate

-- are non repeat guests likely to cancel?
SELECT is_repeated_guest, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY is_repeated_guest; -- almost all cancelations(27.19%) are from non repeat guests, repeat guests are not likely to cancel

-- cancellation rate per distribution_channel
SELECT distribution_channel, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY distribution_channel; -- tour agents/operators reservations are most likely to get canceled (24%)

 -- cancellation rate per market_segment
SELECT market_segment, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY market_segment; -- 20% Online travel agents, 2% offline travel agents

 --  are people who used booking companies likely to cancel?
SELECT  100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled' AND booking_company <> 'NULL';  -- an insignificant percentage of cancelations are from booking company reservations

--  are people who used booking agents likely to cancel?
SELECT  100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled' AND booking_agent <> 'NULL'; -- 25% of cancelations are from booking agents

 -- cancellations  per customer type
 SELECT customer_type, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY customer_type; -- transient customers have the highest cancellation rate(24%)

-- which month has a higher cancellation rate?
SELECT arrival_month, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS perc_canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY arrival_month
ORDER BY perc_canceled_reservations DESC; -- August and July have the leading cancellation rates as they also have high reservation rates
-- Are there countries with a higher tendency to cancel bookings?
SELECT country, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS perc_canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY country
ORDER BY perc_canceled_reservations DESC
LIMIT 10; -- countries that have high booking rates also have the highest cancelation numbers
-- are people with certain deposit types likely to cancel?
SELECT deposit_type, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY deposit_type
ORDER BY canceled_reservations DESC; -- people with no deposit reservation type are likely to cancel
-- are people with special requests likely to cancel?
SELECT  100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled' AND total_special_requests > 0; -- 10% of the canceled reservations from people who have made special requests
-- are people who have been in waiting list likely to cancel?
SELECT  100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled' AND days_in_waiting_list > 0; -- 0.34% canceled reservations. Being on waitlist doesnt make people cancel
-- do people cancel when they don't get the room they reserved?
SELECT  100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS canceled_reservations
FROM hotel_reservations
WHERE is_canceled = 'canceled' AND reserved_room_type <> assigned_room_type; -- not getting the room they reserve doesnt correlate with cancelation

-- are people with many booking changes likely to cancel?
SELECT 
	CASE 
		WHEN booking_changes BETWEEN 1 AND 2 THEN '1 - 2 changes'
		WHEN booking_changes BETWEEN 3 AND 5  THEN '3 - 5 changes'
        WHEN booking_changes > 5 THEN '> 5 changes'
        ELSE booking_changes
	END AS Booking_changes
, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS percentage_of_cancelations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY 
	CASE 
		WHEN booking_changes BETWEEN 1 AND 2 THEN '1 - 2 changes'
		WHEN booking_changes BETWEEN 3 AND 5  THEN '3 - 5 changes'
        WHEN booking_changes > 5 THEN '> 5 changes'
		ELSE booking_changes
	END
ORDER BY percentage_of_cancelations DESC; -- booking changes have no corellation with cancelations
-- are people with special requests likely to cancel? 
SELECT 
	CASE 
		WHEN total_special_requests BETWEEN 1 AND 2 THEN '1 - 2 special requests'
		WHEN total_special_requests BETWEEN 3 AND 4  THEN '3 - 4 special requests'
        WHEN total_special_requests > 4 THEN '> 4 special requests'
        ELSE total_special_requests
	END AS total_special_requests
, 100 * (COUNT(*)/(SELECT COUNT(*) FROM hotel_reservations)) AS percentage_of_cancelations
FROM hotel_reservations
WHERE is_canceled = 'canceled'
GROUP BY 
	CASE 
		WHEN total_special_requests BETWEEN 1 AND 2 THEN '1 - 2 special requests'
		WHEN total_special_requests BETWEEN 3 AND 4  THEN '3 - 4 special requests'
        WHEN total_special_requests > 4 THEN '> 4 special requests'
        ELSE total_special_requests
	END
ORDER BY percentage_of_cancelations DESC; -- people with 1-2 special requests are likely to cancel