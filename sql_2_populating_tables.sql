INSERT INTO cities (city_name, country)
VALUES
('Berlin', 'Germany'),
('Potsdam', 'Germany'),
('Magdeburg', 'Germany'),
('Dessau-Roßlau', 'Germany'),
('Frankfurt (Oder)', 'Germany'),
('Leipzig', 'Germany'),
('Cottbus', 'Germany'),
('Schwerin', 'Germany'),
('Brandenburg', 'Germany'),
('Rostock', 'Germany');

INSERT INTO users (first_name, last_name, current_city_id, registration_date)
VALUES
('Bob', 'Kelso', 1, '2025-01-17'),
('John', 'Smith', 1, '2025-02-05'),
('Mike', 'Evans', 2, '2025-03-15'),
('Robert', 'Thomas', 1, '2025-03-01'),
('Sheldon', 'Cooper', 2, '2025-02-11'),
('Robin', 'Scherbatsky', 2, '2025-02-18'),
('Michael', 'Carter', 1, '2025-02-10'),
('James', 'Taylor', 1, '2025-02-15'),
('Sarah', 'Connor', 1, '2025-03-05'),
('Michael', 'Pearson', 1, '2025-03-10');

INSERT INTO interests (interest_name)
VALUES
('Museum'),
('Cathedral'),
('Monument'),
('Park'),
('Castle'),
('Palace'),
('Architectural landmark'),
('Theatre'),
('Zoo'),
('Observation deck');

INSERT INTO user_interests (user_id, interest_id)
VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 4),
(2, 9),
(9, 2),
(9, 3),
(9, 5),
(9, 7),
(9, 10);

INSERT INTO cities_interests (city_id, interest_id)
VALUES
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(5, 1),
(5, 2),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 7),
(6, 8),
(6, 9),
(6, 10),
(6, 1),
(6, 2);

INSERT INTO transport_types (transport_type)
VALUES
('Electric train'),
('Airplane'),
('Bus'),
('Motorcycle'),
('Car'),
('Ferry'),
('Bicycle'),
('Horse'),
('Cruise ship'),
('Snowmobile');

INSERT INTO route_codes (route_name, operator)
VALUES
('RE 1', 'Ostdeutsche Eisenbahn'),
('RE 2', 'DB Regio AG Nordost'),
('RE 7', 'DB Regio AG Nordost'),
('RE 13', 'DB Regio AG Südost'),
('RE 8', 'Ostdeutsche Eisenbahn'),
('RE 1', 'DB Regio AG Nordost'),
('RE 5', 'DB Regio AG Nordost'),
('RE 4', 'DB Regio AG Nordost'),
('RE 20', 'DB Regio AG Nordost'),
('RB 10', 'DB Regio AG Nordost');

INSERT INTO stations (station_name, city_id)
VALUES
('Berlin Hbf', 1),
('Frankfurt (Oder)', 5),
('Magdeburg Hbf', 3),
('Dessau Hbf', 4),
('Leipzig Hbf', 6),
('Potsdam Hbf', 2),
('Cottbus Hbf', 7),
('Schwerin Hbf', 8),
('Brandenburg Hbf', 9),
('Rostock Hbf', 10);

INSERT INTO emissions (transport_type, min_distance, max_distance, co2_coef)
VALUES
('Electric train', 0, null, 0.02),
('Airplane', 0, 1500, 0.2),
('Airplane', 1500, 3500, 0.125),
('Airplane', 3500, null, 0.095),
('Bus', 50, 300, 0.05),
('Bus', 300, null, 0.04),
('Car', 50, 300, 0.06),
('Car', 300, null, 0.05),
('Ferry', 0, 50, 0.15),
('Ferry', 50, null, 0.08);

INSERT INTO routes (route_code_id, station1_name, station2_name, distance)
VALUES
(5, 'Berlin Hbf', 'Schwerin Hbf', 181),
(6, 'Schwerin Hbf', 'Rostock Hbf', 127),
(3, 'Berlin Hbf', 'Dessau Hbf', 118),
(4, 'Leipzig Hbf', 'Magdeburg Hbf', 102),
(4, 'Magdeburg Hbf', 'Dessau Hbf', 53),
(4, 'Dessau Hbf', 'Leipzig Hbf', 54),
(2, 'Berlin Hbf', 'Cottbus Hbf', 122),
(1, 'Potsdam Hbf', 'Brandenburg Hbf', 34),
(1, 'Potsdam Hbf', 'Magdeburg Hbf', 102),
(1, 'Brandenburg Hbf', 'Magdeburg Hbf', 71);

INSERT INTO trips (user_id, city_departure_id, city_arrival_id, trip_date, trip_rating)
VALUES
(1, 1, 4, '2025-02-10', 5),
(1, 1, 6, '2025-02-15', 3),
(1, 1, 7, '2025-03-01', 4),
(2, 2, 9, '2025-02-12', 5),
(2, 2, 3, '2025-02-20', 5),
(3, 1, 7, '2025-02-01', 3),
(3, 1, 10, '2025-02-25', 4),
(3, 1, 8, '2025-03-10', 5),
(4, 1, 6, '2025-02-02', 4),
(5, 1, 6, '2025-02-05', 4);

INSERT INTO trip_details (trip_id, route_id)
VALUES
(1, 3),
(2, 3),
(2, 6),
(3, 7),
(4, 8),
(5, 9),
(6, 7),
(7, 1),
(7, 2),
(8, 1),
(9, 3),
(9, 6),
(10, 3),
(10, 6);