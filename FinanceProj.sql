--Data Cleaning Project 


--Cleaning stock prices and finance data



select *
from Project.dbo.DataFinance

--Convert into date format

select ConvertedDate, Convert(Date,Date)
from Project.dbo.DataFinance

update Project.dbo.DataFinance
Set Date =  Convert(Date,Date)

alter table Project.dbo.DataFinance
Add ConvertedDate Date;

update Project.dbo.DataFinance
Set ConvertedDate = Convert(Date,Date)

alter table Project.dbo.DataFinance
drop column ConnvertedDate

--making null values = 0 to show theres no volume on that particular day

Select * 
From Project.dbo.DataFinance
--Where Volume is Null
--order by Volume
Update Project.dbo.DataFinance SET Volume = 0 
where Volume is Null

select *
From Project.dbo.DataFinance 


--Renaming columns
Select *
From Project.dbo.projFinance
EXEC sp_rename 'projFinance.Open','StOpen'


Select*
From Project.dbo.projFinance
Exec sp_rename 'projFinance.High','StHigh';
Exec sp_rename 'projFinance.Low','StLow';
Exec sp_rename 'projFinance.Close','StClose';
Exec sp_rename 'projFinance.Adj Close','StAdjClose'

--removing all duplicate values using temp table

with RowNumCTE As (
Select *,
 ROW_NUMBER() Over(
 Partition By StOpen,
              StHigh,
			  StLow,
			  StClose,
			  StAdjClose,
			  Volume
			  Order By
			  ConvertedDate
			  ) row_num
From Project.dbo.projFinance
)
Select*
From RowNumCTE
Where row_num > 1
--Order By Volume

Select * 
From Project.dbo.projFinance
		
