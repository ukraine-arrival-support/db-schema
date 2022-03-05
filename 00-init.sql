/*
  Create initial schema
*/

-- Table "station"

BEGIN;

CREATE TABLE station (
  label TEXT PRIMARY KEY
);

COMMENT ON TABLE station IS 'Table for station-level information';

INSERT INTO station (label)
VALUES
  ('Hbf (Train)'),
  ('ZOB (Bus)'),
  ('Suedkreuz (Bus)'),
  ('Ostbahnhof (Train)');

-- Table "coordinator"
CREATE TABLE coordinator (
  name TEXT,
  station TEXT,
  contact TEXT,
  ts_start TIMESTAMP WITHOUT TIME ZONE,
  ts_end TIMESTAMP WITHOUT TIME ZONE,
  role TEXT,
  tasks TEXT,
  comment TEXT,
  PRIMARY KEY(name, station, contact, ts_start),
  CONSTRAINT
    fk_coordinator_station FOREIGN KEY(station) REFERENCES station(label) ON UPDATE CASCADE
);

COMMENT ON TABLE coordinator IS 'Table on coordinators per station';

-- Table "volunteer"
CREATE TABLE volunteer (
  name TEXT,
  station TEXT,
  contact TEXT,
  ts_start TIMESTAMP WITHOUT TIME ZONE,
  ts_end TIMESTAMP WITHOUT TIME ZONE,
  share_contact BOOLEAN DEFAULT FALSE,
  languages JSONB,
  comment TEXT,
  PRIMARY KEY (name, station, contact, ts_start),
  CONSTRAINT
    fk_volunteer_station FOREIGN KEY(station) REFERENCES station(label) ON UPDATE CASCADE
);
COMMENT ON TABLE volunteer IS 'Table of registered volunteers';

-- TABLE "incoming"
CREATE TABLE incoming (
  station TEXT,
  id TEXT,
  platform INT DEFAULT NULL,
  ts_scheduled TIMESTAMP WITHOUT TIME ZONE,
  ts_estimated TIMESTAMP WITHOUT TIME ZONE,
  delay INT,
  ts_delay TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL,
  type TEXT,
  passengers INT,
  PRIMARY KEY (station, id, ts_scheduled),
  CONSTRAINT
    fk_incoming_station FOREIGN KEY(station) REFERENCES station(label) ON UPDATE CASCADE
);
COMMENT ON TABLE incoming IS 'Table on incoming trains and buses';
COMMIT;

