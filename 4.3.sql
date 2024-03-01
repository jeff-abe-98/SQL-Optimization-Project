CREATE TEMP TABLE decades AS /* Creating a temp table for decades, so that an index can be added */
(
SELECT DISTINCT year::numeric AS year, (LEFT(year::varchar,3)||'0')::numeric AS decade /* Casting columns to numeric so btree indexes can be added */
FROM publications
WHERE year::numeric BETWEEN 1970 AND 2019
ORDER BY year
);

/* Creating / Dropping indexes so a before and after can be measured*/
CREATE INDEX decades_year_index ON decades (year);
CREATE INDEX decades_decade_index ON decades (decade);

DROP INDEX decades_year_index;
DROP INDEX decades_decade_index;

/* Altering the publications table to use a numeric year column. This allowed for utilization of the btree index */
ALTER TABLE publications
ALTER COLUMN year TYPE numeric USING year::numeric;

/* Creating / Dropping indexes so a before and after can be measured */
CREATE INDEX publications_year_index ON publications (year);
DROP INDEX publications_year_index;

/* The query to count the number of publications by decade */
SELECT d.decade, COUNT(*)
FROM publications pu
INNER JOIN decades d ON d.year = pu.year
GROUP BY d.decade
ORDER BY d.decade DESC
;


