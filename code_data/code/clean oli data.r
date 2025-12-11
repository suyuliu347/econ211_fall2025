library(reader)
library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)
library(gt)

setwd("/Users/liusu/Desktop/macro project/prepared datasets"). # set up the working directory

####################################--- oli data cleaning ---####################################################

#import the dataset
buyer_country_OG <- read.csv("/Users/liusu/Desktop/oli/bcountrydata_2024-09-02.txt")
wcd_country <- read.csv("/Users/liusu/Desktop/oli/monthly_wcd_2024-09-02.txt")

### --------------------demand ----------------------##

buyer_country <- buyer_country_OG %>%
  mutate(timestamp = ymd(timestamp))    # Convert timestamp to Date
class(buyer_country$timestamp)  #Check if it worked: "Date"

# create the monthly variable
buyer_country <- buyer_country %>%
  mutate(month = floor_date(timestamp, "month"))  

# pick the us data
buyer_us_daily <- buyer_country %>%
  mutate(date = ymd(timestamp)) %>%     # 确保是 Date 类型
  filter(country == "United States") %>% 
  select(date, country, occupation, count)


# Aggregate to monthly
buyer_monthly <- buyer_country %>%
  group_by(month, country, country_group, occupation) %>%
  summarise(count = sum(count, na.rm = TRUE), .groups = "drop")

# a summary table of how many observations per country:
range(buyer_monthly$month)  # "2016-07-01"- "2024-09-01"
length(unique(buyer_monthly$country))  # "149 countries"

table(buyer_monthly$country)

###----- Extract only United States data -----##
us_buyer <- buyer_monthly %>%
  filter(country == "United States")

write.csv(us_buyer, "us_buyer.csv", row.names = FALSE)


### --------------------supply ----------------------##

us_wcd <- wcd_country %>%
  filter(country == "United States")


us_wcd <- us_wcd %>%                              
  mutate(month = floor_date(ymd(timestamp), "month")) %>% 
  select(month, occupation, num_workers)

