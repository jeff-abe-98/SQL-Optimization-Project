/* First attempt at the query using CTEs for each individual conference*/


WITH sigmod AS 
(
SELECT UNNEST(STRING_TO_ARRAY(author, '::')) as author, COUNT(*) n_articles
FROM inproceedings
WHERE REGEXP_LIKE(booktitle,'(SIGMOD)')
GROUP BY UNNEST(STRING_TO_ARRAY(author, '::'))
),
pvldb AS
(
SELECT UNNEST(STRING_TO_ARRAY(author, '::')) as author, COUNT(*) n_articles
FROM inproceedings
WHERE REGEXP_LIKE(booktitle,'(VLDB)')
GROUP BY UNNEST(STRING_TO_ARRAY(author, '::'))
)

SELECT s.author
FROM sigmod s
INNER JOIN pvldb pv
ON pv.author = s.author AND pv.n_articles >=10 AND s.n_articles >=10
;

/* Query re-written to use case statements in the having section. This allowed for the query to have no CTEs or subqueries, which sped up the process*/

SELECT UNNEST(STRING_TO_ARRAY(author, '::')) as author
FROM inproceedings
WHERE REGEXP_LIKE(booktitle,'(SIGMOD)') OR REGEXP_LIKE(booktitle,'(VLDB)')
GROUP BY UNNEST(STRING_TO_ARRAY(author, '::'))
HAVING SUM(CASE WHEN REGEXP_LIKE(booktitle,'(SIGMOD)') THEN 1 ELSE 0 END) >=10 AND SUM(CASE WHEN REGEXP_LIKE(booktitle,'(VLDB)') THEN 1 ELSE 0 END) >= 10
;