use excel2;
select * from  debit_credit_data;
select count(*) from debit_credit_data;
#1 Total credit Amount
select concat("$",round(sum(amount)/1000000,2),"M") as Total_credit_amount from debit_credit_data where transaction_type = "credit";

#2 Total Debit Amount
select concat("$",round(sum(amount)/1000000,2),"M") as Total_debit_amount from debit_credit_data where transaction_type = "debit";

#3 Credit to Debit Ratio
SELECT 
round(
        SUM(CASE WHEN Transaction_Type = 'Credit' THEN Amount ELSE 0 END) /
        SUM(CASE WHEN Transaction_Type = 'Debit' THEN Amount ELSE 0 END)
   ,3) AS Credit_Debit_Ratio
FROM debit_credit_data;

#4 Net Transaction Amount
select 
concat("$",round(
		(SUM(CASE WHEN Transaction_Type = 'Credit' THEN Amount ELSE 0 END) -
        SUM(CASE WHEN Transaction_Type = 'Debit' THEN Amount ELSE 0 END))/1000000,2),"M")
    AS Net_transaction_amount
FROM debit_credit_data;

#5 Account Activity Ratio
select concat(round((count(customer_id)/sum(balance)*100),2),"%") 
as Account_activity_ratio from debit_credit_data;

#6 Transactions per day/week/month
SELECT 
    DATE(Transaction_Date) AS Day,
    COUNT(*) AS Transactions_Per_Day
FROM debit_credit_data
GROUP BY Day
ORDER BY Day;
-- week
SELECT 
    yearweek(Transaction_Date) AS week,
    COUNT(*) AS Transactions_Per_week
FROM debit_credit_data
GROUP BY week
ORDER BY week;
-- month
SELECT 
    month(Transaction_Date) AS month,
    COUNT(*) AS Transactions_Per_month
FROM debit_credit_data
GROUP BY month
ORDER BY month;

#7 Total Transaction Amount by branch
select branch, concat("$",round(sum(amount)/1000000,2),"M") as Total_transaction_amount 
from debit_credit_data group by branch;













