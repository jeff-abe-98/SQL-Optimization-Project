ALTER TABLE proceedings
ALTER COLUMN year TYPE numeric USING year::numeric; /* Casting the year column to numeric in the proceedings table */

DROP INDEX inproceedings_year_index; /* Creating / Deleting indexes on tables for before and after purposes */

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
HAVING COUNT(title) > 1200 /* Count changed from 100 to 1200 since the window was switched from 1 month to 1 year*/
ORDER BY n_publications DESC;