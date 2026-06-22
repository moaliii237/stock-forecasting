--select close_value as closing_price from crude_oil where close_value>70;

--select MAX(high_value) ,MIN(low_value) from nasdaq_100_daily;

--select company_prefix as entries,count(*) from nasdaq_100_minute group by company_prefix order by company_prefix desc ;

--select company_prefix ,date_value, volume from nasdaq_100_daily group by company_prefix , volume, date_value order by volume desc limit 1 ;

--select company_prefix ,date_value, volume from nasdaq_100_daily group by company_prefix ,volume, date_value order by volume desc limit 10 ;

--SELECT company_prefix, date_value, volume FROM ( SELECT company_prefix, date_value, volume,
--           ROW_NUMBER() OVER (PARTITION BY company_prefix ORDER BY volume DESC) AS rn
--    FROM nasdaq_100_daily
--) sub
--WHERE rn = 1
--ORDER BY volume DESC
--LIMIT 10;

