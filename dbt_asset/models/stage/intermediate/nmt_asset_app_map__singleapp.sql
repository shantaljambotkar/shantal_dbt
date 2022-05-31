select asset_id, min(app_id) app_id
from {{ref('stg_asset_app_map')}} 
group by asset_id