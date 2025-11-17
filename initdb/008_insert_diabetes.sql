CREATE OR REPLACE FUNCTION dataset.insert_diabetes(
    _name TEXT,
    _data JSONB
)
RETURNS INT
LANGUAGE plpgsql
AS
$$
DECLARE
_dataset_id INT;
BEGIN
INSERT INTO dataset.dataset_meta(name, type)
VALUES (_name, 'diabetes')
    RETURNING dataset_id INTO _dataset_id;

INSERT INTO dataset.diabetes(
    dataset_id,
    patient_id,
    gender,
    age,
    urea,
    creatinine,
    hba1c,
    chol,
    tg,
    hdl,
    ldl,
    vldl,
    bmi
)
SELECT
    _dataset_id,
    (item->>'patient_id')::INT,
        (item->>'gender')::SMALLINT,
        (item->>'age')::INT,
        (item->>'urea')::NUMERIC,
        (item->>'creatinine')::NUMERIC,
        (item->>'hba1c')::NUMERIC,
        (item->>'chol')::NUMERIC,
        (item->>'tg')::NUMERIC,
        (item->>'hdl')::NUMERIC,
        (item->>'ldl')::NUMERIC,
        (item->>'vldl')::NUMERIC,
        (item->>'bmi')::NUMERIC
FROM jsonb_array_elements(_data) AS item;

RETURN _dataset_id;
END;
$$;
