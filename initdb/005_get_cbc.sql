CREATE OR REPLACE FUNCTION dataset.get_cbc(
    _dataset_id INT,
    _gender SMALLINT DEFAULT NULL   -
)
RETURNS JSONB
LANGUAGE plpgsql
AS
$$
DECLARE
_result JSONB;
BEGIN
SELECT jsonb_agg(to_jsonb(c))
INTO _result
FROM dataset.cbc c
WHERE c.dataset_id = _dataset_id
  AND (_gender IS NULL OR c.gender = _gender);

RETURN COALESCE(_result, '[]'::JSONB);
END;
$$;