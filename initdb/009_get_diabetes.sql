CREATE OR REPLACE FUNCTION dataset.get_diabetes(
    _dataset_id integer,
    _gender integer DEFAULT NULL,
    _patient_ids integer[] DEFAULT '{}'
)
RETURNS jsonb
LANGUAGE plpgsql
AS $$
DECLARE
_result jsonb;
    _info   jsonb;
BEGIN
SELECT to_jsonb(m)
INTO _info
FROM dataset.dataset_meta m
WHERE m.dataset_id = _dataset_id;

SELECT jsonb_agg(to_jsonb(d))
INTO _result
FROM dataset.diabetes d
WHERE d.dataset_id = _dataset_id
  AND (_gender IS NULL OR d.gender = _gender)
  AND (array_length(_patient_ids, 1) IS NULL OR d.patient_id = ANY(_patient_ids));

RETURN jsonb_build_object(
        'rows', COALESCE(_result, '[]'::jsonb),
        'info', _info
       );
END;
$$;
