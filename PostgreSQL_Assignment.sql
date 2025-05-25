-- Active: 1747736293017@@127.0.0.1@5432@conservation_db

CREATE TABLE Rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE Species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);


CREATE TABLE Sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES Species(species_id),
    ranger_id INT REFERENCES Rangers(ranger_id),
    "location"  VARCHAR(255),  
    sighting_time    TIMESTAMP,
    notes TEXT
);


INSERT INTO Rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range'),
('Daniel Frost', 'Western Cliffs'),
('Elena Moss', 'Eastern Glade'),
('Frank Stone', 'Deep Canyon'),
('Grace Lin', 'Highland Plateau'),
('Henry Wells', 'Foggy Forest'),
('Isla Ray', 'Crystal Marsh'),
('Jake Thorn', 'Sunset Valley');


INSERT INTO Species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Vulnerable'),
('Great Hornbill', 'Buceros bicornis', '1786-01-01', 'Near Threatened'),
('Sloth Bear', 'Melursus ursinus', '1791-01-01', 'Vulnerable'),
('Himalayan Monal', 'Lophophorus impejanus', '1790-01-01', 'Least Concern'),
('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Vulnerable'),
('Golden Langur', 'Trachypithecus geei', '1953-01-01', 'Endangered'),
('Indian Cobra', 'Naja naja', '1758-01-01', 'Least Concern'),
('Gaur', 'Bos gaurus', '1827-01-01', 'Vulnerable'),
('Indian Star Tortoise', 'Geochelone elegans', '1831-01-01', 'Vulnerable'),
('King Cobra', 'Ophiophagus hannah', '1836-01-01', 'Vulnerable'),
('Barasingha', 'Rucervus duvaucelii', '1823-01-01', 'Vulnerable'),
('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Vulnerable'),
('Himalayan Monal', 'Lophophorus impejanus', '1831-01-01', 'Least Concern'),
('Golden Langur', 'Trachypithecus geei', '1953-01-01', 'Endangered'),
('Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered')
;


INSERT INTO Sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(5, 4, 'Dryleaf Trail', '2024-05-19 11:50:00', 'Scat found nearby'),
(6, 5, 'Echo Canyon', '2024-05-20 06:15:00', 'Flying overhead'),
(7, 6, 'Bear Hollow', '2024-05-21 08:40:00', 'Tracks in mud'),
(8, 7, 'Monal Lookout', '2024-05-21 12:10:00', 'Pair sighted'),
(9, 8, 'Mist Valley', '2024-05-22 17:20:00', 'Resting in tree'),
(10, 9, 'Langur Point', '2024-05-23 13:00:00', 'Small group observed'),
(11, 10, 'Cobra Rock', '2024-05-24 15:30:00', 'Coiled under rock'),
(12, 1, 'Gaur Field', '2024-05-25 07:00:00', 'Herd of 4'),
(13, 2, 'Star Path', '2024-05-25 09:25:00', 'Basking in sun'),
(14, 3, 'King Pass', '2024-05-26 18:45:00', 'Slithering on trail'),
(15, 4, 'Antler Meadow', '2024-05-26 16:00:00', 'Pair grazing'),
(2, 5, 'Delta Bend', '2024-05-27 10:05:00', 'Adult male'),
(4, 6, 'Elephant Hollow', '2024-05-27 12:20:00', 'Fresh dung found'),
(3, 7, 'Panda Path', '2024-05-28 08:30:00', 'Climbing bamboo'),
(6, 8, 'Hornbill Crest', '2024-05-29 07:50:00', 'Nesting activity'),
(9, 9, 'Leopard Lane', '2024-05-29 19:00:00', 'Dusk movement');





--Problem 1:
INSERT INTO Rangers (name, region) VALUES ( 'Derek Fox','Coastal Plains');

--Problem 2:
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM Sightings;

--Problem 3:

SELECT * FROM Sightings 
    WHERE location LIKE '%Pass%';

--Problem 4:

SELECT name, COUNT(Sightings.sighting_id) AS total_sightings
FROM Rangers 
LEFT JOIN Sightings  USING(ranger_id)
GROUP BY name;


--Problem 5;
SELECT common_name
FROM Species 
LEFT JOIN Sightings  USING(species_id)
WHERE sighting_id IS NULL;

--Problem-6;

SELECT common_name,sighting_time, name FROM Sightings
    JOIN Species USING(species_id)
    JOIN Rangers USING(ranger_id)
    ORDER BY sighting_time
    LIMIT 2;

--Problem 7;

UPDATE Species 
 SET conservation_status = 'Historic'
 WHERE EXTRACT(YEAR FROM discovery_date) <1800;



--Problem -8;
SELECT 
  sighting_id,
  CASE 
    
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'

  END AS time_of_day
FROM Sightings;


-- Problem 9:
DELETE FROM Rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM Sightings WHERE ranger_id IS NOT NULL
);




