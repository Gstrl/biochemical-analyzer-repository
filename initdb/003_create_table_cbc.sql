CREATE TABLE dataset.cbc (
     dataset_id INT NOT NULL REFERENCES dataset.dataset_meta(dataset_id),
     patient_id INT NOT NULL,
     gender     SMALLINT,       -- 1 = Male, 2 = Female
     wbc        NUMERIC,        -- WBC
     ne         NUMERIC,        -- NE#
     ly         NUMERIC,        -- LY#
     mo         NUMERIC,        -- MO#
     eo         NUMERIC,        -- EO#
     ba         NUMERIC,        -- BA#
     rbc        NUMERIC,        -- RBC
     hgb        NUMERIC,        -- HGB
     hct        NUMERIC,        -- HCT
     mcv        NUMERIC,        -- MCV
     mch        NUMERIC,        -- MCH
     mchc       NUMERIC,        -- MCHC
     rdw        NUMERIC,        -- RDW
     plt        NUMERIC,        -- PLT
     mpv        NUMERIC,        -- MPV
     pct        NUMERIC,        -- PCT
     pdw        NUMERIC,        -- PDW
     sd         NUMERIC,        -- SD
     sdtsd      NUMERIC,        -- SDTSD
     tsd        NUMERIC,        -- TSD
     ferritin   NUMERIC,        -- FERRITTE
     folate     NUMERIC,        -- FOLATE
     b12        NUMERIC         -- B12
);

