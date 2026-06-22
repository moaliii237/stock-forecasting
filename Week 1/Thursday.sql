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
--__Wednesday
--select avg(volume) from nasdaq_100_index ni group by volume order by volume  ;

--select company_prefix ,max(close_value) from nasdaq_100_daily group by company_prefix  ;

--select nd.company_prefix , nd.close_value
--from nasdaq_100_daily nd 
--where nd.close_value =(
--	select max(sub.close_value)
--	from nasdaq_100_daily sub
--	where sub.company_prefix = nd.company_prefix)

--select date_value ,unemployment_rate as unemployment from macro_economic_indicators mei where unemployment_rate >7 order by date_value desc ;

--select date_value, eurusd / gbpusd as ratio from exchange_rates er order by date_value ;

--select company_prefix, round( 100.0 * count(case when close_value>open_value then 1 end) /count(*),2) as percentage from nasdaq_100_daily nd group by company_prefix order by percentage desc ;

--SELECT 
--  date_value,
--  AVG(close_value) AS acv,
--  CASE 
--    WHEN AVG(close_value) > 500 THEN 'High'
--    WHEN AVG(close_value) >= 200 AND AVG(close_value) <= 500 THEN 'Medium'
--    WHEN AVG(close_value) < 200 THEN 'Low'
--  END AS category
--FROM 
--  nasdaq_100_daily nd
--WHERE 
--  date_value >= '2024-01-01' AND date_value < '2024-02-01'
--GROUP BY 
--  date_value
--ORDER BY 
--  date_value;


--Thursday

--select date_value,company_prefix,avg(volume)
--from nasdaq_100_daily nd 
--		where 
--		company_prefix = 'AMZN' and
--		date_value>='2024-01-01' and date_value <'2025-01-01'
--		group by 1,2;

--
--SELECT 
--  EXTRACT(YEAR FROM date_value) AS year,
--  company_prefix,
--  AVG(volume) AS avg_volume
--FROM 
--  nasdaq_100_daily
--WHERE 
--  date_value >= '2020-01-01' -- or any starting point you need
--GROUP BY 
--  year, company_prefix
--ORDER BY 
--  year, company_prefix;
--
--SELECT
--  date_value,
--  close_price,
--  LAG(close_value) OVER (ORDER BY date_value) AS previous_day_close
--FROM
--  gold_prices
--ORDER BY
--  date_value;
--




	
