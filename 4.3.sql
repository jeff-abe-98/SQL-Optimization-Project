CREATE TEMP TABLE decades AS
(
SELECT DISTINCT year::numeric AS year, (LEFT(year::varchar,3)||'0')::numeric AS decade
FROM publications
WHERE year::numeric BETWEEN 1970 AND 2019
ORDER BY year
);

CREATE INDEX decades_year_index ON decades (year);
CREATE INDEX decades_decade_index ON decades (decade);

DROP INDEX decades_year_index;
DROP INDEX decades_decade_index;

ALTER TABLE publications
ALTER COLUMN year TYPE numeric USING year::numeric;

CREATE INDEX publications_year_index ON publications (year);
DROP INDEX publications_year_index;

SELECT d.decade, COUNT(*)
FROM publications pu
INNER JOIN decades d ON d.year = pu.year
GROUP BY d.decade
ORDER BY d.decade DESC
;

SELECT tablename, indexname, indexdef
FROM pg_indexes
;

