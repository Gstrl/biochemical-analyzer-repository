CREATE OR REPLACE FUNCTION dataset.insert_dataset_with_cbc(
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
WITH ins_meta AS (
INSERT INTO dataset.dataset_meta(name, type)
VALUES (_name, 'cbc')
    RETURNING dataset_id
    )
SELECT dataset_id INTO _dataset_id FROM ins_meta;

INSERT INTO dataset.cbc(
    dataset_id,
    gender, wbc, ne, ly, mo, eo, ba,
    rbc, hgb, hct, mcv, mch, mchc, rdw,
    plt, mpv, pct, pdw, sd, sdtsd, tsd,
    ferritin, folate, b12
)
VALUES (
           _dataset_id,
           (_data->>'gender')::SMALLINT,
           (_data->>'wbc')::NUMERIC,
           (_data->>'ne')::NUMERIC,
           (_data->>'ly')::NUMERIC,
           (_data->>'mo')::NUMERIC,
           (_data->>'eo')::NUMERIC,
           (_data->>'ba')::NUMERIC,
           (_data->>'rbc')::NUMERIC,
           (_data->>'hgb')::NUMERIC,
           (_data->>'hct')::NUMERIC,
           (_data->>'mcv')::NUMERIC,
           (_data->>'mch')::NUMERIC,
           (_data->>'mchc')::NUMERIC,
           (_data->>'rdw')::NUMERIC,
           (_data->>'plt')::NUMERIC,
           (_data->>'mpv')::NUMERIC,
           (_data->>'pct')::NUMERIC,
           (_data->>'pdw')::NUMERIC,
           (_data->>'sd')::NUMERIC,
           (_data->>'sdtsd')::NUMERIC,
           (_data->>'tsd')::NUMERIC,
           (_data->>'ferritin')::NUMERIC,
           (_data->>'folate')::NUMERIC,
           (_data->>'b12')::NUMERIC
       );

RETURN _dataset_id;
END;
$$;
