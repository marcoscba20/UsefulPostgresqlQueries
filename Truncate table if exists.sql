
CREATE OR REPLACE FUNCTION dwh.fc_truncate_table_if_exists(p_table_name text)
  RETURNS void
  LANGUAGE plpgsql
AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM information_schema.tables
    WHERE table_schema = 'dwh'
    AND table_name = p_table_name
  ) THEN
    EXECUTE 'TRUNCATE TABLE dwh.' || p_table_name;
  END IF;
END;
$$;

