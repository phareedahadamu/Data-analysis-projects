/*View listings_1 table*/
SELECT * FROM airbnb_info.listings_1;

/* Retrieve all hosts with the number of listings they have broken down by room type*/
SELECT DISTINCT t1.host_name, t2.private_room_count, t3.entire_home_count, t4.shared_room_count,
COUNT(t1.host_name) OVER(PARTITION BY t1.host_id) AS total_listings_count
FROM airbnb_info.listings_1 AS t1
LEFT JOIN (SELECT DISTINCT host_name, host_id,
COUNT(host_id) OVER(PARTITION BY host_id) AS private_room_count
FROM airbnb_info.listings_1
WHERE room_type = 'Private room') AS t2
ON t1.host_name = t2.host_name AND t1.host_id = t2.host_id
LEFT JOIN(SELECT DISTINCT host_name, host_id,
COUNT(host_id) OVER(PARTITION BY host_id) AS entire_home_count
FROM airbnb_info.listings_1
WHERE room_type = 'Entire home/apt') AS t3
ON t1.host_name = t3.host_name AND t1.host_id = t3.host_id
LEFT JOIN (SELECT DISTINCT host_name, host_id,
COUNT(host_id) OVER(PARTITION BY host_id) AS shared_room_count
FROM airbnb_info.listings_1
WHERE room_type = 'Shared room') AS t4
ON t1.host_name = t4.host_name AND t1.host_id = t4.host_id
ORDER BY total_listings_count DESC;

/*Retrieve room_types, the minimum and maximum prices for the type and the neighbourhoods where the minimum and
maximum price listings are located*/
WITH table1 AS
(SELECT DISTINCT t1.room_type, t1.neighbourhood_cleansed AS min_price_neighbourhood, t2.min_price
FROM airbnb_info.listings_1 AS t1
RIGHT JOIN (SELECT room_type,
MIN(price) OVER(PARTITION BY room_type) AS min_price
FROM airbnb_info.listings_1) AS t2
ON t1.room_type = t2.room_type AND t1.price = t2.min_price),
table2 AS
(SELECT DISTINCT t3.room_type, t3.neighbourhood_cleansed AS max_price_neighbourhood, t4.max_price
FROM airbnb_info.listings_1 AS t3
RIGHT JOIN (SELECT room_type,
MAX(price) OVER(PARTITION BY room_type) AS max_price
FROM airbnb_info.listings_1) AS t4
ON t3.room_type = t4.room_type AND t3.price = t4.max_price)
SELECT table1.room_type, table1.min_price_neighbourhood, table1.min_price, table2.max_price_neighbourhood, table2.max_price
FROM table1
LEFT JOIN table2
ON table1.room_type = table2.room_type;

/* Retrieve the count of each of the room types in each neighbourhood*/
SELECT DISTINCT t1.neighbourhood_cleansed, t2.entire_home_count, t3.private_room_count, t4.shared_room_count
FROM airbnb_info.listings_1 AS t1
LEFT JOIN (SELECT DISTINCT neighbourhood_cleansed,
COUNT(room_type) OVER(PARTITION BY neighbourhood_cleansed) AS entire_home_count
FROM airbnb_info.listings_1
WHERE room_type = 'Entire home/apt') AS t2
ON t1.neighbourhood_cleansed = t2.neighbourhood_cleansed
LEFT JOIN (SELECT DISTINCT neighbourhood_cleansed,
COUNT(room_type) OVER(PARTITION BY neighbourhood_cleansed) AS private_room_count
FROM airbnb_info.listings_1
WHERE room_type = 'Private room') AS t3
ON t1.neighbourhood_cleansed = t3.neighbourhood_cleansed
LEFT JOIN (SELECT DISTINCT neighbourhood_cleansed,
COUNT(room_type) OVER(PARTITION BY neighbourhood_cleansed) AS shared_room_count
FROM airbnb_info.listings_1
WHERE room_type = 'Shared room') AS t4
ON t1.neighbourhood_cleansed = t4.neighbourhood_cleansed;

/* Retrieve neighbourhoods, the minimum, maximum and average price per room_type in each of them*/
SELECT DISTINCT neighbourhood_cleansed,
AVG(price) OVER(PARTITION BY neighbourhood_cleansed) AS avg_price,
MIN(price) OVER(PARTITION BY neighbourhood_cleansed) AS min_price,
MAX(price) OVER(PARTITION BY neighbourhood_cleansed) AS max_price
FROM airbnb_info.listings_1
ORDER BY min_price DESC;

/*View calendar table*/
SELECT * FROM airbnb_info.calendar;

/* Retrieve listing_name, hosts_name, room_type, price, the count of booked days on the calendar and the total amount*/
SELECT DISTINCT t1.`name`, t1.host_name, t1.room_type, t1.price,
COUNT(t2.listing_id) OVER(PARTITION BY t2.listing_id) AS booked_days,
SUM(t1.price) OVER(PARTITION BY t2.listing_id) AS total
FROM airbnb_info.listings_1 AS t1
LEFT JOIN airbnb_info.calendar AS t2
ON t1.id = t2.listing_id
WHERE t2.available = 'f'
ORDER BY total DESC;

/* Retrieve neighbourhoods and the average number of booked days in the month */
WITH t1 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 6 AND YEAR(`date`) = 2024),
t2 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 7 AND YEAR(`date`) = 2024),
t3 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 8 AND YEAR(`date`) = 2024),
t4 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 9 AND YEAR(`date`) = 2024),
t5 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 10 AND YEAR(`date`) = 2024),
t6 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 11 AND YEAR(`date`) = 2024),
t7 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 12 AND YEAR(`date`) = 2024),
t8 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 1 AND YEAR(`date`) = 2025),
t9 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 2 AND YEAR(`date`) = 2025),
t10 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 3 AND YEAR(`date`) = 2025),
t11 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 4 AND YEAR(`date`) = 2025),
t12 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 5 AND YEAR(`date`) = 2025),
t13 AS
(SELECT DISTINCT listing_id,
COUNT(listing_id) OVER(PARTITION BY listing_id) AS `count`
FROM airbnb_info.calendar
WHERE available = 'f' AND MONTH(`date`) = 6 AND YEAR(`date`) = 2025)
SELECT DISTINCT neighbourhood_cleansed,
AVG(t1.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS june_2024,
AVG(t2.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS july_2024,
AVG(t3.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS august_2024,
AVG(t4.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS september_2024,
AVG(t5.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS october_2024,
AVG(t6.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS november_2024,
AVG(t7.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS december_2024,
AVG(t8.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS january_2025,
AVG(t9.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS february_2025,
AVG(t10.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS march_2025,
AVG(t11.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS april_2025,
AVG(t12.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS may_2025,
AVG(t13.`count`) OVER(PARTITION BY neighbourhood_cleansed) AS june_2025
FROM airbnb_info.listings_1
LEFT JOIN t1 ON id = t1.listing_id
LEFT JOIN t2 ON id = t2.listing_id
LEFT JOIN t3 ON id = t3.listing_id
LEFT JOIN t4 ON id = t4.listing_id
LEFT JOIN t5 ON id = t5.listing_id
LEFT JOIN t6 ON id = t6.listing_id
LEFT JOIN t7 ON id = t7.listing_id
LEFT JOIN t8 ON id = t8.listing_id
LEFT JOIN t9 ON id = t9.listing_id
LEFT JOIN t10 ON id = t10.listing_id
LEFT JOIN t11 ON id = t11.listing_id
LEFT JOIN t12 ON id = t12.listing_id
LEFT JOIN t13 ON id = t13.listing_id;