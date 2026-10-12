--level 1

--select date_value, eurusd/gbpusd as exchange_rate 
--	from exchange_rates er 	
--	where 
--	date_value >='2020-01-01' and date_value <'2021-01-01';


--select distinct stock_index from stock_indices si ;
--#distinct here help to just show the unique indices here 

--select close_value , open_value, date_value , close_value - open_value as diff from gold g where close_value > open_value group by 1,2,3,4 order by diff desc  ;

--select date_value ,close_value - open_value as diff from crude_oil co group by 1,2 order by date_value desc ;

