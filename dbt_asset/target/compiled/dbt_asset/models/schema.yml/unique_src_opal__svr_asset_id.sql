
    
    

select
    asset_id as unique_field,
    count(*) as n_records

from "mymops"."dbt_shantal"."src_opal__svr"
where asset_id is not null
group by asset_id
having count(*) > 1


