
CREATE TEMP TABLE decades AS /* Creating a temp table for decades */
(
SELECT DISTINCT year::numeric AS year, (LEFT((year::varchar),3)||'0')::numeric AS decade /* casting decade and year to numeric to set up btree index */
FROM publications
WHERE year::numeric BETWEEN 1970 AND 2019
ORDER BY year
);

CREATE INDEX decades_year_index ON decades (year);

ALTER TABLE inproceedings
ALTER COLUMN year TYPE numeric USING year::numeric; /* Casting year to numeric so it can be utilized in index searches */

DROP INDEX inproceedings_year_index; /* Dropping index for before and after comparison */
CREATE INDEX inproceedings_year_index on inproceedings (year);



WITH conf_2018 AS
(
SELECT DISTINCT UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(REGEXP_SUBSTR(booktitle,'@.+'),'&|@+','//'), '/')) conference /* Extracting conference titles from book titles by searching for everthing that starts with an @ */
FROM inproceedings
WHERE year = 2018
GROUP BY UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(REGEXP_SUBSTR(booktitle,'@.+'),'&|@+','//'), '/'))
),
conf_2010s AS /* CTE for count of papers by conference, by year for everything in the 2010s */
(
SELECT UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(REGEXP_SUBSTR(booktitle,'@.+'),'&|@+','//'), '/')) AS conference, co.year, COUNT(*) AS n_papers 
FROM inproceedings co
LEFT JOIN decades d ON co.year = d.year
	WHERE d.decade = 2010
GROUP BY UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(REGEXP_SUBSTR(booktitle,'@.+'),'&|@+','//'), '/')), co.year
)

/* Grabbing all the conferences and years, where the number of papers were greater than 200 */
SELECT a.conference, a.year
FROM conf_2010s a
INNER JOIN conf_2018 b
	ON a.conference = b.conference
WHERE a.n_papers >= 200 AND b.conference <> ''
ORDER BY conference, a.year;
