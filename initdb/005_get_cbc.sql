CREATE OR REPLACE FUNCTION dataset.get_cbc(
    _dataset_id INT,
    _gender SMALLINT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
AS
$$
DECLARE
_result JSONB;
    _info JSONB;
BEGIN
SELECT to_jsonb(m)
INTO _info
FROM dataset.dataset_meta m
WHERE m.dataset_id = _dataset_id;

SELECT jsonb_agg(to_jsonb(c))
INTO _result
FROM dataset.cbc c
WHERE c.dataset_id = _dataset_id
  AND (_gender IS NULL OR c.gender = _gender);

RETURN jsonb_build_object(
        'rows', COALESCE(_result, '[]'::JSONB),
        'info', _info
       );
END;
$$;