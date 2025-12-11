**************** contrast with traditional labor market - figure 3************

use "LBmerged_totaldemand.dta", clear

* ajust the date formate 
gen month_m = mofd(month)
format month_m %tm

/// already run the simplist reg, all unsignificant

* tsset
tsset month_m

* 创建你的日历月份虚拟变量 (你之前可能已经做过了)
gen cal_month = month(month)

* run newey 

newey log_JTSJOL fomc_shock L.log_JTSJOL i.cal_month, lag(12)
newey log_PAYEMS fomc_shock L.log_PAYEMS i.cal_month, lag(12)
newey UNRATE fomc_shock L.UNRATE i.cal_month, lag(12)
newey CIVPART fomc_shock L.CIVPART i.cal_month, lag(12)

************************************************************************************************
keep if inrange(month_m, tm(2016m7), tm(2019m12))  //before covid 
********************************************** LP ************************************************

//figure3a
lpirf log_count, step(12) lags(1/3) exog(fomc_shock) dfk vce(hac nwest 12)
irf set lpirf.irf, replace
irf create lpmodel
irf graph dm, irf(lpmodel) impulse(fomc_shock)


//figure3c 
lpirf JTSJOL, step(12) lags(1/3) exog(MPS) dfk vce(hac nwest 12)
irf set lpirf.irf, replace
irf create lpmodel
irf graph dm, irf(lpmodel) impulse(MPS)

//figure3d 
lpirf CIVPART, step(12) lags(1/3) exog(MPS) dfk vce(hac nwest 12)
irf set lpirf.irf, replace
irf create lpmodel
irf graph dm, irf(lpmodel) impulse(MPS)

//figure3e
lpirf UNRATE, step(12) lags(1/3) exog(MPS) dfk vce(hac nwest 12)
irf set lpirf.irf, replace
irf create lpmodel
irf graph dm, irf(lpmodel) impulse(MPS)

//figure3b 
use "us_lp_totalsupply_brw.dta",clear
gen month_m = mofd(month)
format month_m %tm
tsset month_m
keep if inrange(month_m, tm(2016m7), tm(2019m12))  //before covid 
 ** draw the figure3b - supply side
lpirf UNRATE, step(12) lags(1/3) exog(MPS) dfk vce(hac nwest 12)
irf set lpirf.irf, replace
irf create lpmodel
irf graph dm, irf(lpmodel) impulse(MPS)
