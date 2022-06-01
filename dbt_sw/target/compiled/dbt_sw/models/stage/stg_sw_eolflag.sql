with __dbt__cte__src_qualys__sw_eol as (
SELECT data_refresh_timestamp,
    owning_business,
    sub_business,
    asset_id,
    asset_class,
    qid::integer AS qid,
    title,
    vuln_status,
    uai,
    first_app_name,
    results
   FROM "mymops"."ldr"."sherlock_vuln" 
  WHERE lower(vuln_status::text) = 'active'::text
)select * from __dbt__cte__src_qualys__sw_eol