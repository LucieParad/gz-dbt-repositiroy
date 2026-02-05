with 

source as (

    select * from {{ source('gz_raw_data', 'adwords') }}

),

renamed as (

    select
        date_date,
        paid_source,
        campaign_key,
        campgn_name AS campaign_name,
        CAST(ads_cost as FLOAT64),
        impression,
        click

    from source

)

select * from renamed