SELECT firstname, lastname, party,
COALESCE(disagreements.num_disagrees,0) AS "disagree",
COALESCE(agreements.num_agrees,0) AS "agree",
COALESCE(((agreements.num_agrees - disagreements.num_disagrees)/(agreements.num_agrees + disagreements.num_disagrees)),0) AS 'Index'

FROM
(SELECT sen_id, COUNT(sen2.vote) AS num_disagrees
FROM
(SELECT number AS num1, vote AS vote1
FROM voted
WHERE sen_id = 'S309') AS sen1

JOIN

voted AS sen2
ON sen1.vote1 != sen2.vote AND sen1.num1 = sen2.number
WHERE sen1.vote1 != 'A' AND sen2.vote != 'A'
GROUP BY sen_id) AS disagreements

JOIN

(SELECT sen_id, COUNT(2sen.vote) AS num_agrees
FROM
(SELECT number AS num2, vote AS vote2
FROM voted
WHERE sen_id = 'S309') AS sen

JOIN
voted AS 2sen
ON sen.vote2 = 2sen.vote AND sen.num2 = 2sen.number
WHERE sen.vote2 != 'A' OR 2sen.vote != 'A'
GROUP BY sen_id) AS agreements

RIGHT JOIN

senator
ON senator.id = disagreements.sen_id AND senator.id = agreements.sen_id
ORDER BY agree DESC;
