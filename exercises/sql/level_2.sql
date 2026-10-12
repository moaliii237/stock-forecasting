--create table cpi_data(
--	date_value date,
--	inflation_cpi numeric
--	);
--	
--with yearly_cpi as (
--	select
--		extract (year from date_value) as year,
--		AVG(inflation_cpi) as avg_cpi
--	from 
--		macro_economic_indicators
--	where 
--		inflation_cpi IS NOT NULL
--    GROUP BY
--        EXTRACT(YEAR FROM date_value)
--),
--inflation_rates AS (
--    SELECT
--        year,
--        avg_cpi,
--        LAG(avg_cpi) OVER (ORDER BY year) AS prev_cpi
--    FROM
--        yearly_cpi
--)
--SELECT
--    AVG((avg_cpi - prev_cpi) / prev_cpi * 100) AS average_inflation_rate
--FROM
--    inflation_rates
--WHERE
--    prev_cpi IS NOT NULL;








--select count(*) as above_1800  from gold g where close_value >1800 ;

--####--WITH avg_range AS (
--    SELECT AVG(high_value - low_value) AS avg_daily_range
--    FROM nasdaq_100_daily
--)
--SELECT 
--    nd.date_value,
--    nd.high_value,
--    nd.low_value,
--    (nd.high_value - nd.low_value) AS daily_range,
--    (nd.high_value - nd.low_value) - ar.avg_daily_range AS difference_from_avg
--FROM 
--    nasdaq_100_daily nd
--JOIN 
--    avg_range ar ON TRUE
--WHERE 
--    (nd.high_value - nd.low_value) > ar.avg_daily_range
--ORDER BY 
--    difference_from_avg DESC;


--SELECT distinct volume ,stock_index, date_value
--FROM stock_indices
--ORDER BY volume DESC
--LIMIT 5;
