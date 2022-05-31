select distinct asset_id, app_asset_id as app_id 
from (
     select asset_id::character varying, app_asset_id from "mymops"."dbt_shantal"."nmt_app_map__esx" union
     select asset_id::character varying, app_asset_id from "mymops"."dbt_shantal"."nmt_app_map__onprem_noesx" union
     select asset_id, app_asset_id from "mymops"."dbt_shantal"."nmt_app_map__cloud" )unq