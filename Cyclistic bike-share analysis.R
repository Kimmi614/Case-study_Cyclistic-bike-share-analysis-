---
title: "Cyclistic bike-share analysis"
author: "Kimmi"
date: "2021/12/15"
output: html_document
---
  ```{r install and load the related packages}
install.packages("tidyverse")
install.packages("janitor")
install.packages("lubridate")
library("tidyverse")
library("janitor")
library(lubridate)
install.packages("skimr")
library(skimr)
library(dplyr)

getwd() #displays your working directory
#=====================
# STEP 1: COLLECT DATA
#=====================
# Upload Divvy datasets (csv files) here
data_202012 <-read.csv("202012-divvy-tripdata.csv")
data_202101 <-read.csv("202101-divvy-tripdata.csv")
data_202102 <-read.csv("202102-divvy-tripdata.csv")
data_202103 <-read.csv("202103-divvy-tripdata.csv")
data_202104 <-read.csv("202104-divvy-tripdata.csv")
data_202105 <-read.csv("202105-divvy-tripdata.csv")
data_202106 <-read.csv("202106-divvy-tripdata.csv")
data_202107 <-read.csv("202107-divvy-tripdata.csv")
data_202108 <-read.csv("202108-divvy-tripdata.csv")
data_202109 <-read.csv("202109-divvy-tripdata.csv")
data_202110 <-read.csv("202110-divvy-tripdata.csv")
data_202111 <-read.csv("202111-divvy-tripdata.csv")
```{r}

