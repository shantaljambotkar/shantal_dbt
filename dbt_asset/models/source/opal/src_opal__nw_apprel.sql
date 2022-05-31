SELECT opal_nw.config_item_id,
            opal_nw.data ->> 'company'::text AS company,
            opal_nw.load_date AS date_pulled,
            json_array_elements(opal_nw.data -> 'app_relationships'::text) AS app_relationships
           FROM {{ source('OpAL', 'opal_nw') }}
          WHERE (opal_nw.data -> 'app_relationships'::text) IS NOT NULL