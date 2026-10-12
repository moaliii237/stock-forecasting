--CREATE TABLE s244437_level4_gold AS
--SELECT 
--    date_value,
--    close_value,
--    ROUND(AVG(close_value) OVER (
--        ORDER BY date_value 
--        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
--    )::numeric, 2) AS ma_7_day
--FROM 
--    gold;



--CREATE TABLE s244437_level4_crude_oil AS
--SELECT 
--    date_value,
--    close_value,
--    RANK() OVER (ORDER BY close_value DESC) AS close_price_rank
--FROM 
--    crude_oil;



--CREATE TABLE s244437_level4_rolling_avg AS
--SELECT 
--    company_prefix,
--    date_value,
--    close_value,
--    ROUND(
--        AVG(close_value) OVER (
--            PARTITION BY company_prefix
--            ORDER BY date_value
--            ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
--        )::NUMERIC, 2
--    ) AS rolling_average
--FROM nasdaq_100_daily;