#---------- MP oli and labor market indicators merging ---------#
library(dplyr)
library(lubridate)
library(stringr)

### ---------------------------
### 1. Clean 
### ---------------------------


### ---------------------------
### 2. Merge
### ---------------------------
us_oli_merged <- us_buyer_clean %>%
  left_join(brw_month, by = "month")


us_supply_merged <- us_wcd %>%
  left_join(brw_month, by = "month")

### ---------------------------
### 3. Optional: reorder columns
### ---------------------------
us_oli_merged <- us_oli_merged %>%
  select(month, month_str, brw_2024,
         country, country_group, occupation, count)


### ---------------------------
### 4. replace na by 0
### ---------------------------

us_oli_merged$brw_2024[is.na(us_oli_merged$brw_2024)] <- 0

us_supply_merged$brw_2024[is.na(us_supply_merged$brw_2024)] <- 0

### ---------------------------
### 5. sum OLI 
### ---------------------------

us_panel_total <- us_oli_merged %>%
  group_by(month) %>%
  summarise(
    total_count = sum(count, na.rm = TRUE),
    fomc_shock = unique(brw_2024)
  ) %>%
  arrange(month)

us_lp_total <- us_panel_total %>%
  mutate(
    month = as.Date(month),
    log_count = log(pmax(total_count, 1))   # 取对数避免规模问题
  ) %>%
  arrange(month)


us_panel_supplytotal <- us_supply_merged %>%
  group_by(month) %>%
  summarise(
    total_supply = sum(num_workers, na.rm = TRUE),
    fomc_shock = unique(brw_2024)
  ) %>%
  arrange(month)

us_lp_supplytotal <- us_panel_supplytotal %>%
  mutate(
    month = as.Date(month),
    log_count = log(pmax(total_supply, 1))   # 取对数避免规模问题
  ) %>%
  arrange(month)


### ---------------------------
### 6. output
### ---------------------------
library(haven)

write_dta(us_lp_total, "us_lp_totaldemand_brw.dta")
write_dta(us_oli_merged, "us_lp_demand_brw.dta")



write_dta(us_lp_supplytotal, "us_lp_totalsupply_brw.dta")

write_dta(us_supply_merged, "us_lp_supply_brw.dta")

### ---------------------------
### 7. merge the traditional labor market data
### ---------------------------

openings <- read.csv("/Users/liusu/Desktop/macro project/labor market data/JTSJOL.csv")
participation<- read.csv("/Users/liusu/Desktop/macro project/labor market data/CIVPART.csv")
employees <- read.csv("/Users/liusu/Desktop/macro project/labor market data/PAYEMS.csv")
unrate <- read.csv("/Users/liusu/Desktop/macro project/labor market data/UNRATE.csv")

us_lp_total$month <- as.Date(us_lp_total$month)
openings$observation_date <- as.Date(openings$observation_date)
participation$observation_date <- as.Date(participation$observation_date)
employees$observation_date <- as.Date(employees$observation_date)
unrate$observation_date <- as.Date(unrate$observation_date)

openings <- openings %>% rename(month = observation_date)
participation <- participation %>% rename(month = observation_date)
employees <- employees %>% rename(month = observation_date)
unrate <- unrate %>% rename(month = observation_date)



LBmerged_totaldemand <- us_lp_total %>%
  left_join(openings, by = "month") %>%
  left_join(participation, by = "month") %>%
  left_join(employees, by = "month") %>%
  left_join(unrate, by = "month")



LBmerged_totaldemand$log_JTSJOL <- log(LBmerged_totaldemand$JTSJOL)
LBmerged_totaldemand$log_PAYEMS <- log(LBmerged_totaldemand$PAYEMS)

#output
write_dta(LBmerged_totaldemand, "LBmerged_totaldemand.dta")

write_csv(LBmerged_totaldemand, "LBmerged_totaldemand.csv")




