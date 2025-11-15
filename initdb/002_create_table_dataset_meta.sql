CREATE TABLE dataset.dataset_meta (
      dataset_id   SERIAL PRIMARY KEY,
      name       TEXT NOT NULL,
      type       TEXT NOT NULL
);