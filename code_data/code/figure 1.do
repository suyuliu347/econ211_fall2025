****************** figure 1 **************

//based on the results restored before, we can draw the coefficients of demand and supply across  occupations 

coefplot ///
    (SUP, label("Supply") msymbol(O)  mcolor("51 102 204") ///
          ciopts(lcolor("51 102 204"))) ///
    (DEM, label("Demand") msymbol(D) mcolor("204 51 51")  ///
          ciopts(lcolor("204 51 51"))), ///

    horizontal ///
    xline(0, lcolor(gs8) lpattern(dash)) ///

    coeflabels( ///
        1.occ_id = "Clerical" ///
        2.occ_id = "Creative" ///
        3.occ_id = "Professional" ///
        4.occ_id = "Sales/Marketing" ///
        5.occ_id = "Software/IT" ///
        6.occ_id = "Writing/Transl." ///
    ) ///

    xlabel(, labsize(small)) ///
    ylabel(, labsize(small)) ///

    legend(order( SUP "Supply" DEM "Demand" )) ///
    title("Heterogeneous Responses across Occupations") ///
    xtitle("Effect of 1-unit shock on online activity") ///
    graphregion(color(white))
