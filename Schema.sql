DROP SCHEMA IF EXISTS SenatorVotes;
CREATE SCHEMA SenatorVotes;
USE SenatorVotes;

CREATE TABLE Senators
(
  ID    VARCHAR(4),
  first VARCHAR(30),
  last  VARCHAR(30),
  party VARCHAR(3),
  state VARCHAR(3),
  PRIMARY KEY (ID)

)

CREATE TABLE Votes
(
  number    VARCHAR(3),
  congress  VARCHAR(3),
  session   VARCHAR(1),
  year      VARCHAR(4),
  date      VARCHAR(30),
  PRIMARY KEY (congress, session, number)
)

CREATE TABLE VoteCast
(
  senator  VARCHAR(4),
  congress VARCHAR(3),
  session  VARCHAR(1),
  number   VARCHAR(3),
  vote     VARCHAR(1),
  FOREIGN KEY (senator) REFERENCES Senators (id),
  FOREIGN KEY (congress, session, number) REFERENCES Votes (congress, session, number)
)