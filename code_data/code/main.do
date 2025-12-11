*******************************************************
* run_all.do
*******************************************************

clear all
set more off

*******************************************************
* 0. Define paths
*******************************************************
* Change this to your local path to the repository
global root "/Users/yourname/path/to/repo"

cd "$root/code"

*******************************************************
* 1. Run R scripts to clean and prepare data
*******************************************************
display "Running R scripts to clean data"

* Clean OLI demand and supply (daily → monthly, restrict country-us)
shell Rscript "clean_oli_data.r"

* Process BRW and HFI monetary policy shocks
shell Rscript "clean_shocks.r"

* Merge OLI + other labor indicators + monetary policy shocks
shell Rscript "merge.r"


*******************************************************
* 2. Run baseline regressions
*******************************************************
display "Running baseline regressions"
do "baseline_regressions.do"


*******************************************************
* 3. Produce figures used in the paper
*******************************************************
display "Generating figures"

* Figure 1
do "figure1.do"

* Figure 2 panels A–D
do "figure2a.do"
do "figure2b.do"
do "figure2c.do"
do "figure2d.do"

* Figure 3 panels A–E
do "figure3.do"

