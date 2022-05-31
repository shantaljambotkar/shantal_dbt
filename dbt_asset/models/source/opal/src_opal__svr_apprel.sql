SELECT opal_svr.config_item_id,
            opal_svr.data ->> 'company'::text AS company,
            opal_svr.load_date AS date_pulled,
            json_array_elements(opal_svr.data -> 'app_relationships'::text) AS app_relationships
           FROM {{ source('OpAL', 'opal_svr') }} opal_svr
          WHERE (opal_svr.data -> 'app_relationships'::text) IS NOT NULL