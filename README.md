# Case-study_Cyclistic-bike-share-analysis-

## Scenario
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director
of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore,
your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights,
your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives
must approve your recommendations, so they must be backed up with compelling data insights and professional data
visualizations.

## Characters and teams
- Cyclistic: A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself
apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with
disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about
8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to
commute to work each day.
- Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns
and initiatives to promote the bike-share program. These may include email, social media, and other channels.
- Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and
reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy
learning about Cyclistic’s mission and business goals — as well as how you, as a junior data analyst, can help Cyclistic
achieve them.
- Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the
recommended marketing program.

## About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that
are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and
returned to any other station in the system anytime.
Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments.
One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes,
and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers
who purchase annual memberships are Cyclistic members.
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the
pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will
be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a
very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic
program and have chosen Cyclistic for their mobility needs.
Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to
do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why
casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are
interested in analyzing the Cyclistic historical bike trip data to identify trends.

## Ask
Three questions will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

## Identify the business task
Annual members probably make more money than casual riders. With the support of Data Analysis, I need to come up with a plan for converting casual riders into annual members.

### Consider key stakeholders
- Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns
and initiatives to promote the bike-share program. These may include email, social media, and other channels.
- Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and
reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy
learning about Cyclistic’s mission and business goals — as well as how you, as a junior data analyst, can help Cyclistic
achieve them.
- Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the
recommended marketing program.

## Prepare
### Download data and store it appropriately
I use Cyclistic’s historical trip data to analyze and identify trends. And the data is downloaded [here](https://divvy-tripdata.s3.amazonaws.com/index.html).

### Identify how it’s organized
The data is in CSV file format. There are 13 columns as below. 
- "ride_id"
- "rideable_type"
- "started_at"        
- "ended_at"
- "start_station_name"
- "start_station_id"  
- "end_station_name"
- "end_station_id"
- "start_lat"         
- "start_lng"
- "end_lat"
- "end_lng"           
- "member_casual"

### Sort and filter the data
I filter the past 12 month trip data for the analysis.

### Determine the credibility of the data
There are Data-privacy issues. Due to riders’ personally identifiable information, I won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

## Process and Analyse
I use R programming to conduct the data cleaning process. Please refer to [here](https://github.com/Kimmi614/Case-study_Cyclistic-bike-share-analysis-/blob/f0b0ef0ccb6a7fd3f2faaf297945b4dac9aacd70/2.%20Analysis%20a%20%E2%80%9C/Case%20study_Cyclistic%20bike-share%20analysis%20_final%20version.rmd).

### Data Cleaning and Data Transformation
- Check the data for errors
- Transform the data

### Data Calculation
- Aggregate data
- Organize and format data.
- Perform calculations

## Summary of analysis
- Saturday and Sunday are the popular days for renting a bike, regardless of whether a Member or a Casual Rider.
- The number of Casual Riders who hire a bike is lowest from Monday to Thursday and increases as the week goes, whereas members rent bikes on a more consistent basis throughout the week.

## Act
Here's my suggestions.
- Conduct a survey to get information from existing casual riders and learn what features or benefits they seek when considering becoming annual members.
- To attract casual riders to a full yearly membership and savings for longer rides, offer a weekend-only membership at a different price point than the full annual membership.
