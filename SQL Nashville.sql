/*
Cleaning Data in SQL Queries
*/


Select *
From "NashvilleHousing"

--------------------------------------------------------------------------------------------------------------------------


-- Populate Property Address data

Select *
From "NashvilleHousing"
--Where PropertyAddress is null
order by ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, 
    CASE WHEN a.PropertyAddress IS NULL THEN b.propertyaddress ELSE a.propertyaddress END 
FROM "NashvilleHousing" a
JOIN "NashvilleHousing" b
    ON a.ParcelID = b.ParcelID AND a.uniqueid <> b.uniqueid
WHERE a.PropertyAddress IS NULL;
	

Update "NashvilleHousing" a
SET PropertyAddress = CASE WHEN a.PropertyAddress IS NULL THEN b.propertyaddress ELSE a.propertyaddress END 
From "NashvilleHousing" b
	WHERE a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID AND a.PropertyAddress IS NULL;



--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


Select propertyaddress
From "NashvilleHousing"
--Where PropertyAddress is null
--order by ParcelID

SELECT
    SUBSTRING(propertyaddress, 1, POSITION(',' IN propertyaddress) - 1) AS address1,
    SUBSTRING(propertyaddress, POSITION(',' IN propertyaddress) + 1) AS address2
FROM "NashvilleHousing";

--Add new column in dataset to store the street address
ALTER TABLE "NashvilleHousing"
Add PropertySplitAddress TEXT;

--Add the split address in the new column created above
Update "NashvilleHousing"
SET PropertySplitAddress = SUBSTRING(propertyaddress, 1, POSITION(',' IN propertyaddress) - 1)

--Add new column in dataset to add the city name of the address
ALTER TABLE "NashvilleHousing"
Add PropertySplitCity Text;

--Add the city name in the new column created above
Update "NashvilleHousing"
SET PropertySplitCity = SUBSTRING(propertyaddress, POSITION(',' IN propertyaddress) + 1)


Select *
From "NashvilleHousing"

--looking into the owner address
Select OwnerAddress
From "NashvilleHousing"

--splitting the owner address into Street name, city and state
SELECT
  split_part(REPLACE(owneraddress, ',', '.') , '.', 1) as Street_name,
  split_part(REPLACE(owneraddress, ',', '.') , '.', 2) as City,
  split_part(REPLACE(owneraddress, ',', '.') , '.', 3) as State
FROM "NashvilleHousing";


--Add new column in dataset to add the street name of the owneraddress
ALTER TABLE "NashvilleHousing"
Add OwnerSplitAddress Text;

--Add the street name in the new column created above
Update "NashvilleHousing"
SET OwnerSplitAddress = split_part(REPLACE(owneraddress, ',', '.') , '.', 1)


--Add new column in dataset to add the city name of the owneraddress
ALTER TABLE "NashvilleHousing"
Add OwnerSplitCity Text;

--Add the street name in the new column created above
Update "NashvilleHousing"
SET OwnerSplitCity = split_part(REPLACE(owneraddress, ',', '.') , '.', 2)


--Add new column in dataset to add the state name of the owneraddress
ALTER TABLE "NashvilleHousing"
Add OwnerSplitState Text;

--Add the street name in the new column created above
Update "NashvilleHousing"
SET OwnerSplitState = split_part(REPLACE(owneraddress, ',', '.') , '.', 3)


--------------------------------------------------------------------------------------------------------------------------


-- Change true and false to Yes and No in "Sold as Vacant" field


Select *
From "NashvilleHousing"


Select Distinct(SoldAsVacant),Count(SoldAsVacant)
From "NashvilleHousing"
Group by SoldAsVacant
order by 2



Update "NashvilleHousing"
SET SoldAsVacant = CASE When SoldAsVacant = 'true' THEN 'Yes'
	   When SoldAsVacant = 'false' THEN 'No'
	   ELSE SoldAsVacant
	   END

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From "NashvilleHousing"
--order by ParcelID
)
Delete from "NashvilleHousing"
WHERE UniqueID IN (
  SELECT UniqueID
  FROM RowNumCTE
  WHERE row_num > 1);


---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

	
Select *
From "NashvilleHousing"


ALTER TABLE "NashvilleHousing"
DROP COLUMN saledate;
				