```

#====================================================
# STEP 2: WRANGLE DATA AND COMBINE INTO A SINGLE FILE
#====================================================
# Compare column names each of the files
# While the names don't have to be in the same order, they DO need to match perfectly before we can use a command to join them into one file
colnames(data_202012)
colnames(data_202101)
colnames(data_202102)
colnames(data_202103)
colnames(data_202104)
colnames(data_202105)
colnames(data_202106)
colnames(data_202107)
colnames(data_202108)
colnames(data_202109)
colnames(data_202110)
colnames(data_202111)

# Inspect the dataframes and look for incongruencies
str(data_202012)
str(data_202101)
str(data_202102)
str(data_202103)
str(data_202104)
str(data_202105)
str(data_202106)
str(data_202107)
str(data_202108)
str(data_202109)
str(data_202110)
str(data_202111)

# Convert ride_id and rideable_type to character so that they can stack correctly
data_202012 <-  mutate(data_202012, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 
data_202101 <-  mutate(data_202101, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 
data_202102 <-  mutate(data_202102, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type))
data_202103 <-  mutate(data_202102, ride_id = as.character(ride_id)
                       ,rideable_type = as.character(rideable_type)) 
data_202104 <-  mutate(data_202102, ride_id = as.character(ride_id)
                       ,rideable_type = as.character(rideable_type)) 
data_202105 <-  mutate(data_202102, ride_id = as.character(ride_id)
                       ,rideable_type = as.character(rideable_type)) 
data_202106 <-  mutate(data_202102, ride_id = as.character(ride_id)
                       ,rideable_type = as.character(rideable_type)) 
data_202107 <-  mutate(data_202102, ride_id = as.character(ride_id)
                       ,rideable_type = as.character(rideable_type)) 
data_202108 <-  mutate(data_202102, ride_id = as.character(ride_id)
                       ,rideable_type = as.character(rideable_type)) 
data_202109 <-  mutate(data_202102, ride_id = as.character(ride_id)
                       ,rideable_type = as.character(rideable_type)) 
data_202110 <-  mutate(data_202102, ride_id = as.character(ride_id)
                       ,rideable_type = as.character(rideable_type)) 
data_202111 <-  mutate(data_202102, ride_id = as.character(ride_id)
                       ,rideable_type = as.character(rideable_type)) 

# Stack individual quarter's data frames into one big data frame
all_trips <- bind_rows(data_202012
                       , data_202101
                       , data_202102
                       , data_202103
                       , data_202104
                       , data_202105
                       , data_202106
                       , data_202107
                       , data_202108
                       , data_202109
                       , data_202110
                       , data_202111)

# Remove lat, long, birthyear, and gender fields as this data was dropped beginning in 2020
all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng))
            
# Rename columns
all_trips <- all_trips %>% rename(trip_id= ride_id
                                  ,ride_type= rideable_type
                                  ,start_time= started_at
                                  ,end_time= ended_at
                                  ,from_station_name = start_station_name 
                                  ,from_station_id = start_station_id
                                  ,to_station_name = end_station_name
                                  ,to_station_id =  end_station_id
                                  ,member_casual = usertype)

#======================================================
# STEP 3: CLEAN UP AND ADD DATA TO PREPARE FOR ANALYSIS
#======================================================
# Inspect the new table that has been created
colnames(all_trips)  #List of column names
nrow(all_trips)  #How many rows are in data frame?
dim(all_trips)  #Dimensions of the data frame?
head(all_trips)  #See the first 6 rows of data frame.  Also tail(all_trips)
str(all_trips)  #See list of columns and data types (numeric, character, etc)
summary(all_trips)  #Statistical summary of data. Mainly for numerics

# There are a few problems we will need to fix:
# (1) In the "member_casual" column, there are two names for members ("member" and "Subscriber") and two names for casual riders ("Customer" and "casual"). We will need to consolidate that from four to two labels.
# (2) The data can only be aggregated at the ride-level, which is too granular. We will want to add some additional columns of data -- such as day, month, year -- that provide additional opportunities to aggregate the data.
# (3) We will want to add a calculated field for length of ride since the 2020Q1 data did not have the "tripduration" column. We will add "ride_length" to the entire dataframe for consistency.
# (4) There are some rides where tripduration shows up as negative, including several hundred rides where Divvy took bikes out of circulation for Quality Control reasons. We will want to delete these rides.

# In the "member_casual" column, replace "Subscriber" with "member" and "Customer" with "casual"
# Before 2020, Divvy used different labels for these two types of riders ... we will want to make our dataframe consistent with their current nomenclature
# N.B.: "Level" is a special property of a column that is retained even if a subset does not contain any values from a specific level
# Begin by seeing how many observations fall under each usertype
table(all_trips$member_casual)

# Reassign to the desired values (we will go with the current 2020 labels)
all_trips <-  all_trips %>% 
  mutate(member_casual = recode(member_casual
                                ,"Subscriber" = "member"
                                ,"Customer" = "casual"))

# Check to make sure the proper number of observations were reassigned
table(all_trips$member_casual)

# Add columns that list the date, month, day, and year of each ride
# This will allow us to aggregate ride data for each month, day, or year ... before completing these operations we could only aggregate at the ride level
# https://www.statmethods.net/input/dates.html more on date formats in R found at that link
all_trips$date <- as.Date(all_trips$start_time)
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")

# Add a "ride_length" calculation to all_trips (in seconds)
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/difftime.html
all_trips$ride_length <- difftime(all_trips$end_time,all_trips$start_time)

# Inspect the structure of the columns
str(all_trips)

# Convert "ride_length" from Factor to numeric so we can run calculations on the data
is.factor(all_trips$ride_length)
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

# Remove "bad" data
# The dataframe includes a few hundred entries when bikes were taken out of docks and checked for quality by Divvy or ride_length was negative
# We will create a new version of the dataframe (v2) since data is being removed
# https://www.datasciencemadesimple.com/delete-or-drop-rows-in-r-with-conditions-2/
all_trips_v2 <- all_trips[!(all_trips$from_station_name  == "HQ QR" | all_trips$ride_length<0),]

#=====================================
# STEP 4: CONDUCT DESCRIPTIVE ANALYSIS
#=====================================
# Descriptive analysis on ride_length (all figures in seconds)
mean(all_trips_v2$ride_length) #straight average (total ride length / rides)
median(all_trips_v2$ride_length) #midpoint number in the ascending array of ride lengths
max(all_trips_v2$ride_length) #longest ride
min(all_trips_v2$ride_length) #shortest ride

summary(all_trips_v2)

# You can condense the four lines above to one line using summary() on the specific attribute
summary(all_trips_v2$ride_length)

# Compare members and casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)

# Notice that the days of the week are out of order. Let's fix that.
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"))

# Now, let's run the average ride time by each day for members vs casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)

# analyze ridership data by type and weekday
all_trips_v2 %>% 
  mutate(weekday = wday(start_time, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, weekday)								# sorts

# Let's visualize the number of rides by rider type
all_trips_v2 %>% 
  mutate(weekday = wday(start_time, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

# Let's create a visualization for average duration
all_trips_v2 %>% 
  mutate(weekday = wday(start_time, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")

#=================================================
# STEP 5: EXPORT SUMMARY FILE FOR FURTHER ANALYSIS
#=================================================
# Create a csv file that we will visualize in Excel, Tableau, or my presentation software
# N.B.: This file location is for a Mac. If you are working on a PC, change the file location accordingly (most likely "C:\Users\YOUR_USERNAME\Desktop\...") to export the data. You can read more here: https://datatofish.com/export-dataframe-to-csv-in-r/
counts <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
write.csv(counts, "avg_ride_length.csv")
write.csv(all_trips_v2, "tripdata.csv")