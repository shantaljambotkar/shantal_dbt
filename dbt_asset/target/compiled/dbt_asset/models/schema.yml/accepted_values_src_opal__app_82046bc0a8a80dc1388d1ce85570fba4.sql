
    
    

with all_values as (

    select
        sys_class_name as value_field,
        count(*) as n_records

    from "mymops"."dbt_shantal"."src_opal__app"
    group by sys_class_name

)

select *
from all_values
where value_field not in (
    'u_cmdb_ci_business_app','u_cmdb_ci_app_module','cmdb_ci_service'
)


