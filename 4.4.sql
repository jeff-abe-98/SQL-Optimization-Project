SELECT author FROM
(
SELECT UNNEST(STRING_TO_ARRAY(author, '::')) as author, COUNT(*) AS n_published
FROM articles
WHERE REGEXP_LIKE(journal,'([Dd]ata)')
	GROUP BY UNNEST(STRING_TO_ARRAY(author, '::'))
) j
INNER JOIN
(
SELECT UNNEST(STRING_TO_ARRAY(author, '::')) as author, COUNT(*) AS n_published
FROM inproceedings
WHERE REGEXP_LIKE(booktitle,'([Dd]ata)')
	GROUP BY UNNEST(STRING_TO_ARRAY(author, '::'))
) co
USING(author)
ORDER BY j.n_published+co.n_published DESC
LIMIT 10
;