

SELECT author FROM
(
SELECT UNNEST(STRING_TO_ARRAY(author, '::')) as author, COUNT(*) AS n_published /* Un-nesting the authors from articles */
FROM articles
WHERE REGEXP_LIKE(journal,'([Dd]ata)') /* Filtering to journals with Data or data in them */
	GROUP BY UNNEST(STRING_TO_ARRAY(author, '::')) 
) j
INNER JOIN
(
SELECT UNNEST(STRING_TO_ARRAY(author, '::')) as author, COUNT(*) AS n_published /* Un-nesting the authors from inproceedings */
FROM inproceedings
WHERE REGEXP_LIKE(booktitle,'([Dd]ata)') /* Filtering to titles with Data or data in them */
	GROUP BY UNNEST(STRING_TO_ARRAY(author, '::'))
) co
USING(author)
ORDER BY j.n_published+co.n_published DESC
LIMIT 10 /* Ordered descending and limited to the top 10 results */
;