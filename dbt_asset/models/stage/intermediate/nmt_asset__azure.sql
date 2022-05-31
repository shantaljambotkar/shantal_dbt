SELECT q.asset_id,
    q.asset_name,
    'AWS'::text AS asset_class,
    q.operational_status,
    voa.company,
    voa.department,
    voa.owner_name,
    q.uai,
    q.account,
    q.data_source,
    q.date_pulled,
    q.load_date
from {{ref('src_cm__azure')}} q
inner join {{ref('nmt_asset_app_map__singleapp')}} appmap on q.asset_id = appmap.asset_id
inner JOIN {{ref('stg_app')}} voa ON appmap.app_id = voa.app_id
