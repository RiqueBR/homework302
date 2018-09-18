DROP TABLE IF EXISTS property_trackers;

CREATE TABLE property_trackers (
  id SERIAL4 PRIMARY KEY,
  build VARCHAR(255),
  address VARCHAR(255),
  value INT8,
  bedroom_quantity INT8
);
