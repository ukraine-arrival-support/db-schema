/*
  Create initial schema
*/

-- Table "station"

CREATE TABLE station AS (
  id text PRIMARY KEY
);
COMMENT ON TABLE station AS 'Table for station-level information';

-- Table "coordinator"
CREATE TABLE coordinator AS (
  name TEXT,
  station REFERENCES station(id),
  contact TEXT,
  ts_start TIMESTAMP WITHOUT TIMEZONE,
  ts_end TIMESTAMP WITHOUT TIMEZONE,
  role TEXT,
  tasks TEXT,
  comment TEXT,
  PRIMARY KEY(name, station, contact, ts_start)
);
COMMENT ON TABLE coordinator AS 'Table on coordinators per station';

-- Table "volunteer"
CREATE TABLE volunteer AS (
  name TEXT,
  station REFERENCES station(id),
  contact TEXT,
  ts_start TIMESTAMP WITHOUT TIMEZONE,
  ts_end TIMESTAMP WITHOUT TIMEZONE,
  share_contact BOOLEAN DEFAULT FALSE,
  languages JSONB,
  comment TEXT,
  PRIMARY KEY (name, station, contact, ts_start);
);
COMMENT ON TABLE volunteer AS 'Table of registered volunteers';

-- TABLE "incoming"
CREATE TABLE incoming AS (
  station REFERENCES station(id),
  id TEXT,
  platform INT DEFAULT NULL,
  ts_scheduled TIMESTAMP WITHOUT TIMEZONE,
  ts_estimated TIMSTAMP WITHOUT TIMEZONE,
  delay INT,
  ts_delay TIMESTAMP WITHOUT TIMEZONE DEFAULT NULL,
  type TEXT,
  passengers INT,
  PRIMARY KEY (station, id, ts_scheduled)
);
COMMENT ON TABLE incoming AS 'Table on incoming trains and buses';
