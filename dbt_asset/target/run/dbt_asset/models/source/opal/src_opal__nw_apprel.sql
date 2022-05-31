
  create view "mymops"."dbt_shantal"."src_opal__nw_apprel__dbt_tmp" as (
    SELECT opal_nw.config_item_id,
            opal_nw.data ->> 'company'::text AS company,
            opal_nw.load_date AS date_pulled,
            json_array_elements(opal_nw.data -> 'app_relationships'::text) AS app_relationships
           FROM "mymops"."ldr"."opal_nw"
          WHERE (opal_nw.data -> 'app_relationships'::text) IS NOT NULL
  );