
    
    

with all_values as (

    select
        install_status as value_field,
        count(*) as n_records

    from "mymops"."dbt_shantal"."src_opal__svr"
    group by install_status

)

select *
from all_values
where value_field not in (
    'Installed'
)


