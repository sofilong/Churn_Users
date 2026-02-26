use sofia_data_proyects;

-- Review your churn_users data
select *
from churn_users;

-- Set the  Months on the table
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


-- Subquery from the SELECT CLAUSE to average of Churn user to compare with monthly churn user 
select *, 
	round((select avg(churn_users) from churn_users),0) as Avg_CU,
	abs(churn_users - round((select avg(churn_users) from churn_users),0)) as Var_cu
from churn_users;

-- Subquery from the FROM clause to average of Churn user to compare with monthly churn user 
select cu.*, cut.Avg_cu
from churn_users cu left join
	(select *, 
		round((select avg(churn_users) from churn_users),0) as Avg_cu
			from churn_users) as cut
    on cu.month = cut.month;

-- Subquery from the FROM clause to calculate the variance between churn users and average of churn users
select cu.*, cut.Avg_cu, cut.Var_cu
from churn_users cu left join
	(select *, 
	round((select avg(churn_users) from churn_users),0) as Avg_cu,
    abs(churn_users - round((select avg(churn_users) from churn_users),0)) as Var_cu
			from churn_users) as cut
    on cu.month = cut.month;
    
-- Count how many churn users are higher than monthly average of Churn users. use CTE for query execution
with churn_review as (select  cu.*, cut.Avg_cu, abs(cu.churn_users - round(cut.Avg_cu,0)) as Var_cu
					from churn_users cu cross join
						(select *,
						(select round(avg(churn_users),0) from churn_users) as Avg_cu
                        from churn_users) as cut
						on cu.month = cut.month
						where cu.Churn_Users >= cut.Avg_cu)
select count(*)
from churn_review;

-- Calculate Churn users that are higher than monthly average of churn users    
select cu.*, cut.Avg_cu, abs(cu.churn_users - round(cut.churn_users)) as Var_cu
from churn_users cu left join
	(select *, 
	(select round(avg(churn_users),0) from churn_users) as Avg_cu
			from churn_users) as cut
	on cu.month = cut.month
where cu.Churn_Users >= cut.Avg_cu;
 
-- Calculate the month with most Churn_users. List by month
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
where Churn_Users = 
					(select min(churn_users) from churn_users);

-- Calculate the month with the least Churn users. List by month 
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
where Churn_Users = 
					(select max(churn_users) from churn_users);