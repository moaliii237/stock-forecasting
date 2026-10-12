--SELECT 
--    s.date_value,
--    s.stock_index,
--    s.open_value,
--    s.close_value,
--    m.unemployment_rate
--FROM stock_indices s
--JOIN macro_economic_indicators m
--    ON s.date_value = m.date_value
--ORDER BY s.date_value;
--





--SELECT 
--    date_value,
--    company_prefix,
--    close_value AS close_today,
--    LAG(close_value, 1) OVER (PARTITION BY company_prefix ORDER BY date_value) AS close_yesterday,
--    (close_value - LAG(close_value, 1) OVER (PARTITION BY company_prefix ORDER BY date_value)) AS price_change
--FROM 
--    nasdaq_100_daily
--ORDER BY 
--    company_prefix, date_value;
--




--SELECT 
--    date_value,
--    open_value,
--    EXTRACT(YEAR FROM date_value) AS year,
--    CASE 
--        WHEN open_value > 90 THEN 'High'
--        WHEN open_value BETWEEN 60 AND 90 THEN 'Medium'
--        ELSE 'Low'
--    END AS price_category
--FROM 
--    crude_oil
--WHERE 
--    EXTRACT(YEAR FROM date_value) IN (2021, 2022)
--ORDER BY 
--    date_value;



--SELECT 
--    date_value,
--    company_prefix,
--    open_value,
--    close_value,
--    CASE
--        WHEN close_value > open_value THEN 'up'
--        WHEN close_value < open_value THEN 'down'
--        ELSE 'no change'
--    END AS movement
--FROM 
--    nasdaq_100_daily
--WHERE 
--    company_prefix = 'AAPL' 
--    AND EXTRACT(YEAR FROM date_value) = 2022
--ORDER BY 
--    date_value;
