-- trip less than 1 mile in November 2025
select 
	count(1) 
from 
	green_trips_data_2025_11 
where 
	trip_distance <= 1 
	and lpep_pickup_datetime >= '2025-11-01'
	and lpep_dropoff_datetime < '2025-12-01';


-- longest trip day by distance but less than 100 miles
select
	date(lpep_pickup_datetime) as pickup_date
	,max(trip_distance) as max_distance
from
	green_trips_data_2025_11
where
	trip_distance < 100
group by
	lpep_pickup_datetime
order by
	max_distance desc
limit 
	1;


-- Which was the pickup zone with the largest total_amount (sum of all trips) 
-- on November 18th, 2025?
select 
	puz."Zone"
	,sum(trp.total_amount) as total_fare
from
	green_trips_data_2025_11 trp
	join zones puz
		on trp."PULocationID" = puz."LocationID"
where
	date(trp.lpep_pickup_datetime) = '2025-11-18'
group by
	puz."Zone"
order by
	total_fare desc
limit 1;


-- For the passengers picked up in the zone named "East Harlem North" in November 2025, 
-- which was the drop off zone that had the largest tip?
select 
	doz."Zone"
	--,sum(trp.tip_amount) as tips
from
	green_trips_data_2025_11 trp
	join zones puz
		on trp."PULocationID" = puz."LocationID"
	join zones doz
		on trp."DOLocationID" = doz."LocationID"
where
	puz."Zone" = 'East Harlem North'
	and date(trp.lpep_pickup_datetime) between '2025-11-01' and '2025-11-30'
--group by
--	1
order by
	trp.tip_amount desc
limit 
	1;