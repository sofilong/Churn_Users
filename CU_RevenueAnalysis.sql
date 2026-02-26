-- Enable Chur_user table
use sofia_data_proyects;

-- Review all data in the Churn_users table
select *
from churn_users;

-- Name month by name
select *,
	case when month = 1 then 'Jan'
		when month = 2 then 'Feb'
		when month = 3 then 'Mar'
		when month = 4 then 'Apr'
		when month = 5 then 'May'
		when month = 6 then 'Jun'
		when month = 7 then 'Jul'
		when month = 8 then 'Aug'
		when month = 9 then 'Sep'
		when month = 10 then 'Oct'
		when Month = 11 then 'Nov'
		else 'Dec' end as Month_year 
from churn_users;

-- Calculate total revenue throught the 12 months
select sum(revenue) as Total_revenue
from churn_users;

-- Calculate the average of the revenue. Rund it to 2 digits
select round(avg(revenue),2) as Monthly_RA
from churn_users;

-- what was the month with least revenue. List by name of month
select *,
	case when month = 1 then 'Jan'
		when month = 2 then 'Feb'
		when month = 3 then 'Mar'
		when month = 4 then 'Apr'
		when month = 5 then 'May'
		when month = 6 then 'Jun'
		when month = 7 then 'Jul'
		when month = 8 then 'Aug'
		when month = 9 then 'Sep'
		when month = 10 then 'Oct'
		when Month = 11 then 'Nov'
		else 'Dec' end as Month_year 
from churn_users
where revenue = 
				(select min(revenue) from churn_users);

-- what was the month with most revenue. List by name of month
select *,
	case when month = 1 then 'Jan'
		when month = 2 then 'Feb'
		when month = 3 then 'Mar'
		when month = 4 then 'Apr'
		when month = 5 then 'May'
		when month = 6 then 'Jun'
		when month = 7 then 'Jul'
		when month = 8 then 'Aug'
		when month = 9 then 'Sep'
		when month = 10 then 'Oct'
		when Month = 11 then 'Nov'
		else 'Dec' end as Month_year 
from churn_users
where revenue = 
				(select max(revenue) from churn_users);
                
-- Compare Revenue with monthly average
select *,
		(select round(avg(revenue),2) from churn_users) as Monthly_avg
from churn_users;

-- Calculate variance between Revenue vs monthly revenue. Use ABS function to convert negative numbers
 select cu.*, rv.Monthly_avg, rv.Var_rv
 from churn_users cu left join
							(select *,
							(select round(avg(revenue),2) from churn_users) as Monthly_avg,
							abs(churn_users - round((select avg(revenue) from churn_users),0)) as Var_rv 
                            from churn_users) as rv
					on cu.month = rv.month;
 
 