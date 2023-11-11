{{ config(materialized="table") }}

with
    source_data as (
        select
            cn.customer_id,
            cn.customer_name_,
            zone,
            vendor_code,
            vertical,
            status,
            created_at,
            sum(qty_ordered) as quantity,
            sum(grand_total) as grand_total,
            sum(commission) as commission,
            sum(delivery_fee) as delivery_fee,
            sum(flgpo) as flgpo
        from `DEMOBQ1.Customers`
        left join
            `DEMOBQ1.Customer_name` cn
            on cn.customer_id = `DEMOBQ1.Customers`.customer_id
        group by 1, 2, 3, 4, 5, 6, 7

    )

select *
from source_data
