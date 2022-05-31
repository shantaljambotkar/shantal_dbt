SELECT q.asset_id,
    q.asset_name,
    'AWS'::text AS asset_class,
    q.operational_status,
    q.uai,
    q.account,
    'Artemis/cm-cloud-summary'::text AS data_source,
    q.date_pulled,
    q.load_date
   FROM ( SELECT tbl.asset_id,
            tbl.jsonval ->> 'name'::text AS asset_name,
            tbl.jsonval ->> 'instancestate'::text AS operational_status,
            tbl.jsonval ->> 'c_uai'::text AS uai,
            tbl.jsonval ->> 'accountid'::text AS account,
            tbl.jsonval ->> 'upload_date'::text AS date_pulled,
            load_date
           FROM ( SELECT aca.asset_id,
                    aca.data AS jsonval,
                    aca.load_date
                   FROM "mymops"."ldr"."artemis_cm_aws" aca) tbl) q