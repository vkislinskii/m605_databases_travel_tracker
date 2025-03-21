-- 1. schema creation
create schema db_sql;

use db_sql;


-- 2 tables creation
-- cities dictionary
CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(50),
    country VARCHAR(50)
);
-- information about users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
	current_city_id INT, 
	registration_date DATE,
	FOREIGN KEY (current_city_id) REFERENCES cities(city_id)
);

-- interests dictionary
CREATE TABLE interests (
    interest_id INT AUTO_INCREMENT PRIMARY KEY,
    interest_name VARCHAR(50)
);
-- which interests has each user 
CREATE TABLE user_interests (
    user_id INT,
	interest_id INT,
	PRIMARY KEY (user_id, interest_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id), 
    FOREIGN KEY (interest_id) REFERENCES interests(interest_id)
);
-- which points of interest has each city 
CREATE TABLE cities_interests (
    city_id INT,
	interest_id INT,
	PRIMARY KEY (city_id, interest_id),
    FOREIGN KEY (city_id) REFERENCES cities(city_id), 
    FOREIGN KEY (interest_id) REFERENCES interests(interest_id) 
);
-- transport types dictionary
CREATE TABLE transport_types (
    transport_type VARCHAR(50) PRIMARY KEY
);
-- route codes dictionary
CREATE TABLE route_codes (
    route_code_id INT AUTO_INCREMENT PRIMARY KEY,
	route_name VARCHAR(10),
	operator VARCHAR(50)
);
-- stations dictionary
CREATE TABLE stations (
    station_name VARCHAR(50) PRIMARY KEY, 
	city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
); 
-- emissions dictionary
CREATE TABLE emissions (
    emission_id INT AUTO_INCREMENT PRIMARY KEY,
    transport_type VARCHAR(50),
    min_distance INT, 
	max_distance INT, 
    co2_coef DECIMAL (5,3),
	FOREIGN KEY (transport_type) REFERENCES transport_types(transport_type)
);
-- existing train routes between two stations
CREATE TABLE routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
	route_code_id INT,
	station1_name VARCHAR(50),
	station2_name VARCHAR(50), 
    distance INT,
    FOREIGN KEY (route_code_id) REFERENCES route_codes(route_code_id), 
    FOREIGN KEY (station1_name) REFERENCES stations(station_name), 
	FOREIGN KEY (station2_name) REFERENCES stations(station_name)
);
-- trips that users took and overall metrics (rank that user gave to a city and carbon emmissions that user caused)
CREATE TABLE trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
    city_departure_id INT,
    city_arrival_id INT,
    trip_date DATE,
    trip_rating INT,
    FOREIGN KEY (city_departure_id) REFERENCES cities(city_id),
    FOREIGN KEY (city_arrival_id) REFERENCES cities(city_id), 
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);
-- one trip can have multiple trains. this table has info about all of the routes user had
CREATE TABLE trip_details (
    trip_detail_id INT AUTO_INCREMENT PRIMARY KEY,
	trip_id INT,
	route_id INT,
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id), 
    FOREIGN KEY (route_id) REFERENCES routes(route_id)
);
