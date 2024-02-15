
CREATE TEMP TABLE decades AS
(
SELECT DISTINCT year::numeric AS year, (LEFT((year::varchar),3)||'0')::numeric AS decade
FROM publications
WHERE year::numeric BETWEEN 1970 AND 2019
ORDER BY year
);

CREATE INDEX decades_year_index ON decades (year);

ALTER TABLE inproceedings
ALTER COLUMN year TYPE numeric USING year::numeric;

DROP INDEX inproceedings_year_index;
CREATE INDEX inproceedings_year_index on inproceedings (year);

WITH conf_2018 AS
(
SELECT DISTINCT UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(REGEXP_SUBSTR(booktitle,'@.+'),'&|@+','//'), '/')) conference
FROM inproceedings
WHERE year = 2018
GROUP BY UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(REGEXP_SUBSTR(booktitle,'@.+'),'&|@+','//'), '/'))
),
conf_2010s AS
(
SELECT UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(REGEXP_SUBSTR(booktitle,'@.+'),'&|@+','//'), '/')) AS conference, co.year, COUNT(*) AS n_papers
FROM inproceedings co
LEFT JOIN decades d ON co.year = d.year
	WHERE d.decade = 2010
GROUP BY UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(REGEXP_SUBSTR(booktitle,'@.+'),'&|@+','//'), '/')), co.year
)


SELECT a.conference, a.year
FROM conf_2010s a
INNER JOIN conf_2018 b
	ON a.conference = b.conference
WHERE a.n_papers >= 200 AND b.conference <> ''
ORDER BY conference, a.year;
