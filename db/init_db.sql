-- -------------------------------
-- FormulaVision Phase 0: DB Schema
-- -------------------------------

-- 1. Teams
CREATE TABLE IF NOT EXISTS teams (
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    base VARCHAR(100),
    team_principal VARCHAR(100),
    power_unit VARCHAR(100)
);

-- 2. Drivers
CREATE TABLE IF NOT EXISTS drivers (
    driver_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    nationality VARCHAR(50),
    date_of_birth DATE,
    team_id INT REFERENCES teams(team_id)
);

-- 3. Circuits
CREATE TABLE IF NOT EXISTS circuits (
    circuit_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100),
    country VARCHAR(50),
    length_km DECIMAL(5,2)
);

-- 4. Seasons
CREATE TABLE IF NOT EXISTS seasons (
    year INT PRIMARY KEY,
    champion_team_id INT REFERENCES teams(team_id),
    champion_driver_id INT REFERENCES drivers(driver_id)
);

-- 5. Races
CREATE TABLE IF NOT EXISTS races (
    race_id SERIAL PRIMARY KEY,
    season_year INT REFERENCES seasons(year),
    circuit_id INT REFERENCES circuits(circuit_id),
    name VARCHAR(100),
    date DATE
);

-- 6. Results
CREATE TABLE IF NOT EXISTS results (
    result_id SERIAL PRIMARY KEY,
    race_id INT REFERENCES races(race_id),
    driver_id INT REFERENCES drivers(driver_id),
    team_id INT REFERENCES teams(team_id),
    position INT,
    laps INT,
    grid_position INT,
    points DECIMAL(5,2),
    fastest_lap_time TIME
);

-- 7. Telemetry (optional for future Phase 2/3)
CREATE TABLE IF NOT EXISTS telemetry (
    telemetry_id SERIAL PRIMARY KEY,
    race_id INT REFERENCES races(race_id),
    driver_id INT REFERENCES drivers(driver_id),
    lap INT,
    sector_1_time DECIMAL(5,3),
    sector_2_time DECIMAL(5,3),
    sector_3_time DECIMAL(5,3),
    lap_time DECIMAL(5,3)
);

-- 8. Example view: race results summary
CREATE OR REPLACE VIEW vw_race_results AS
SELECT 
    r.race_id,
    r.name AS race_name,
    s.year AS season,
    d.first_name || ' ' || d.last_name AS driver_name,
    t.name AS team_name,
    res.position,
    res.points
FROM results res
JOIN races r ON res.race_id = r.race_id
JOIN drivers d ON res.driver_id = d.driver_id
JOIN teams t ON res.team_id = t.team_id
JOIN seasons s ON r.season_year = s.year;
