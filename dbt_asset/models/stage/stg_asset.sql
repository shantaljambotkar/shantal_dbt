SELECT asset_id::character varying AS asset_id,
    asset_name,
    'Server'::text AS asset_class,
    company,
    department,
    owner_name,
    support_group,
    operational_status,
    NULL::text AS network_zone,
    'OpAL\\'::text || u_system_origin AS asset_datasource,
    date_pulled AS asset_date_pulled
   FROM {{ref('src_opal__svr')}}
UNION
 SELECT asset_id::character varying AS asset_id,
    asset_name,
    'Network Device'::text AS asset_class,
    company,
    department,
    owner_name,
    support_group,
    operational_status,
    u_network_zone AS network_zone,
    'OpAL\\'::text || u_system_origin AS asset_datasource,
    date_pulled AS asset_date_pulled
   FROM {{ref('src_opal__nw')}}
UNION
 SELECT asset_id,
    asset_name,
    asset_class,
    company,
    department,
    owner_name,
    NULL::text AS support_group,
    operational_status,
    NULL::text AS network_zone,
    data_source AS asset_datasource,
    date_pulled::date AS asset_date_pulled
   FROM {{ref('nmt_asset__aws')}}
UNION
 SELECT asset_id,
    asset_name,
    asset_class,
    company,
    department,
    owner_name,
    NULL::text AS support_group,
    operational_status,
    NULL::text AS network_zone,
    data_source AS asset_datasource,
    date_pulled::date AS asset_date_pulled
   FROM {{ref('nmt_asset__azure')}}
UNION
 SELECT asset_id,
    asset_name,
    asset_class,
    company,
    department,
    owner_name,
    NULL::text AS support_group,
    operational_status,
    NULL::text AS network_zone,
    data_source AS asset_datasource,
    date_pulled::date AS asset_date_pulled
   FROM {{ref('nmt_asset__geix')}}