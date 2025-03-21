-- 1. number of visited cities per user (tables: users + cities + trips)
SELECT 
	t1.first_name,
	t1.last_name,
	t1.registration_date,
	count(distinct t3.city_name) as cities_visited_cnt
FROM users t1
	JOIN trips t2
		on t1.user_id=t2.user_id
	JOIN cities t3
		ON t2.city_arrival_id=t3.city_id
GROUP BY
	t1.first_name,
	t1.last_name,
	t1.registration_date;

-- 2. number of user registered in each month
SELECT 
	EXTRACT(YEAR FROM registration_date) as reg_year,
	EXTRACT(MONTH FROM registration_date) as reg_month,
	count(user_id) as users_cnt
FROM users
GROUP BY
	EXTRACT(YEAR FROM registration_date),
	EXTRACT(MONTH FROM registration_date);
	
-- 3. average number of users registred per month
SELECT 
	AVG(t.users_cnt) as avg_users_per_month
FROM 
	(SELECT 
		EXTRACT(MONTH FROM registration_date) as reg_month,
		EXTRACT(YEAR FROM registration_date) as reg_year,
		count(user_id) as users_cnt
	FROM users
	GROUP BY
		EXTRACT(MONTH FROM registration_date),
		EXTRACT(YEAR FROM registration_date)) t;

-- 4. how many users there are in total
SELECT 
	COUNT(user_id) as users_cnt
FROM users;
	
-- 5. number of users per city (users + cities)
SELECT 
	t2.city_name,
	count(t1.user_id) as users_cnt
FROM users t1
	JOIN cities t2
		ON t1.current_city_id=t2.city_id
GROUP BY
	t2.city_name;

-- 6. how many cities there are in total
SELECT 
	COUNT(city_id) as cities_cnt
FROM cities;

-- 7. covered distance per user (users + trips + trip_details + routes)
SELECT 
	t1.user_id,
	t1.first_name,
	t1.last_name,
	t1.registration_date,
	sum(t4.distance) as sum_distance
FROM users t1
	JOIN trips t2
		ON t1.user_id=t2.user_id
	JOIN trip_details t3
		ON t2.trip_id=t3.trip_id
	JOIN routes t4
		ON t4.route_id=t3.route_id
GROUP BY
	t1.user_id,
	t1.first_name,
	t1.last_name,
	t1.registration_date
ORDER BY sum(t4.distance) desc;

-- 8. how many interests there are in total
SELECT 
	COUNT(interest_id) as interests_cnt
FROM interests;

-- 9. most popular interests, interests without users (interests + users_interests)
SELECT 
	t1.interest_name,
	count(t2.user_id) as users_cnt
FROM interests t1
	LEFT JOIN user_interests t2
		ON t1.interest_id=t2.interest_id
GROUP BY 
	t1.interest_name
ORDER BY 
	count(t2.user_id) DESC

-- 10. number of interests per user, users without interests (users + users_interests)
SELECT 
	t1.user_id,
	t1.first_name,
	t1.last_name,
	t1.registration_date,
	count(t2.interest_id) as interests_cnt
FROM users t1
	LEFT JOIN user_interests t2
		ON t1.user_id=t2.user_id
GROUP BY 
	t1.user_id,
	t1.first_name,
	t1.last_name,
	t1.registration_date
ORDER BY 
	count(t2.interest_id) DESC

-- 11. most common interests in cities, interests without cities (interests + cities_interests)
SELECT 
	t1.interest_name,
	count(t2.city_id) as cities_cnt
FROM interests t1
	LEFT JOIN cities_interests t2
		ON t1.interest_id=t2.interest_id
GROUP BY 
	t1.interest_name
ORDER BY 
	count(t2.city_id) DESC

-- 12. number of interests per city, cities without added interests (cities + cities_interests)
SELECT 
	t1.city_name,
	t1.country,
	count(t2.interest_id) as interests_cnt
FROM cities t1
	LEFT JOIN cities_interests t2
		ON t1.city_id=t2.city_id
GROUP BY 
	t1.city_name,
	t1.country
ORDER BY 
	count(t2.interest_id) DESC
	
-- 13. how many route codes there are in total (route_codes)
SELECT 
	COUNT(route_code_id) as route_codes_cnt
FROM route_codes

-- 14. how many operators there are in total (route_codes)
SELECT 
	COUNT(distinct operator) as operators_cnt
FROM route_codes

-- 15. number of routes per operator (route_codes)
SELECT 
	operator,
	count(route_code_id) as routes_cnt
FROM route_codes
GROUP BY
	operator

-- 16. how many times each operator was used (route_codes + trips + routes)
SELECT 
	t1.operator,
	count(t3.trip_id) as trips_cnt
FROM route_codes t1
	JOIN routes t2
		ON t1.route_code_id=t2.route_code_id
	JOIN trip_details t3
		ON t2.route_id=t3.route_id
GROUP BY
	t1.operator

-- 17. how many stations there are overall (stations)
SELECT 
	count(station_name) as stations_cnt
FROM stations 

-- 18. how many stations each city has (cities + stations)
SELECT 
	t1.city_name,
	t1.country,
	count(station_name) as stations_cnt
