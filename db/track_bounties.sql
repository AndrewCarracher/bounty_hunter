DROP TABLE IF EXISTS track_bounties;

CREATE TABLE track_bounties(
  id SERIAL8  PRIMARY KEY,
  name                VARCHAR(255),
  species             VARCHAR(255),
  last_known_location VARCHAR(255),
  bounty_value        INT
);
