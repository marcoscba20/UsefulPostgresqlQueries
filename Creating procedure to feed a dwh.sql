CREATE OR REPLACE PROCEDURE dwh_vtas.sp_dim_vendedores()
LANGUAGE plpgsql
AS $$
DECLARE
    v_query text;
    v_dwh_table text;
BEGIN
    -- We will insert data into this table of dwh
    v_dwh_table = 'dim_vendedores';
    -- Set the query to populate the table structure
    v_query := '
        SELECT --TOP 100
            ven_Cod AS dven_codigovendedor,
            ven_Desc AS dven_vendedor,
            ven_Tel AS dven_telefono,
            ven_email AS dven_email,
            ven_Direc AS dven_direccion,
            ven_Loc AS dven_localidad,
            prv_descrip AS dven_provincia,
            ven_CodPos AS dven_codigopostal,
            ven_Activo AS dven_activo
        --AS dven_fechamodificacion
        FROM origen."Vendedor"
        INNER JOIN origen.prv ON prv_codigo = venprv_Cod
    ';

    -- Truncate the table if it exists
    BEGIN
        EXECUTE 'DROP TABLE dwh_vtas.' || v_dwh_table;
    EXCEPTION
        WHEN undefined_table THEN
            -- Do nothing if the table doesn't exist
            NULL;
    END;

    -- Create the table if it doesn't exist by selecting from the query
    EXECUTE 'CREATE TABLE IF NOT EXISTS dwh_vtas.' || v_dwh_table || ' AS ' || v_query || ' WHERE 1=2';

    -- Insert data into the table
    EXECUTE 'INSERT INTO dwh_vtas.'|| v_dwh_table || ' ' || v_query;

END;
$$;



--call dwh_vtas.sp_dim_vendedores()
