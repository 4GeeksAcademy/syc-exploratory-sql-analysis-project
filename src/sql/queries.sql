-- PLEASE READ THIS BEFORE RUNNING THE EXERCISE

-- ⚠️ IMPORTANT: This SQL file may crash due to two common issues: comments and missing semicolons.

-- ✅ Suggestions:
-- 1) Always end each SQL query with a semicolon `;`
-- 2) Ensure comments are well-formed:
--    - Use `--` for single-line comments only
--    - Avoid inline comments after queries
--    - Do not use `/* */` multi-line comments, as they may break execution

-- -----------------------------------------------
-- queries.sql
-- Complete each mission by writing your SQL query
-- directly below the corresponding instruction
-- -----------------------------------------------

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1
-- What are the first 10 recorded observations;
SELECT *
FROM observations
ORDER BY id
LIMIT 10;

-- MISSION 2
-- Which region identifiers (region_id) appear in the data;
SELECT DISTINCT region_id
FROM observations
ORDER BY region_id;

-- MISSION 3
-- How many distinct species (species_id) have been observed;
SELECT COUNT(DISTINCT species_id) AS distinct_species_observed
FROM observations;

-- MISSION 4
-- How many observations are there for the region with region_id = 2;
SELECT COUNT(*) AS observations_in_region_2
FROM observations
WHERE region_id = 2;

-- MISSION 5
-- How many observations were recorded on 1998-08-08;
SELECT COUNT(*) AS observations_on_1998_08_08
FROM observations
WHERE observation_date = '1998-08-08';

-- MISSION 6
-- Which region_id has the most observations;
SELECT region_id,
       COUNT(*) AS observation_count
FROM observations
GROUP BY region_id
ORDER BY observation_count DESC
LIMIT 1;

-- MISSION 7
-- What are the 5 most frequent species_id;
SELECT species_id,
       COUNT(*) AS observation_count
FROM observations
GROUP BY species_id
ORDER BY observation_count DESC
LIMIT 5;

-- MISSION 8
-- Which species (species_id) have fewer than 5 records;
SELECT species_id,
       COUNT(*) AS observation_count
FROM observations
GROUP BY species_id
HAVING COUNT(*) < 5
ORDER BY observation_count, species_id;

-- MISSION 9
-- Which observers (observer) recorded the most observations;
SELECT observer,
       COUNT(*) AS observation_count
FROM observations
GROUP BY observer
ORDER BY observation_count DESC
LIMIT 1;

-- MISSION 10
-- Show the region name (regions.name) for each observation;
SELECT
    o.id,
    o.species_id,
    o.region_id,
    r.name AS region_name,
    o.observer,
    o.observation_date,
    o.latitude,
    o.longitude,
    o.count
FROM observations AS o
JOIN regions AS r
    ON o.region_id = r.id;

-- MISSION 11
-- Show the scientific name of each recorded species (species.scientific_name);
SELECT
    o.id,
    o.species_id,
    s.scientific_name,
    o.region_id,
    o.observer,
    o.observation_date,
    o.latitude,
    o.longitude,
    o.count
FROM observations AS o
JOIN species AS s
    ON o.species_id = s.id;

-- MISSION 12
-- Which is the most observed species in each region;
-- This can return more than one row per region if there is a tie;
SELECT
    c.region_id,
    r.name AS region_name,
    c.species_id,
    s.scientific_name,
    c.observation_count
FROM (
    SELECT
        region_id,
        species_id,
        COUNT(*) AS observation_count
    FROM observations
    GROUP BY region_id, species_id
) AS c
JOIN (
    SELECT
        region_id,
        MAX(observation_count) AS max_count
    FROM (
        SELECT
            region_id,
            species_id,
            COUNT(*) AS observation_count
        FROM observations
        GROUP BY region_id, species_id
    ) AS x
    GROUP BY region_id
) AS m
    ON c.region_id = m.region_id
   AND c.observation_count = m.max_count
JOIN regions AS r
    ON c.region_id = r.id
JOIN species AS s
    ON c.species_id = s.id
ORDER BY c.region_id, c.species_id;