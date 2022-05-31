
    
    

with all_values as (

    select
        sys_class_name as value_field,
        count(*) as n_records

    from "mymops"."dbt_shantal"."src_opal__nw"
    group by sys_class_name

)

select *
from all_values
where value_field not in (
    'cmdb_ci_netgear'
)


