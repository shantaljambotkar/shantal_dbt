select asset_id, min(app_id) app_id
from "mymops"."dbt_shantal"."stg_asset_app_map" 
group by asset_id