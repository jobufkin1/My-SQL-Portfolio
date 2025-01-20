-- S309 Bod Casey

SELECT lastname, firstname, COALESCE(num_disagreements,0) FROM
(SELECT sen_id, COUNT(sen_id) as num_disagreements
FROM voted

JOIN

(SELECT number as n1, vote as v1, sen_id as id
FROM voted WHERE sen_id = "S413") AS sen1

ON (n1 = number) AND (v1 != vote)
WHERE (v1 != "A") AND (vote != "A")
GROUP BY sen_id) as allsen

RIGHT OUTER JOIN
senator
ON senator.id = allsen.sen_id
