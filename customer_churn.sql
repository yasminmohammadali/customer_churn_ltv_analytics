create database telco_churn;
use telco_churn;

create table customers (
customerID varchar(50),
gender varchar(10),
SeniorCitizen int,
Partner varchar(10),
Dependents varchar(10),
tenure int,
PhoneService varchar(10),
MultipleLines varchar(20),
InternetServices varchar (20),
OnlineSecurity varchar(20),
OnlineBackup varchar(20),
DeviceProtection varchar(20),
TechSupport varchar(20),
StreamingTV varchar(20),
StreamingMovies varchar(20),
Contract varchar(30),
PaperlessBilling varchar(10),
PaymentMethod varchar(50),
MonthlyCharges decimal(10,2),
TotalCharges varchar(20),
Churn varchar(10));

SET SQL_SAFE_UPDATES = 0;

update customers set TotalCharges=NULL
where TotalCharges='';

SELECT TotalCharges
FROM customers
WHERE TotalCharges REGEXP '[^0-9.]' OR TotalCharges IS NULL;

update customers
set TotalCharges=NULL
where trim(TotalCharges)='';

alter table customers
modify TotalCharges decimal(10,2);

select * from customers;

select Churn, count(*) as count,
round(count(*)*100.0 / (select count(*) from customers),2) as Churn_Percent
from customers group by Churn;

select Contract, Churn, count(*) as total
from customers group by Contract, Churn;

select Churn, avg(MonthlyCharges) as Avg_charge
from customers group by Churn;

select Churn, avg(tenure) as Avg_tenure
from customers group by Churn;

create view high_risk_customers as
select * from customers
where Contract='Month-to-month' and Churn='Yes';

create view high_value_customers as
select *, (MonthlyCharges * tenure) as LTV
from customers order by LTV DESC;

select * from high_value_customers;