FROM cities t1
	JOIN stations t2
		ON t1.city_id=t2.city_id
GROUP BY
	t1.city_name,
	t1.country
ORDER BY 
	count(station_name) DESC

-- 19. what amount of co2 emission each user has (users + trips + routes + emissions)
SELECT 
	t1.user_id,
	t1.first_name,
	t1.last_name,
	t1.registration_date,
	sum(t4.distance * co2_coef) as sum_emission
FROM users t1
	JOIN trips t2
		ON t1.user_id=t2.user_id
	JOIN trip_details t3
		ON t2.trip_id=t3.trip_id
	JOIN routes t4
		ON t4.route_id=t3.route_id
	JOIN emissions t5
		ON t5.transport_type='Electric train'
		AND ((t4.distance BETWEEN t5.min_distance AND t5.max_distance)
			or t5.max_distance is null)
GROUP BY
	t1.user_id,
	t1.first_name,
	t1.last_name,
	t1.registration_date
ORDER BY sum(t4.distance) desc;

-- 20. most popular cities to visit (cities + trips)
SELECT 
	t2.city_name,
	count(t1.trip_id) as trips_cnt,
	count(distinct t1.user_id) as unique_visitors_cnt
FROM trips t1
	JOIN cities t2
		ON t1.city_arrival_id=t2.city_id
GROUP BY 
	t2.city_name

-- 21. how many times each station was used (trips + stations)
SELECT 
	t1.station_name,
	count(t3.trip_id) as trips_cnt
FROM stations t1
	JOIN routes t2
		ON (t1.station_name = t2.station1_name
			OR t1.station_name = t2.station2_name)
	JOIN trip_details t3
		ON t2.route_id=t3.route_id
GROUP BY
	t1.station_name
	
-- 21. how many trips there are overall (trips)
SELECT 
	count(trip_id)
FROM trips 

-- 22. how many routes each trip had
SELECT 
	t1.trip_id,
	count(t2.route_id) as routes_cnt
FROM trips t1
	JOIN trip_details t2
		ON t1.trip_id=t2.trip_id
GROUP BY
	t1.trip_id

-- 23. how many routes per trip there are generally
SELECT
	t.routes_cnt as routes_per_trip,
	count(t.trip_id) as trips_cnt
FROM (SELECT 
		t1.trip_id,
		count(t2.route_id) as routes_cnt
	FROM trips t1
		JOIN trip_details t2
			ON t1.trip_id=t2.trip_id
	GROUP BY
		t1.trip_id) t
GROUP BY
	t.routes_cnt

-- 24. most popular months to travel historically 
SELECT 
	EXTRACT(MONTH FROM trip_date) as trip_month,
	EXTRACT(YEAR FROM trip_date) as trip_year,
	count(trip_id) as trips_cnt
FROM trips
GROUP BY
	EXTRACT(MONTH FROM trip_date),
	EXTRACT(YEAR FROM trip_date)
ORDER BY 
	count(trip_id) DESC

-- 25. how many trips there were each month in average
SELECT 
	AVG(t.trips_cnt) as avg_trips_per_month
FROM 
	(SELECT 
		EXTRACT(MONTH FROM trip_date) as trip_month,
		EXTRACT(YEAR FROM trip_date) as trip_year,
		count(trip_id) as trips_cnt
	FROM trips
	GROUP BY
		EXTRACT(MONTH FROM trip_date),
		EXTRACT(YEAR FROM trip_date)) t;

-- 26. how many transport types there are overall
SELECT 
	count(transport_type) as transport_types_cnt
FROM transport_types

-- 27. new city recommendations for a user based on users experiences (users, trips, users_interests, cities_interests, cities)
with interests_from_liked_cities as 
(SELECT 
	t1.user_id,
	t1.city_arrival_id,
	t2.interest_id
FROM trips t1
	JOIN cities_interests t2
		ON t1.city_arrival_id=t2.city_id
WHERE user_id=1 --  place user for whom we need a recommendations
	AND trip_rating in (4,5))

SELECT DISTINCT
	t1.city_id,
	t3.city_name
FROM cities_interests t1
	JOIN interests_from_liked_cities t2 
		ON t1.interest_id=t2.interest_id
		AND t1.city_id<>t2.city_arrival_id -- searching for the things, that person liked, in the cities, where he has never been
	JOIN cities t3
		ON t1.city_id=t3.city_id
	JOIN users t4 -- exclude current user's city 
		ON t2.user_id=t4.user_id
		AND t1.city_id<>t4.current_city_id
		
-- 28. new city recommendations for a user based on users preferences (users, users_interests, cities_interests, cities)
SELECT 
	t1.city_id,
	t3.city_name
FROM cities_interests t1
	JOIN user_interests t2 
		ON t1.interest_id=t2.interest_id
		AND t2.user_id=1 --  place user for whom we need a recommendations
	JOIN cities t3
		ON t1.city_id=t3.city_id
	JOIN users t4 
		ON t2.user_id=t4.user_id
		AND t1.city_id<>t4.current_city_id -- exclude current user's city 
	LEFT JOIN trips t5
		ON t5.user_id=t2.user_id
        AND t5.city_arrival_id=t1.city_id
WHERE t5.user_id is null -- excluding the cities where person already was