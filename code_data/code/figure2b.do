**************** local projection - supply ************
*********** figure2b ***********
use "/Users/liusu/Desktop/macro project/prepared datasets/us_lp_totalsupply_brw.dta",clear

gen month_m = mofd(month)
format month_m %tm
tsset month_m

lpirf log_count, step(12) lags(1/3) exog(fomc_shock) dfk vce(hac nwest 12) level(90)
irf set lpirf.irf, replace
irf create lpmodel_supply

irf graph dm, irf(lpmodel_supply) impulse(fomc_shock) 
