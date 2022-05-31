
    
    

with all_values as (

    select
        operational_status as value_field,
        count(*) as n_records

    from "mymops"."dbt_shantal"."src_opal__app"
    group by operational_status

)

select *
from all_values
where value_field not in (
    'Operational','Non-Operational','Pending decomm'
)


