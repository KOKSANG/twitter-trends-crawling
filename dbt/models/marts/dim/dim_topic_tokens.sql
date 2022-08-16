with tweets as (

    select

        id
        , url
        , topic

    from 
        ref("tweet_topics")
        , unnest(topics) topic
    where 
        topics is not null
    
)

, tweet_tokens as (

    select * from {{ ref("dim_token_interests") }}

)

, final as (

    select

        a.id
        , a.url
        , a.created_timestamp
        , a.topic
        , b.token

    from
        tweets a
    left join
        tweet_tokens b
    on
        a.id = b.id
        and a.url = b.url

)

select * from final
where
    created_timestamp >= "2022-05-01"