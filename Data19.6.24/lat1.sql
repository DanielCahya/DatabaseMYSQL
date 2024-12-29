DROP DATABASE IF EXISTS dblat1Cursor;
CREATE DATABASE dblat1Cursor;
USE dblat1Cursor;

CREATE TABLE tblAtlit(
    id INT,
    nama VARCHAR(100),
    sex VARCHAR(255),
    age VARCHAR(255),
    height VARCHAR(255),
    weight VARCHAR(255),
    team VARCHAR(255),
    noc VARCHAR(100),
    games VARCHAR(255),
    year VARCHAR(50),
    season VARCHAR(255),
    city VARCHAR(255),
    sport VARCHAR(255),
    event VARCHAR(255),
    medal VARCHAR(255)
);

LOAD DATA LOCAL INFILE 'F:\\NoDoubt\\DatabaseProgramming\\Data19.6.24\\athlete_events.csv'
INTO TABLE tblAtlit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM tblAtlit
limit 100;

SELECT DISTINCT(sport)
FROM tblAtlit;

SELECT DISTINCT(sex)
FROM tblAtlit;

