
  create view "mymops"."dbt_shantal"."src_cm__geix__dbt_tmp" as (
    SELECT q.asset_id,
    q.asset_name,
    'GEIX'::text AS asset_class,
    q.operational_status,
    q.uai,
    q.account,
    'Artemis/cm-geix-instances-summary'::text AS data_source,
    q.date_pulled,
    q.load_date
   FROM ( SELECT tbl.asset_id,
            tbl.jsonval ->> 'name'::text AS asset_name,
            tbl.jsonval ->> 'status'::text AS operational_status,
            tbl.jsonval ->> 'uai'::text AS uai,
            tbl.jsonval ->> 'account_name'::text AS account,
            tbl.jsonval ->> 'upload_date'::text AS date_pulled,
            load_date
           FROM ( SELECT aca.asset_id,
                    aca.data AS jsonval,
                    load_date
                   FROM "mymops"."ldr"."artemis_cm_geix" aca) tbl) q
  );