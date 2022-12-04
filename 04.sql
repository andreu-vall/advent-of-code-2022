CREATE DATABASE adventofcode;
USE adventofcode;

DROP TABLE IF EXISTS assign;

CREATE TABLE assign (
    first_start int,
    first_end int,
    second_start int,
    second_end int
);

LOAD DATA
    LOCAL INFILE 'inputs/04.txt'
    INTO TABLE assign
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n';

SELECT * FROM assign LIMIT 5;

SELECT SUM((second_start >= first_start AND second_end <= first_end) OR 
        (first_start >= second_start AND first_end <= second_end)) FROM assign;

SELECT SUM((second_start >= first_start AND second_start <= first_end) OR 
        (first_start >= second_start AND first_start <= second_end)) FROM assign;

