CREATE OR REPLACE FUNCTION dataset.get_all_dataset_meta()
RETURNS JSONB
LANGUAGE plpgsql
AS $$
DECLARE
_result JSONB;
BEGIN
SELECT jsonb_agg(to_jsonb(dm))
INTO _result
FROM dataset.dataset_meta dm;

RETURN _result;
END;
$$;