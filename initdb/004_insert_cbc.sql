CREATE OR REPLACE FUNCTION dataset.insert_cbc(
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
    -- вставка метаданных
INSERT INTO dataset.dataset_meta(name, type)
VALUES (_name, 'cbc')
    RETURNING dataset_id INTO _dataset_id;

-- вставка данных с patient_id
INSERT INTO dataset.cbc(
    dataset_id,
    patient_id,  -- добавили
    gender, wbc, ne, ly, mo, eo, ba,
    rbc, hgb, hct, mcv, mch, mchc, rdw,
    plt, mpv, pct, pdw, sd, sdtsd, tsd,
    ferritin, folate, b12
)
SELECT
    _dataset_id,
    (item->>'patient_id')::INT,
        (item->>'gender')::SMALLINT,
        (item->>'wbc')::NUMERIC,
        (item->>'ne')::NUMERIC,
        (item->>'ly')::NUMERIC,
        (item->>'mo')::NUMERIC,
        (item->>'eo')::NUMERIC,
        (item->>'ba')::NUMERIC,
        (item->>'rbc')::NUMERIC,
        (item->>'hgb')::NUMERIC,
        (item->>'hct')::NUMERIC,
        (item->>'mcv')::NUMERIC,
        (item->>'mch')::NUMERIC,
        (item->>'mchc')::NUMERIC,
        (item->>'rdw')::NUMERIC,
        (item->>'plt')::NUMERIC,
        (item->>'mpv')::NUMERIC,
        (item->>'pct')::NUMERIC,
        (item->>'pdw')::NUMERIC,
        (item->>'sd')::NUMERIC,
        (item->>'sdtsd')::NUMERIC,
        (item->>'tsd')::NUMERIC,
        (item->>'ferritin')::NUMERIC,
        (item->>'folate')::NUMERIC,
        (item->>'b12')::NUMERIC
FROM jsonb_array_elements(_data) AS item;

RETURN _dataset_id;
END;
$$;
