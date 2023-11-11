
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

 select 
 cn.Customer_ID,
 cn.customer_name_,
 zone,
 vendor_code,
 vertical,status,
 created_at,
 sum(qty_ordered) as quantity,
 sum(grand_total) as grand_total,
 sum(commission) as commission,
 sum(delivery_fee) as delivery_fee,
 sum(flgpo) as flgpo 
from `DEMOBQ1.Customers` 
left join `DEMOBQ1.Customer_name` cn
on cn.Customer_ID = `DEMOBQ1.Customers`.Customer_ID
group by 1,2,3,4,5,6, 7

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
