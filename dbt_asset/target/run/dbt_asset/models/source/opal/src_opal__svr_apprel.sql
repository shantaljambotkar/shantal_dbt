
  create view "mymops"."dbt_shantal"."src_opal__svr_apprel__dbt_tmp" as (
    SELECT opal_svr.config_item_id,
            opal_svr.data ->> 'company'::text AS company,
            opal_svr.load_date AS date_pulled,
            json_array_elements(opal_svr.data -> 'app_relationships'::text) AS app_relationships
           FROM "mymops"."ldr"."opal_svr" opal_svr
          WHERE (opal_svr.data -> 'app_relationships'::text) IS NOT NULL
  );