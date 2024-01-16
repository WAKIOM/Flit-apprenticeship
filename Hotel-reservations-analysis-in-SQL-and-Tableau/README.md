# HOTEL RESERVATION ANALYSIS IN SQL AND TABLEAU
## TOOLS
SQL 
TABLEAU

## METADATA 
## DATA CLEANING

### Check for Duplicates
- Checked for duplicate groups, 8186 duplicate groups found.
- Identified 32,019 rows with duplicates, which accounted for 26.8% of the dataset.
### Remove Duplicates and Create a Cleaned Table
- Created a new table, `hotel_reservations`, excluding duplicate rows.
- Cleaned columns in the new table, leaving the original table untouched.
- Dropped the temporary row num column used for identifying duplicates.
### Clean other columns with categorical data
- Modified data types of `is_canceled` and `is_repeated_guest` columns to VARCHAR(255).
- Updated values in the `is_canceled` and `is_repeated_guest` columns based on the description mapping.
- Cleaned the `meal` column based on description mappings.
- Updated values in the `market_segment` and `distribution_channel` columns for better clarity.
### Clean the Reservation Status Date Column
- Altered the table to add a new date column, `rsvp_status_date`.
- Updated the new date column by converting the old VARCHAR column using the `STR_TO_DATE` function.
- Dropped the old VARCHAR column.
- Renamed the new date column back to `reservation_status_date`.
### Update the Country Column
- Updated the `country` column with the respective country names from the `countries` table.
### Identify Missing Countries
- Checked for missing countries and found that 0.51% of the dataset had NULL values in the `country` column.
