With AssetMapESX AS (
SELECT asset_id, app_asset_id from (
SELECT tbl.config_item_id AS asset_id,
    tbl.jsonval ->> 'u_config_item_id'::text AS app_asset_id
   FROM ( SELECT opal_svr.config_item_id,
            opal_svr.data ->> 'company'::text AS company,
            opal_svr.load_date AS date_pulled,
            json_array_elements(opal_svr.data -> 'app_relationships'::text) AS jsonval
           FROM {{ source('OpAL', 'opal_svr') }}
          WHERE (opal_svr.data -> 'app_relationships'::text) IS NOT NULL) tbl
     JOIN {{ref('src_opal__app')}} app ON (tbl.jsonval ->> 'u_config_item_id'::text) = app.app_id AND tbl.company ~~* app.company
  WHERE NOT (tbl.config_item_id IN ( SELECT vw_opal_svr.asset_id
           FROM {{ ref('src_opal__svr')}} vw_opal_svr
          WHERE (vw_opal_svr.support_group = ANY (ARRAY['@Digital Alstom DXC SWE EC'::text, '@Digital Alstom DXC Windows Regular'::text, '@GE CTCR Hosting L2 Virtual Non EC'::text, '@GE CTCR Hosting L2 Virtual US EC'::text])) AND vw_opal_svr.operating_system ~~* '%esx%'::text)))a
),
AssetMapESXCT AS (
SELECT asset_id, app_asset_id from (
SELECT tbl.config_item_id AS asset_id,
    tbl.jsonval ->> 'u_config_item_id'::text AS app_asset_id
   FROM ( SELECT opal_svr.config_item_id,
            opal_svr.data ->> 'company'::text AS company,
            opal_svr.load_date AS date_pulled,
            json_array_elements(opal_svr.data -> 'app_relationships'::text) AS jsonval
           FROM {{ source('OpAL', 'opal_svr') }}
          WHERE (opal_svr.data -> 'app_relationships'::text) IS NOT NULL AND ((opal_svr.data ->> 'support_group'::text) = ANY (ARRAY['@Digital Alstom DXC SWE EC'::text, '@Digital Alstom DXC Windows Regular'::text])) AND (opal_svr.data ->> 'operating_system'::text) ~~* '%esx%'::text) tbl
     JOIN {{ref('src_opal__app')}} app ON (tbl.jsonval ->> 'u_config_item_id'::text) = app.app_id AND tbl.company ~~* app.company AND app.u_unique_app_id = 'UAI3007474'::text)a
),
AssetMapESXDXC AS (
SELECT asset_id, app_asset_id from (
	SELECT tbl.config_item_id AS asset_id,
    tbl.jsonval ->> 'u_config_item_id'::text AS app_asset_id
   FROM ( SELECT opal_svr.config_item_id,
            opal_svr.data ->> 'company'::text AS company,
            opal_svr.load_date AS date_pulled,
            json_array_elements(opal_svr.data -> 'app_relationships'::text) AS jsonval
           FROM {{ source('OpAL', 'opal_svr') }}
          WHERE (opal_svr.data -> 'app_relationships'::text) IS NOT NULL AND ((opal_svr.data ->> 'support_group'::text) = ANY (ARRAY['@GE CTCR Hosting L2 Virtual Non EC'::text, '@GE CTCR Hosting L2 Virtual US EC'::text])) AND (opal_svr.data ->> 'operating_system'::text) ~~* '%esx%'::text) tbl
     JOIN {{ref('src_opal__app')}} app ON (tbl.jsonval ->> 'u_config_item_id'::text) = app.app_id AND tbl.company ~~* app.company AND app.u_unique_app_id = 'UAI3006374'::text)a
)
Select asset_id, app_asset_id From AssetMapESX union
Select asset_id, app_asset_id From AssetMapESXCT union
Select asset_id, app_asset_id From AssetMapESXDXC