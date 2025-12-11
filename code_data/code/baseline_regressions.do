
cd "/Users/liusu/Desktop/macro project"

**************************************** baseline regressions ***********************************************

////////////// total demand //////////////
use "/Users/liusu/Desktop/macro project/prepared datasets/us_lp_totaldemand_brw.dta", clear
*  从你的 "month" 变量 (如 01jul2016) 创建一个新的 "Stata月度" 变量
* mofd() 函数 = "month-of-date"
* set
gen month_m = mofd(month)
format month_m %tm
tsset month_m

///keep the amount of months 2017-05 to 2023-11
keep if inrange(month_m, tm(2017m4), tm(2023m12))

///create baseline index
*sort month_m
*gen base = total_count[1] 
*gen demand_index = (total_count/base)*100

* newey
gen cal_month = month(month)

newey log_count fomc_shock L.log_count i.cal_month, lag(12)


////////////// demand by occupations //////////////
use "/Users/liusu/Desktop/macro project/prepared datasets/us_lp_demand_brw.dta", clear

gen month_m = monthly(month_str, "YM")
format month_m %tm
keep if inrange(month_m, tm(2017m4), tm(2024m8))


encode occupation, gen(occ_id)      // 把职业字符串转为数字id
encode month_str, gen(month_id)     // 把月份字符串转为数字id

xtset occ_id month_id

gen lcount = ln(count)

xtreg lcount brw_2024, fe cluster(occ_id)

* compare effects among occupations
xtreg lcount c.brw_2024#i.occ_id, fe
margins occ_id, dydx(brw_2024) post

estimates store SUP



////////////// total supply //////////////
use "/Users/liusu/Desktop/macro project/prepared datasets/us_lp_totalsupply_brw.dta",clear

gen month_m = mofd(month)
format month_m %tm
tsset month_m

newey log_count fomc_shock L.log_count, lag(12)

* time fe
gen cal_month = month(month)
newey log_count fomc_shock L.log_count i.cal_month, lag(12)

newey log_count L(0/3).fomc_shock L.log_count, lag(12)


////////////// supply by occupations //////////////
use "/Users/liusu/Desktop/macro project/prepared datasets/us_lp_supply_brw.dta", clear
  
encode occupation, gen(occ_id) 

* 1. 把 %tc 转成 daily date
gen double date_d = dofc(month)
format date_d %td
* 2. 把 daily date 转成 monthly date
gen mdate = mofd(date_d)
format mdate %tm
* 3. 替换掉原 month 变量
drop month
rename mdate month

xtset occ_id month

gen lcount = ln(num_workers)

xtreg lcount brw_2024, fe cluster(occ_id)

* compare effects among occupations	
xtreg lcount c.brw_2024#i.occ_id

margins occ_id, dydx(brw_2024) post

estimates store DEM	
	
	
	