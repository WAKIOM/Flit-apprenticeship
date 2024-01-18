# HOTEL RESERVATION ANALYSIS IN SQL AND TABLEAU

## OVERVIEW
A hotel chain i won't mention, has reached out wanting to gain insights from the reservations data they have, The aim is to use SQL and Tableau to explore, analyze and come up with a dashboard.

## TOOLS
	MySQL 
	TABLEAU 

## [METADATA](https://github.com/WAKIOM/Flit-apprenticeship/blob/master/Hotel-reservations-analysis-in-SQL-and-Tableau/SQL_files/description.md) 

# HIGH LEVEL STEPS
## 1. Data Import
#### [Table creation and data importation](https://github.com/WAKIOM/Flit-apprenticeship/blob/master/Hotel-reservations-analysis-in-SQL-and-Tableau/SQL_files/tables_creation.sql)
- Created the reservations table skeleton, then imported the csv file using the `LOAD DATA INLINE` function which is way faster compared to the data import wizard.
	LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\hotel_reservations.csv'
	INTO TABLE reservations
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES;
- Downloaded data containing country codes from [kaggle.com](https://www.kaggle.com/datasets/juanumusic/countries-iso-codes/data) and their respective name which i loaded the csv file to the database, later used it to enrich the country column in the reservations table

## 2. Data  Exploration and Cleaning
#### Check for Duplicates
- Checked for duplicate groups, 8186 duplicate groups found.
- Identified 32,019 rows with duplicates, which accounted for 26.8% of the dataset.
#### Remove Duplicates and Create a Cleaned Table
- Created a new table, `hotel_reservations`, excluding duplicate rows.
- Cleaned columns in the new table, leaving the original table untouched.
- Dropped the temporary row num column used for identifying duplicates.
#### Clean other columns with categorical data
- Modified data types of `is_canceled` and `is_repeated_guest` columns to VARCHAR(255).
- Updated values in the `is_canceled` and `is_repeated_guest` columns based on the description mapping.
- Cleaned the `meal` column based on description mappings.
- Updated values in the `market_segment` and `distribution_channel` columns for better clarity.
#### Clean the Reservation Status Date Column
- Altered the table to add a new date column, `rsvp_status_date`.
- Updated the new date column by converting the old VARCHAR column using the `STR_TO_DATE` function.
- Dropped the old VARCHAR column.
- Renamed the new date column back to `reservation_status_date`.
#### Update the Country Column
- Updated the `country` column with the respective country names from the `countries` table.
#### Identify Missing Countries
- Checked for missing countries and found that 0.51% of the dataset had NULL values in the `country` column.

## 3. SQL Analysis
Diving deep into the analysis, Below are the questions that guided my analysis process.

### [Exploratory data analysis](https://github.com/WAKIOM/Flit-apprenticeship/blob/master/Hotel-reservations-analysis-in-SQL-and-Tableau/SQL_files/Exploratory_data_analysis.sql)

- What is the average length of stay for both weeknights and weekend nights?
- What is the average daily rate across all reservations?
- What percentage of people prefer using a booking agent?
- What percentage of people have booked using a booking company?
- What percentage of people prefer not using either booking agent or booking company?
- Do customers get assigned the room types they reserved?
- What are the most common meal packages reserved by guests?
- Which countries contribute the most reservations? (Top 10)
- How often do customers make changes or amendments to their reservations?
- What are the most common numbers of special requests made by customers?
- How are successful reservations distributed per hotel type?
- How are successful reservations distributed per year?
- How are successful reservations distributed per month?
- How many customers require car parking spaces?
- What is the distribution of reservation statuses?
- How is customer distribution by market segment?
- How is customer distribution by distribution channel?
- How is customer distribution by reserved room type?
- How is customer distribution by repeat and non-repeat guests?
- How is customer distribution by deposit type?
- How is customer distribution by customer type?
- What is the average number of days in the waiting list?
- What percentage of customers prefer staying during weekend nights?
- What percentage of customers prefer staying during weeknights?
- What percentage of customers reserve both during week and weekend nights?
- What percentage of customers reserve with children?
- What percentage of customers reserve with babies?
### [Cancelations analysis](https://github.com/WAKIOM/Flit-apprenticeship/blob/master/Hotel-reservations-analysis-in-SQL-and-Tableau/SQL_files/cancellations_analysis.sql)

- What is the overall cancellation rate?
- How does the cancellation rate vary across different hotel groups?
- Is there a correlation between having children and the likelihood of cancellation?
- Are non-repeat guests more likely to cancel reservations?
- How does the cancellation rate differ across distribution channels?
- What is the cancellation rate for different market segments?
- Do reservations made with booking agents or booking companies have a higher cancellation rate?
- How does the cancellation rate vary based on customer types?
- Which month has a higher cancellation rate?
- Are there countries with a higher tendency to cancel bookings?
- Do different deposit types influence the cancellation rate?
- Is there a correlation between having special requests and the likelihood of cancellation?
- Does being on a waiting list impact the cancellation rate?
- Do customers tend to cancel when they don't get the room they reserved?
- Is there a relationship between the number of booking changes and the cancellation rate?
- How does the number of special requests impact the cancellation rate?

### [Lead time analysis](https://github.com/WAKIOM/Flit-apprenticeship/blob/master/Hotel-reservations-analysis-in-SQL-and-Tableau/SQL_files/lead_time_analysis.sql)
- What is the average lead time for reservations across all data?
- How does the average lead time differ between different hotel types?
- What is the average lead time for reservations in different years?
- How does the lead time vary across different market segments?
- What is the average lead time for reservations made through different distribution channels?
- Is there a difference in lead time between repeat and non-repeat guests?
- How does the average lead time vary based on the reserved room type?
- What is the average lead time for different customer types?
- Does the deposit type influence the average lead time for reservations?
- How does the lead time differ across different months?
- What is the average lead time for reservations from different countries? 

## 4. Tableau Visualization 

### [Link to Published Tableau Visualization](https://public.tableau.com/views/Hotelreservationsanalysis/Reservationsanalysis?:language=en-US&:display_count=n&:origin=viz_share_link)

![visualization](https://github.com/WAKIOM/Flit-apprenticeship/blob/master/Hotel-reservations-analysis-in-SQL-and-Tableau/customer%20segmentation.png)
## 5. Presentation
### [Hotel reservations story](https://github.com/WAKIOM/Flit-apprenticeship/blob/master/Hotel-reservations-analysis-in-SQL-and-Tableau/Reservations%20analysis%20Story.pdf)
