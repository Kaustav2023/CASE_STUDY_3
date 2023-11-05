Select * from Customers
Select * from Continent
Select * from Transactions

1. Display the count of customers in each region who have done the
transaction in the year 2020.

Select Region_Name, Count(*) AS [No. Of Customers] from Customers AS C 
left join Continent AS Conti 
on C.Region_id=Conti.Region_id
Where Customer_ID IN (select Customer_ID from transactions where year(txn_date)=2020)
group by Region_Name

2. Display the maximum and minimum transaction amount of each
transaction type.

Select Max(txn_amount)AS[ Maximum Transaction] , Min(txn_amount) AS [Minimum Transaction],txn_type AS [Transaction Type]
from transactions 
group by txn_type

Select * from transactions where txn_amount=1

3. Display the customer id, region name and transaction amount where
transaction type is deposit and transaction amount > 2000.

Select Cust.Customer_ID , Region_Name, Txn_Amount[Transaction Amount] from Customers AS Cust
left join Continent AS C 
on Cust.Region_ID=C.Region_ID
left join Transactions AS T
on Cust.Customer_ID=T.Customer_ID
where T.txn_amount>2000 AND T.Txn_type='Deposit'


4. Find duplicate records in the Customer table.

Select CUSTOMER_ID,REGION_ID,START_DATE,END_DATE 
From CUSTOMERS
group by CUSTOMER_ID,REGION_ID,START_DATE,END_DATE
having count(*)>1

5. Display the customer id, region name, transaction type and transaction
amount for the minimum transaction amount in deposit.


Select Top 1 T.Customer_ID , 
T.txn_type AS [Transaction Type],Min(T.Txn_Amount) AS [Minimum Amount] 
from Customers AS Cust left join Transactions AS T
on Cust.Customer_ID=T.Customer_ID 
Left join Continent AS C 
on Cust.Region_ID=C.Region_ID
where Cust.Customer_ID IN (Select Top 1 Customer_ID from Transactions Where txn_type='Deposit' order by Txn_Amount)
group by T.Customer_ID,T.Txn_type,T.Txn_Amount


6. Create a stored procedure to display details of customers in the
Transaction table where the transaction date is greater than Jun 2020.

Create Procedure display_details as
Select * from transactions where format(txn_date,'MM-yyyy')>'06-2020'

exec display_details

 
7. Create a stored procedure to insert a record in the Continent table.

Select * from Continent

Create Procedure Insert_Records
@RG_ID int,@Region varchar(20)
as
Begin Transaction
insert into Continent (region_id,region_name)
values (@RG_ID,@Region)
Commit


Exec Insert_Records @RG_ID=6 ,@Region='Russia'

Select * from Continent

8. Create a stored procedure to display the details of transactions that
happened on a specific day.

Create Procedure Display_Transaction
     @Specific_Day date
AS
Select * from Transactions 
Where txn_date=@Specific_Day

Exec Display_Transaction @Specific_Day='01-02-2020'

9. Create a user defined function to add 10% of the transaction amount in a
table.CREATE FUNCTION Add10PercentToAmount (@TransactionAmount DECIMAL(18, 2))
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @Result DECIMAL(18, 2);
    SET @Result = @TransactionAmount + (@TransactionAmount * 0.10);
    RETURN @Result;
END;


SELECT Customer_ID,TXN_DATE,TXN_TYPE, dbo.Add10PercentToAmount(txn_amount) AS NewAmount
FROM Transactions;


10. Create a user defined function to find the total transaction amount for a
given transaction type.

Create function Total_Transactions(@Txn_Type varchar(30))
Returns Table
AS 
Return(
   Select SUM(Txn_Amount)AS [TOTAL TRANSACTION AMOUNT] from Transactions where txn_type=@Txn_Type )

  Select * from dbo.Total_Transactions('Deposit')


11. Create a table value function which comprises the columns customer_id,
region_id ,txn_date , txn_type , txn_amount which will retrieve data from
the above table.

Create Function retrieve_data(@type varchar(30))
Returns Table
AS 
Return ( Select T.customer_id,region_id,txn_date,txn_type,txn_amount from Transactions as T 
         left join Customers as C on T.Customer_ID=C.Customer_ID 
		 where txn_type=@type)

Select * from Retrieve_data('Deposit')

12. Create a TRY...CATCH block to print a region id and region name in a
single column.

BEGIN TRY
    -- Your SQL code that might raise an exception goes here
    -- In this example, we assume you are querying the Regions table
    SELECT CAST(Region_ID AS NVARCHAR(10)) + ' - ' + Region_Name AS CombinedColumn
    FROM Continent
END TRY
BEGIN CATCH
    -- Print an error message or handle the exception as needed
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH


13. Create a TRY...CATCH block to insert a value in the Continent table.

BEGIN TRY 
    Insert INTO Continent
	Values(7,'Antarctica')
END TRY
BEGIN CATCH
    PRINT 'THERE IS AN ERROR' + Error_Message()
END CATCH 

Select * from Continent


14. Create a trigger to prevent deleting a table in a database.

Create trigger Deleting_Table
on Case_study_3
AS 

USE YourDatabaseName; -- Replace 'YourDatabaseName' with the actual database name



15. Create a trigger to audit the data in a table.



16. Create a trigger to prevent login of the same user id in multiple pages.



17. Display top n customers on the basis of transaction type.



18. Create a pivot table to display the total purchase, withdrawal and
deposit for all the customers.