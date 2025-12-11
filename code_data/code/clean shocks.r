#---------- MP data cleaning ---------#
library(tidyverse)
library(lubridate)
library(janitor)

setwd("/Users/liusu/Desktop/macro project/prepared datasets")

### ------------------------------------ BRW shock data ------------------------------------##

BRWshock_OG <- read.csv("/Users/liusu/Desktop/macro project/MP/brw-shock-series.csv")


brw_month <- BRWshock_OG %>%
  mutate(                                                              # 把字符日期解析成 Date（你的格式是 m/d/y）
    date_fomc = parse_date_time(date_fomc, orders = c("mdy", "dmy")),  # 提取月份（floor 到月初）
    month = floor_date(date_fomc, "month")
  ) %>%
  filter(!is.na(brw_2024)) %>%         # 去除缺失 shock
  group_by(month) %>%                  # 按月汇总
  summarise(
    brw_2024 = sum(brw_2024, na.rm = TRUE)
  ) %>%
  ungroup()


RRupdated <- read_csv("/Users/liusu/Desktop/macro project/RRupdated/Romer&Romer_Data.xlsx")
head(RRupdated)

### ------------------------------------ HFI surprise shock data ------------------------------------##
MPsurprise<- read_excel("/Users/liusu/Desktop/macro project/MP/monetarypolicysurprise_monthly.xlsx")

MPsurprise_clean <- MPsurprise %>%
  select(Year, Month, MPS, MPS_ORTH) %>%         # 1. 保留需要的变量
  mutate(
    # 2. 构造一个真正的日期（用每月第一天作为代表）
    month = ymd(paste(Year, Month, "01", sep = "-"))
  ) 


########## merge to the oli data 
LBmerged_totaldemand <- LBmerged_totaldemand %>%
  left_join(MPsurprise_clean, by = "month")

us_supply_merged <- us_supply_merged %>%
  left_join(MPsurprise_clean, by = "month")

us_lp_supplytotal <- us_lp_supplytotal %>%
  left_join(MPsurprise_clean, by = "month")









