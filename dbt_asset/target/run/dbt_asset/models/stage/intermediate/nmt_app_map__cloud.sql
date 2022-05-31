
  create view "mymops"."dbt_shantal"."nmt_app_map__cloud__dbt_tmp" as (
    With AssetMapAWS AS (
	select asset_id, voa.app_id as app_asset_id from (
	select asset_id, unnest(regexp_matches(uai, '[uU][aA][iI]\d+', 'g')) uai
	from "mymops"."dbt_shantal"."src_cm__aws" ssi 
	where uai is not null)inv
	inner join "mymops"."dbt_shantal"."src_opal__app" voa on trim(lower(inv.uai)) = trim(lower(voa.u_unique_app_id))
),
AssetMapAzure AS (
	select asset_id, voa.app_id as app_asset_id from (
	select asset_id, unnest(regexp_matches(uai, '[uU][aA][iI]\d+', 'g')) uai
	from "mymops"."dbt_shantal"."src_cm__azure" ssi 
	where uai is not null)inv
	inner join "mymops"."dbt_shantal"."src_opal__app" voa on trim(lower(inv.uai)) = trim(lower(voa.u_unique_app_id))
),
AssetMapGEIX AS (
	select asset_id, voa.app_id as app_asset_id from (
	select asset_id, unnest(regexp_matches(uai, '[uU][aA][iI]\d+', 'g')) uai
	from "mymops"."dbt_shantal"."src_cm__geix" ssi 
	where uai is not null)inv
	inner join "mymops"."dbt_shantal"."src_opal__app" voa on trim(lower(inv.uai)) = trim(lower(voa.u_unique_app_id))
)
Select asset_id, app_asset_id from AssetMapAWS union
Select asset_id, app_asset_id from AssetMapAzure union 
Select asset_id, app_asset_id from AssetMapGEIX
  );