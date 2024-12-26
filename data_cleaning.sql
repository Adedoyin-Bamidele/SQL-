SELECT *
  FROM [First_SQL_Project].[dbo].[Nashvile 2]

--Changing SaleDate format 
  Select SaleDate, convert(Date, SaleDate) as SalesDates
  from [First_SQL_Project].[dbo].[Nashvile 2]

Update [First_SQL_Project].[dbo].[Nashvile 2]
set SaleDate =convert(Date, SaleDate)
 
 Alter Table [First_SQL_Project].[dbo].[Nashvile 2]
Add salesDate Date;

--filling null values of PropertyAddress
 SELECT PropertyAddress, ParcelID
  FROM [First_SQL_Project].[dbo].[Nashvile 2]
  where PropertyAddress is  null
  Order by ParcelID 

  Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
  FROM [First_SQL_Project].[dbo].[Nashvile 2] as a 
  Join [First_SQL_Project].[dbo].[Nashvile 2] as b
on a.ParcelID = b.ParcelID
and a.UniqueID <>b.UniqueID
where a. PropertyAddress is null


Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
 FROM [First_SQL_Project].[dbo].[Nashvile 2] as a 
  Join [First_SQL_Project].[dbo].[Nashvile 2] as b
on a.ParcelID = b.ParcelID
and a.UniqueID <>b.UniqueID
where a. PropertyAddress is null

[First_SQL_Project].[dbo].[Nashvile 2]
   Alter Table [First_SQL_Project].[dbo].[Nashvile 2]
  add PropertysplitAddress nvarchar(255)

   Alter Table [First_SQL_Project].[dbo].[Nashvile 2]
  add PropertysplitCity nvarchar(255)

Substring (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)
, Substring (PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, len(PropertyAddress)) 

  Update [First_SQL_Project].[dbo].[Nashvile 2]
  set PropertysplitAddress =  Substring (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)
   
   Update [First_SQL_Project].[dbo].[Nashvile 2]
  Set PropertySplitCity = Substring (PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, len(PropertyAddress)) 


  select 
 Parsename(Replace(OwnerAddress,',','.'),3)
 ,Parsename(Replace(OwnerAddress,',','.'),2)
 ,Parsename(Replace(OwnerAddress,',','.'),1)
  from [First_SQL_Project].[dbo].[Nashvile 2]

   Alter Table [First_SQL_Project].[dbo].[Nashvile 2]
  add OwnersplitAddress nvarchar(255)
   update [First_SQL_Project].[dbo].[Nashvile 2]
   set OwnersplitAddress = Parsename(Replace(OwnerAddress,',','.'),3)

   Alter Table [First_SQL_Project].[dbo].[Nashvile 2]
  add OwnersplitCity nvarchar(255)
  update [First_SQL_Project].[dbo].[Nashvile 2]
  set OwnersplitCity = Parsename(Replace(OwnerAddress,',','.'),2)
 
 Alter table [First_SQL_Project].[dbo].[Nashvile 2]
 add OnwersplitState nvarchar(255)
Update [First_SQL_Project].[dbo].[Nashvile 2]
set OnwersplitState = Parsename(Replace(OwnerAddress,',','.'),1)

select * 
from  [First_SQL_Project].[dbo].[Nashvile 2]

--Changing  y and n  to yes and no 
 
 select Distinct(SoldAsVacant), count(SoldAsVacant)
 from [First_SQL_Project].[dbo].[Nashvile 2]
 Group by SoldAsVacant 
 Order by 2 
  
  select SoldAsVacant
 , case when SoldAsvacant = 'Y' then 'Yes'
        when SoldAsvacant = 'N' then 'No'
		else SoldAsVacant
		end 
from  [First_SQL_Project].[dbo].[Nashvile 2]

update [First_SQL_Project].[dbo].[Nashvile 2]
  set SoldAsVacant = case when SoldAsvacant = 'Y' then 'Yes'
        when SoldAsvacant = 'N' then 'No'
		else SoldAsVacant
		end 

--Remove Duplicates 
with RowNumCTE as (
select *,
 ROW_NUMBER()OVER(
 PARTITION BY ParcelID,
 PropertyAddress,
 SaleDate,
 LegalReference
 ORDER BY 
 UniqueID
 )row_num

from  [First_SQL_Project].[dbo].[Nashvile 2]
  --Order by ParcelID
  )
 Delete 
  from RowNumCTE
  where row_num > 1
 

