SELECT tbl.config_item_id AS app_id,
    tbl.jsonval ->> 'name'::text AS app_name,
    tbl.jsonval ->> 'sys_class_name'::text AS sys_class_name,
    lower(tbl.jsonval ->> 'company'::text) AS company,
    lower(tbl.jsonval ->> 'department'::text) AS department,
    tbl.jsonval ->> 'support_group'::text AS support_group,
    tbl.jsonval ->> 'managed_department'::text AS managed_department,
    tbl.jsonval ->> 'owner_name'::text AS owner_name,
    tbl.jsonval ->> 'install_status'::text AS install_status,
    tbl.jsonval ->> 'operational_status'::text AS operational_status,
    tbl.jsonval ->> 'install_date'::text AS install_date,
    tbl.jsonval ->> 'u_unique_app_id'::text AS u_unique_app_id,
    tbl.jsonval ->> 'u_app_risk_level'::text AS u_app_risk_level,
    tbl.jsonval ->> 'u_internet_facing'::text AS u_internet_facing,
    tbl.jsonval ->> 'u_system_origin'::text AS u_system_origin,
    tbl.date_pulled
   FROM ( SELECT opal_app.config_item_id AS config_item_id,
            opal_app.load_date AS date_pulled,
            opal_app.data AS jsonval
           FROM {{ source('OpAL', 'opal_app') }}
          WHERE opal_app.config_item_id::text ~ '^\d+(\.\d+)?$'::text) tbl