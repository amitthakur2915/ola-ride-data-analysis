DROP TABLE IF EXISTS bookings_ola;

CREATE TABLE bookings_ola (
    booking_date TIMESTAMP,
    booking_time TIME,
    booking_id TEXT,
    booking_status TEXT,
    customer_id TEXT,
    vehicle_type TEXT,
    pickup_location TEXT,
    drop_location TEXT,
    v_tat NUMERIC,
    c_tat NUMERIC,
    canceled_rides_by_customer TEXT,
    canceled_rides_by_driver TEXT,
    incomplete_rides TEXT,
    incomplete_rides_reason TEXT,
    booking_value NUMERIC,
    payment_method TEXT,
    ride_distance NUMERIC,
    driver_ratings NUMERIC,
    customer_rating NUMERIC
);


SELECT * FROM bookings_ola LIMIT 5;

# 1
create view Successful_bookings As
select * from bookings_ola
where booking_status = 'Success';

select * from Successful_bookings
# 2 
create view ride_distance_for_each_vehicle As
select Vehicle_Type, Round (AVG(Ride_Distance),2)
as avg_distance From bookings_ola
Group By Vehicle_Type;

select * from ride_distance_for_each_vehicle;

# 3
create view canceled_rides_by_customers As
select count(*) from bookings_ola
where booking_status = 'Canceled by Customer';

select * from canceled_rides_by_customers;

#4
create view top5_customer as
select Customer_ID , COUNT(Booking_ID) as total_rides
FROM bookings_ola
GROUP BY Customer_ID
order by total_rides DESC LIMIT 5;

select * from top5_customer

#5
create view rides_canceled_by_drivers as
select count(*) from bookings_ola
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

select * from rides_canceled_by_drivers;

#6
create view max_and_min_rating as
select max(Driver_Ratings) as max_rating,
min(Driver_Ratings) as min_rating
From bookings_ola
where vehicle_type = 'Prime Sedan';

select * from max_and_min_rating;

#7
create view upi as
select * from bookings_ola
Where Payment_Method = 'UPI';

select * from upi;

#8
create view Avg_Cust_Rating as
select vehicle_type, round( Avg(customer_rating),2) as avg_customer_rating
from bookings_ola
group by vehicle_type;

select * from Avg_Cust_Rating;

#9
create view Booking_Value as
select sum(booking_value) as total_value 
from bookings_ola
where booking_status = 'Success';

select * from Booking_Value;

#10
create view incomplete_rides as
select Booking_ID , Incomplete_Rides_Reason
From bookings_ola
Where Incomplete_Rides = 'Yes';

select * from incomplete_rides;