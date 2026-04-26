-- dim_date: Generated using dbt_utils.date_spine
-- Covers a sensible range for a real estate analytics project
-- No seed file needed — generated entirely in SQL!

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart = "day",
        start_date = "cast('2001-01-01' as date)",
        end_date   = "cast('2030-12-31' as date)"
    ) }}
),

final as (
    select
        cast(date_day as date)                              as date_id,
        date_day                                            as full_date,

        -- year
        year(date_day)                                      as year,
        -- quarter
        quarter(date_day)                                   as quarter_number,
        concat('Q', quarter(date_day))                      as quarter_name,
        concat(year(date_day), '-Q', quarter(date_day))     as year_quarter,

        -- month
        month(date_day)                                     as month_number,
        monthname(date_day)                                 as month_name,
        left(monthname(date_day), 3)                        as month_short_name,
        concat(year(date_day), '-', lpad(month(date_day), 2, '0')) as year_month,

        -- week
        weekofyear(date_day)                                as week_of_year,
        dayofweek(date_day)                                 as day_of_week,        -- 0=Sunday in Snowflake
        dayname(date_day)                                   as day_name,
        left(dayname(date_day), 3)                          as day_short_name,

        -- day
        day(date_day)                                       as day_of_month,
        dayofyear(date_day)                                 as day_of_year,

        -- flags
        case when dayofweek(date_day) in (0, 6) then true else false end as is_weekend,
        case when dayofweek(date_day) in (0, 6) then false else true end as is_weekday,
        case when date_day = last_day(date_day) then true else false end as is_last_day_of_month,
        case when date_day >= current_date() then true else false end    as is_future

    from date_spine
)

select * from final
order by year desc 
