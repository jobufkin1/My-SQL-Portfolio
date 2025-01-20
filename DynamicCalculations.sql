-- Authors: Kylee Taylor and Emily Lara --

--
DROP FUNCTION IF EXISTS aceCount; 
DELIMITER //
CREATE FUNCTION aceCount(myPlaysName VARCHAR(50), myStart DATE, myFinish DATE) RETURNS INTEGER READS SQL DATA
BEGIN
DECLARE avgAce INT;
SET avgAce = (
  SELECT AVG(ace)
  FROM
    (SELECT myPlaysName AS player_name, Player.player_id, match_id, ace
    FROM Plays JOIN Player
    WHERE Plays.player_id = Player.player_id) AS table1,
    (SELECT match_id, tourney_date
    FROM Tournaments JOIN Matches
    WHERE Tournaments.tourney_id = Matches.tourney_id) AS table2
  WHERE table1.match_id = table2.match_id AND
    tourney_date > myStart AND
    tourney_date < myFinish AND
    table1.player_name = myPlaysName
  GROUP BY table1.player_name;
);
  RETURN avgAce;
END//
DELIMITER ;

--------------------------------------------------------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS showAggregateStatistics;
DELIMITER //
CREATE PROCEDURE showAggregateStatistics(IN myPlaysName VARCHAR(100), IN myStart DATE, IN myFinish DATE)
BEGIN
  SELECT AVG(ace), AVG(double_faults)
  FROM
    (SELECT myPlaysName AS player_name, Player.player_id, match_id, ace, double_faults
    FROM Plays JOIN Player
    WHERE Plays.player_id = Player.player_id) AS table1,
    (SELECT match_id, tourney_date
    FROM Tournaments JOIN Matches
    WHERE Tournaments.tourney_id = Matches.tourney_id) AS table2
  WHERE table1.match_id = table2.match_id AND
    tourney_date > myStart AND
    tourney_date < myFinish AND
    table1.player_name = myPlaysName
  GROUP BY table1.player_name;
END//
DELIMITER ;

--------------------------------------------------------------------------------------------------------------------------
DROP VIEW IF EXISTS TopAces;
CREATE VIEW TopAces AS
    SELECT player_name, MAX(ace) FROM 
    Player NATURAL JOIN Plays
    GROUP BY player_name
    ORDER BY ace DESC
    LIMIT 10;

--------------------------------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS onInsertionPlayer;
DELIMITER //
CREATE TRIGGER onInsertionPlayer BEFORE INSERT ON Player FOR EACH ROW
BEGIN
IF NEW.player_ioc = 'RUS' OR NEW.player_ioc = 'EST' THEN
SET NEW.player_ioc = 'USR';
END IF;
END//
DELIMITER ;