-- CRUD
-- 1.cities
INSERT INTO cities (city_name, country)
VALUES ('Oranienburg', 'Germany');

SELECT * FROM cities;

UPDATE cities
SET city_name = 'Hamburg'
WHERE city_id = 11;

DELETE FROM cities
WHERE city_id = 11;

-- 2.users
INSERT INTO users (first_name, last_name, current_city_id, registration_date)
VALUES ('Judas', 'Iscariot', 2, CURDATE());

SELECT * FROM users;

UPDATE users
SET last_name = 'Schmidt'
WHERE user_id = 11;

DELETE FROM users
WHERE user_id = 11;

-- 3.interests
INSERT INTO interests (interest_name)
VALUES ('Lake');

SELECT * FROM interests;

UPDATE interests
SET interest_name = 'Mountain'
WHERE interest_id = 11;

DELETE FROM interests
WHERE interest_id = 11;

-- 4.user_interests
INSERT INTO user_interests (user_id, interest_id)
VALUES (1, 5);

SELECT * FROM user_interests;

UPDATE user_interests
SET interest_id = 10
WHERE user_id = 1 and interest_id=2;

DELETE FROM user_interests
WHERE user_id = 1 and interest_id=4;

-- 5.cities_interests
INSERT INTO cities_interests (city_id, interest_id)
VALUES (1, 1);

SELECT * FROM cities_interests;

UPDATE cities_interests
SET interest_id = 2
WHERE city_id = 1 and interest_id=1;

DELETE FROM cities_interests
WHERE city_id = 3 and interest_id=3;

-- 6.transport_types
INSERT INTO transport_types (transport_type)
VALUES ('Yacht');

SELECT * FROM transport_types;

UPDATE transport_types
SET transport_type = 'Boat'
WHERE transport_type = 'Yacht';

DELETE FROM transport_types
WHERE transport_type = 'Boat';

-- 7.route_codes
INSERT INTO route_codes (route_name, operator)
VALUES ('RE 9', 'Ostdeutsche Eisenbahn');

SELECT * FROM route_codes;

UPDATE route_codes
SET route_name = 'RB 14'
WHERE route_code_id = 11;

DELETE FROM route_codes
WHERE route_code_id = 11;

-- 8.stations
INSERT INTO stations (station_name, city_id)
VALUES ('Berlin-Charlottenburg', 1);

SELECT * FROM stations;

UPDATE stations
SET station_name = 'Ostbahnhof'
WHERE station_name = 'Berlin-Charlottenburg';

DELETE FROM stations
WHERE station_name = 'Ostbahnhof';

-- 9.emissions
INSERT INTO emissions (transport_type, min_distance, max_distance, co2_coef)
VALUES ('Car', 0, 50, 0.1);

SELECT * FROM emissions;

UPDATE emissions
SET co2_coef = 0.11
WHERE emission_id = 11;

DELETE FROM emissions
WHERE emission_id = 11;

-- 10.routes
INSERT INTO routes (route_code_id, station1_name, station2_name, distance)
VALUES (7, 'Berlin Hbf', 'Rostock Hbf', 191);

SELECT * FROM routes;

UPDATE routes
SET distance = 188
WHERE route_id = 11;

DELETE FROM routes
WHERE route_id = 11;

-- 11.trips
INSERT INTO trips (user_id, city_departure_id, city_arrival_id, trip_date, trip_rating)
VALUES (6, 1, 4, '2025-03-10', 5);

SELECT * FROM trips;

UPDATE trips
SET city_arrival_id = 3
WHERE trip_id = 11;

DELETE FROM trips
WHERE trip_id = 11;

-- 12.trip_details
INSERT INTO trip_details (trip_id, route_id)
VALUES (9, 3),
(9, 6);

SELECT * FROM trip_details;

UPDATE trip_details
SET route_id = 5
WHERE trip_detail_id = 15;

DELETE FROM trip_details
WHERE trip_detail_id in (15, 16);