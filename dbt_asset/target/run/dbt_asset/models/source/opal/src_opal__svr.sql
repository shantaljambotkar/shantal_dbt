
  create view "mymops"."dbt_shantal"."src_opal__svr__dbt_tmp" as (
    SELECT tbl.config_item_id AS asset_id,
    tbl.jsonval ->> 'name'::text AS asset_name,
    tbl.jsonval ->> 'sys_class_name'::text AS sys_class_name,
    lower(tbl.jsonval ->> 'company'::text) AS company,
    lower(tbl.jsonval ->> 'department'::text) AS department,
    tbl.jsonval ->> 'gis_support_class'::text AS gis_support_class,
    tbl.jsonval ->> 'support_group'::text AS support_group,
    tbl.jsonval ->> 'managed_department'::text AS managed_department,
    tbl.jsonval ->> 'owner_name'::text AS owner_name,
    tbl.jsonval ->> 'install_status'::text AS install_status,
    tbl.jsonval ->> 'operational_status'::text AS operational_status,
    tbl.jsonval ->> 'install_date'::text AS install_date,
    tbl.jsonval ->> 'operating_system'::text AS operating_system,
    tbl.jsonval ->> 'location_name'::text AS location_name,
    tbl.jsonval ->> 'model'::text AS model,
    tbl.jsonval ->> 'u_system_origin'::text AS u_system_origin,
    tbl.date_pulled,
    tbl.jsonval ->> 'composite_ip_addr'::text AS ip_address
   FROM ( SELECT opal_svr.config_item_id,
            opal_svr.load_date AS date_pulled,
            opal_svr.data AS jsonval
           FROM "mymops"."ldr"."opal_svr") tbl
  );