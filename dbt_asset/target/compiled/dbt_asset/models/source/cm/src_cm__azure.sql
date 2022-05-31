SELECT q.asset_id,
    q.asset_name,
    'AZURE'::text AS asset_class,
    q.operational_status,
    q.uai,
    q.account,
    'Artemis/cm-cloud-summary-azure'::text AS data_source,
    q.date_pulled,
    q.load_date
   FROM ( SELECT tbl.asset_id,
            tbl.jsonval ->> 'displayname'::text AS asset_name,
            tbl.jsonval ->> 'vm_state'::text AS operational_status,
            tbl.jsonval ->> 'uai'::text AS uai,
            tbl.jsonval ->> 'subscriptionid'::text AS account,
            tbl.jsonval ->> 'upload_date'::text AS date_pulled,
            load_date
           FROM ( SELECT aca.asset_id,
                    aca.data AS jsonval,
                    aca.load_date
                   FROM "mymops"."ldr"."artemis_cm_azure" aca) tbl) q