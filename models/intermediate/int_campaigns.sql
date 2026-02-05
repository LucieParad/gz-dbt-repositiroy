select *
from {{ ref('stg_gz_raw_data__adwords') }}
union all 
select *
from {{ ref('stg_gz_raw_data__bing') }}
union all
select *
from {{ ref('stg_gz_raw_data__criteo') }}
union all
select *
from {{ ref('stg_gz_raw_data__facebook') }}