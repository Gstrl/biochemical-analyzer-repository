CREATE TABLE dataset.diabetes (
      dataset_id  INT NOT NULL REFERENCES dataset.dataset_meta(dataset_id),
      patient_id  INT NOT NULL,
      gender      SMALLINT,
      age         INT,
      urea        NUMERIC,
      creatinine  NUMERIC,
      hba1c       NUMERIC,
      chol        NUMERIC,
      tg          NUMERIC,
      hdl         NUMERIC,
      ldl         NUMERIC,
      vldl        NUMERIC,
      bmi         NUMERIC
);