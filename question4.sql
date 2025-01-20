SELECT COUNT(*)  FROM

(SELECT number as n1, vote as v1
FROM voted JOIN senator
ON (voted.sen_id = senator.id)
WHERE ID = "S413") AS t1

JOIN

(SELECT number as n2, vote as v2
FROM voted JOIN senator
ON (voted.sen_id = senator.id)
WHERE ID = "S411") AS t2

ON t1.n1 = t2.n2 AND t1.v1 != t2.v2
WHERE v1 != "A" AND v2 != "A"

-- the result of this query was 268
