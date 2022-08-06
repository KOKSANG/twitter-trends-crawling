with ada_tweets as (

    select 
        * except(entity)
    from 
        {{ source("fct", "tweets") }}
    where 
        ( contains_substr(content, "ada") or contains_substr(content, "cardano") )
        and entity not in ("ada", "cardano")

)

, base as (

    select * except(entity) from {{ source("fct", "tweets") }}
    where entity in ("ada", "cardano")

)

select * from ada_tweets
union all
select * from base