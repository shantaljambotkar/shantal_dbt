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
   FROM {{ source('Qualys', 'sherlock_vuln') }} 
  WHERE lower(vuln_status::text) = 'active'::text