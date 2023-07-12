CREATE TABLE public.fraudes(
Monthh text,	
WeekOfMonth int,
DayOfWeek	text,
Make	text,
AccidentArea    text,	
DayOfWeekClaimed	text,
MonthClaimed	text,
WeekOfMonthClaimed  int,
Sex text,
MaritalStatus   text,	
Age	int,
Fault	text,
PolicyType	text,
VehicleCategory	text,
VehiclePrice	text,
FraudFound_P	int,
PolicyNumber	int,
RepNumber	int,
Deductible	int,
DriverRating	int,
Days_Policy_Accident	text,
Days_Policy_Claim	text,
PastNumberOfClaims	text,
AgeOfVehicle	text,
AgeOfPolicyHolder	text,
PoliceReportFiled	text,
WitnessPresent	text,
AgentType	text,
NumberOfSuppliments	   text,
AddressChange_Claim text,
NumberOfCars	text,
Yearr   int,
BasePolicy  text
);

COPY public.fraudes FROM 'C:\fraud.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE percentage_fraud_month_week_day as (SELECT 
					Monthh,
					WeekOfMonth, 
					DayOfWeek, 
					ROUND(SUM(FraudFound_P) * 100.0/ COUNT(FraudFound_P),2) AS percentage_fraud_month_week_day
				FROM fraudes
				GROUP BY  Monthh, WeekOfMonth, DayOfWeek);

CREATE TABLE percentage_fraud_month_week as (SELECT 
					Monthh,
					WeekOfMonth,
					ROUND(SUM(FraudFound_P)  * 100.0/ COUNT(FraudFound_P),2) AS percentage_fraud_month_week
				FROM fraudes
				GROUP BY  Monthh, WeekOfMonth);

CREATE TABLE percentage_fraud_month as (SELECT 
					Monthh,
					ROUND(SUM(FraudFound_P)  * 100.0/ COUNT(FraudFound_P),2) AS percentage_fraud_month
				FROM fraudes
				GROUP BY  Monthh);
				
SELECT 
per_day.Monthh,
per_day.WeekOfMonth,
per_day.DayOfWeek,
per_mon.percentage_fraud_month,
per_week.percentage_fraud_month_week,
per_day.percentage_fraud_month_week_day
FROM percentage_fraud_month_week_day per_day
LEFT JOIN percentage_fraud_month_week per_week
ON per_week.Monthh = per_day.Monthh AND per_week.WeekOfMonth=per_day.WeekOfMonth
LEFT JOIN percentage_fraud_month per_mon
ON per_day.Monthh = per_mon.Monthh
ORDER BY  per_day.Monthh, per_day.WeekOfMonth;
				
SELECT * FROM percentage_fraud_month_week_day