SELECT app_id,
    app_name,
    u_unique_app_id AS unique_app_id,
    company,
    department,
        CASE
            WHEN sys_class_name = 'cmdb_ci_service'::text THEN 'Business Service'::text
            WHEN sys_class_name = 'u_cmdb_ci_app_module'::text THEN 'Application Module'::text
            WHEN sys_class_name = 'u_cmdb_ci_business_app'::text THEN 'Business Application'::text
            ELSE NULL::text
        END AS app_type,
    install_status,
    operational_status,
    owner_name,
    support_group,
    u_app_risk_level AS risk_level,
    u_internet_facing AS internet_facing,
    'SNow\OpAL'::text AS app_data_source,
    date_pulled AS app_date_pulled
   FROM "mymops"."dbt_shantal"."src_opal__app"