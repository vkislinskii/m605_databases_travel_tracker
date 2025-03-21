-- 1. stored procedures for frequent queries

-- number of travels per months 
DELIMITER \\
CREATE PROCEDURE travel_statistics (IN start_date DATE) 
BEGIN 
SELECT 
	EXTRACT(MONTH FROM trip_date) as trip_month,
	EXTRACT(YEAR FROM trip_date) as trip_year,
	count(trip_id) as trips_cnt
FROM trips
WHERE trip_date >= start_date
GROUP BY
	EXTRACT(MONTH FROM trip_date),
	EXTRACT(YEAR FROM trip_date)
ORDER BY 
	count(trip_id) DESC
;
END \\
DELIMITER ;

CALL travel_statistics('2025-02-01');

-- visited cities of one user
DELIMITER \\
CREATE PROCEDURE get_user_travels (IN userId INT) 
BEGIN 
SELECT 
	t2.trip_date,
	t3.city_name
FROM users t1
	JOIN trips t2
		on t1.user_id=t2.user_id
	JOIN cities t3
		on t2.city_arrival_id=t3.city_id
WHERE t1.user_id=userId
;
END \\
DELIMITER ;

CALL get_user_travels(1);

-- all trips for a specific company for the last N days
DELIMITER \\
CREATE PROCEDURE get_operator_travels (IN n INT, oper_company VARCHAR(50)) 
BEGIN 
SELECT 
	t1.route_name,
	t4.trip_date,
	count(t3.trip_id) as trips_cnt
FROM route_codes t1
	JOIN routes t2
		ON t1.route_code_id=t2.route_code_id
	JOIN trip_details t3
		ON t2.route_id=t3.route_id
	JOIN trips t4
		ON t3.trip_id=t4.trip_id
WHERE t1.operator=oper_company
	AND t4.trip_date>=DATE_ADD(CURDATE(), INTERVAL -n DAY) 
GROUP BY
	t1.route_name,
	t4.trip_date

;
END \\
DELIMITER ;

CALL get_operator_travels(30, 'Ostdeutsche Eisenbahn'); 

-- 2. indexes
explain select * from users where last_name='Smith'; -- 0.391

CREATE INDEX idx_last_name ON users(last_name);

SHOW INDEXES FROM users;
