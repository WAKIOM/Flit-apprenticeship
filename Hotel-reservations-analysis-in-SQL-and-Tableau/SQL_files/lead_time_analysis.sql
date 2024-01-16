-- LEAD TIME ANALYSIS
-- What is the average lead time
SELECT ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations; -- average lead time is 80 days

-- What is the average lead time for different hotel types
SELECT hotel, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY hotel; -- City hotel 78 days, Resort hotel 83 days

-- average lead time for different years
SELECT arrival_year, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY arrival_year
ORDER BY average_lead_time DESC; -- 2015(59), 2016(76), 2017(94) 

-- average lead time per market segments
SELECT market_segment, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY market_segment
ORDER BY average_lead_time DESC; -- Groups and Offline TA/TO tend to reserve early in advance

-- average lead time per distribution channel
SELECT distribution_channel, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY distribution_channel
ORDER BY average_lead_time DESC; -- TA/TO 89

-- average lead time for repeat and non repeat guests
SELECT is_repeated_guest, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY is_repeated_guest; -- repeat guests seem to have a low avg lead time(17 days) compared to non repeat guests(82)

-- average lead time per reserved room type
SELECT reserved_room_type, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY reserved_room_type
ORDER BY average_lead_time DESC; -- B 113, E 88, D 83

-- average lead time per customer type
SELECT customer_type, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY customer_type
ORDER BY average_lead_time DESC; -- Transient-party 113 days and contract 109 days reserve early.

-- average lead time per deposit type
SELECT deposit_type, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY deposit_type
ORDER BY average_lead_time DESC; -- Non refund reservations are done early in advance, 211 days, No deposit are last 78(unsure reservations?)

-- average leadtimes for different months
SELECT arrival_month, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY arrival_month
ORDER BY average_lead_time DESC; -- July has the highest avg lead time

-- average lead time for countries
SELECT country, ROUND(AVG(lead_time), 0) AS average_lead_time
FROM hotel_reservations
GROUP BY country
ORDER BY average_lead_time DESC; -- fiji reservations have a leadtime of 322 days, benin 274