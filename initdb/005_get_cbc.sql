CREATE OR REPLACE FUNCTION dataset.get_cbc(
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

-- выборка данных
SELECT jsonb_agg(to_jsonb(c))
INTO _result
FROM dataset.cbc c
WHERE c.dataset_id = _dataset_id
  AND (_gender IS NULL OR c.gender = _gender)
  AND (array_length(_patient_ids, 1) IS NULL OR c.patient_id = ANY(_patient_ids));

RETURN jsonb_build_object(
        'rows', COALESCE(_result, '[]'::jsonb),
        'info', _info
       );
END;
$$;

ALTER FUNCTION dataset.get_cbc(integer, integer, integer[]) OWNER TO "user";
