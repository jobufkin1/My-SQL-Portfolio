SELECT firstname, lastname, COUNT(vote) FROM senator LEFT OUTER JOIN
(SELECT * FROM voted
WHERE vote = "A") AS absent_votes
ON (absent_votes.sen_id = senator.id)
GROUP BY firstname, lastname
