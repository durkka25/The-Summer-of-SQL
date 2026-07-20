--Preppin' Data 2023 Week 6

with mobile_survey as (
    select customer_id, "Mobile App", values1
    from pd2023_wk06_dsb_customer_survey
    unpivot(
        values1 for "Mobile App" in (
            "MOBILE_APP___EASE_OF_USE", 
            "MOBILE_APP___EASE_OF_ACCESS", 
            "MOBILE_APP___NAVIGATION", 
            "MOBILE_APP___LIKELIHOOD_TO_RECOMMEND"
        )
    )
),

online_survey as (
    select customer_id, "Online Platform", values2
    from pd2023_wk06_dsb_customer_survey
    unpivot(
        values2 for "Online Platform" in (
            "ONLINE_INTERFACE___EASE_OF_USE", 
            "ONLINE_INTERFACE___EASE_OF_ACCESS", 
            "ONLINE_INTERFACE___NAVIGATION", 
            "ONLINE_INTERFACE___LIKELIHOOD_TO_RECOMMEND"
        )
    )
),

cte as (
    select 
        m.customer_id,
    --    m."Mobile App",
        avg(m.values1) as avg_mobile_values,
    --    o."Online Platform",
        avg(o.values2) as avg_online_values,
        avg_mobile_values-avg_online_values as diff,
    case
        when diff >=2 then 'Mobile App Superfan'
        when diff >=1 then 'Mobile App Fan'
        when diff <=-2 then 'Online Interface Superfan'
        when diff <=-1 then 'Online Interface Fan'
        else 'Neutral'
    end as Preference
    from mobile_survey m
    join online_survey o 
    on m.customer_id = o.customer_id
    -- Splits the string by '___' and matches 'EASE_OF_USE' with 'EASE_OF_USE', etc.
    and split_part(m."Mobile App", '___', 2) = split_part(o."Online Platform", '___', 2)
    group by m.customer_id
)

select Preference
    ,round(100.0 * count(*) / (select count(*) from cte),1) as "% of Total"
from cte
where Preference in ('Mobile App Superfan','Mobile App Fan','Online Interface Fan','Online Interface Superfan','Neutral')
group by Preference