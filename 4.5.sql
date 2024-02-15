ALTER TABLE proceedings
ALTER COLUMN year TYPE numeric USING year::numeric;

DROP INDEX inproceedings_year_index;

CREATE INDEX inproceedings_year_index ON inproceedings (year);
CREATE INDEX proceedings_year_index ON proceedings (year);

SELECT booktitle, COUNT(title) n_publications
FROM
(
SELECT booktitle, title FROM inproceedings
	WHERE year = 2017
UNION ALL
SELECT booktitle, title FROM proceedings
	WHERE year = 2017
) a
GROUP BY booktitle
HAVING COUNT(title) > 1200
ORDER BY n_publications DESC;