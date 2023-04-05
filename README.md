# Nashville-Housing-Data_SQL

These codes are SQL queries that are used to clean and manipulate data in a dataset named "NashvilleHousing". The dataset contains information about housing properties in Nashville, Tennessee. The queries perform several data cleaning operations such as populating missing values, splitting data into columns, renaming values, removing duplicates, and dropping unused columns. Specifically, the queries do the following:

Query 1: Select all columns from the "NashvilleHousing" dataset.

Query 2: Populate missing values in the "PropertyAddress" column of the "NashvilleHousing" dataset by joining rows with the same "ParcelID".

Query 3: Split the "PropertyAddress" column of the "NashvilleHousing" dataset into separate columns for "address1" and "address2".

Query 4: Split the "OwnerAddress" column of the "NashvilleHousing" dataset into separate columns for "Street_name", "City", and "State".

Query 5: Rename values in the "SoldAsVacant" column of the "NashvilleHousing" dataset from "true" and "false" to "Yes" and "No", respectively.

Query 6: Remove duplicate rows from the "NashvilleHousing" dataset based on certain columns.

Query 7: Drop the "saledate" column from the "NashvilleHousing" dataset.
