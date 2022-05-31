
  create view "mymops"."dbt_shantal"."nmt_asset_app_map__singleapp__dbt_tmp" as (
    select asset_id, min(app_id) app_id
from "mymops"."dbt_shantal"."stg_asset_app_map" 
group by asset_id
  );