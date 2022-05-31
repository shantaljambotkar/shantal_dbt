SELECT asset_id, app_asset_id from (
	SELECT tbl.config_item_id AS asset_id,
    tbl.app_relationships ->> 'u_config_item_id'::text AS app_asset_id
   FROM "mymops"."dbt_shantal"."src_opal__nw_apprel" tbl
     JOIN "mymops"."dbt_shantal"."src_opal__app" app ON (tbl.app_relationships ->> 'u_config_item_id'::text) = app.app_id AND tbl.company ~~* app.company)a
union
SELECT asset_id, app_asset_id from (
	SELECT tbl.config_item_id AS asset_id,
    tbl.app_relationships ->> 'u_config_item_id'::text AS app_asset_id
   FROM "mymops"."dbt_shantal"."src_opal__svr_apprel" tbl
     JOIN "mymops"."dbt_shantal"."src_opal__app" app ON (tbl.app_relationships ->> 'u_config_item_id'::text) = app.app_id AND tbl.company ~~* app.company)a