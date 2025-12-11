**************** local projection - demand ************
*********** figure2A ***********

use "/Users/liusu/Desktop/macro project/prepared datasets/us_lp_totaldemand_brw.dta", clear

gen month_m = mofd(month)
format month_m %tm
tsset month_m, monthly


keep if inrange(month_m, tm(2017m5), tm(2024m1))

* 估计 LP（例：h=24，内生滞后1–12，HAC(Newey-West, 12)）
lpirf log_count, step(12) lags(1/3) exog(fomc_shock) dfk vce(hac nwest 12) level(90)

irf set lpirf.irf, replace
irf create lpmodel

irf graph dm, irf(lpmodel) impulse(fomc_shock)
