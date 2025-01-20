DROP SCHEMA IF EXISTS TennisMatches;
CREATE SCHEMA TennisMatches;
CREATE TABLE player
(id     VARCHAR(6) NOT NULL AUTO_INCREMENT,
 hand    VARCHAR(1),
 CHECK (hand = 'L' OR 'R')
 height   int,
 country   VARCHAR(3),
 ranking   INT,
 CHECK (ranking > 0)
 PRIMARY KEY (id)   
);
CREATE TABLE match
(match_num     INT(3) NOT NULL AUTO_INCREMENT,
 date  DATE,
 PRIMARY KEY (match_num,date),  
);
CREATE TABLE tournment
(id    VARCHAR(9) NOT NULL AUTO_INCREMENT,
);
CREATE TABLE played
(match_num  INT(3),
date   DATE,
player_id  VARCHAR(6),
winner_id  INT(6),
aces    INT(3),
double_faults INT(3),
FOREIGN KEY (match_num,date) REFERENCES match(match_num,date),
FOREIGN KEY (player_id) REFERENCES player(id),
PRIMARY KEY (match_num,date,player_id,winner_id),
)