
SELECT senator.lastname, senator.firstname, COUNT(vote)
FROM voted
JOIN senator ON (voted.sen_id = senator.id)
WHERE voted.vote = "A"
GROUP BY voted.sen_id

-- Mike Rounds was out of the country
-- Dan Sullivan had a funeral to attend

