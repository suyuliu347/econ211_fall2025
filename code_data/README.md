# The Impact of Monetary Policy Shocks on Online Labor Markets – Code and Data

This repository contains the code and data about the paper "The Impact of Monetary Policy Shocks on Online Labor Markets", written by Suyu Liu.

## Paper webpage

The paper will be available at: .

## Raw data

The raw data used by the code to produce the results in the paper are stored as CSV or TXT files in the raw folder.

oli_demand_daily.parquet – Daily OLI buyer-demand counts by occupation and country, 2016–2023
Source: [Online Labor Observatory (2024)](https://figshare.com/articles/dataset/Online_Labour_Index_Measuring_the_Online_Gig_Economy_for_Policy_and_Research/3761562?file=48931042)

oli_supply_daily.parquet – Daily OLI worker-supply counts by occupation and country, 2016–2023
Source: [Online Labor Observatory (2024)](https://figshare.com/articles/dataset/Online_Labour_Index_Measuring_the_Online_Gig_Economy_for_Policy_and_Research/3761562?file=48931072)

brw_shocks.csv – High-frequency monetary policy shocks developed by Bu, Rogers, and Wu (2021) 
Source: [Bu, Rogers, and Wu (2021)](https://drive.google.com/file/d/1hYeeyY9okFhQz6yXmWdzQc7oaJJKYmVg/view)

hfi_shocks.csv – high-frequency Monetary policy shocks developed by [Bauer and Swanson (2023)](https://www.journals.uchicago.edu/doi/10.1086/723574)
Source: [Federal Reserve Bank of San Francisco](https://www.frbsf.org/research-and-insights/data-and-indicators/monetary-policy-surprises/)

macro_labor_indicators.csv – US unemployment, job openings, participation rate, 2000–2023
Source: BLS (2024)- [UNRATE](https://fred.stlouisfed.org/series/UNRATE) [JTSJOL](https://fred.stlouisfed.org/series/JTSJOL) [CIVPART](https://fred.stlouisfed.org/series/CIVPART#)



## Code

The results in the paper are obtained using Stata and R. The code is located in the code folder.

## Main script

The main script, run_all.do, orchestrates the production of the empirical results in the paper:

Cleans OLI demand and supply data (daily → monthly).

Processes BRW and HFI monetary policy shocks.

Merges OLI and monetary policy series into a single dataset.

Produces all regressions and local-projection estimates.

Generates figures and tables used in the paper.

Saves outputs as CSV, PDF, PNG, and Markdown files.

## Formatting script

Before computations begin, the main script calls:

00_setup.do – Install required Stata packages and define paths

format_figures.do – Preformat figure properties (fonts, sizes, colors)

## Production scripts

The main script generates results using a collection of scripts:

01_clean_oli.do – Clean and aggregate raw OLI demand & supply

02_clean_mp.do – Convert BRW & HFI shocks to monthly series

03_merge.do – Merge OLI data with monetary policy shocks

04_baseline.do – Estimate baseline regression models

05_lp.do – Estimate local projections and IRFs

06_figures.do – Produce figures for demand, supply, and occupation groups

07_tables.do – Produce summary statistics and regression tables

Each script displays results in Stata and saves files to the figures or tables folder.

## Helper functions (R)

Additional functions located in the helpers folder:

plot_irf.R – Plot impulse responses with confidence intervals

clean_month.R – Convert timestamps to year–month format

standardize_occ.R – Harmonize occupation definitions

compare_lm.R – Compare OLI responses with traditional labor market indicators
 
## Figures

The figures produced by the code are saved as PDF files.
The data used to generate the figures are saved as CSV files.
Associated numerical results are saved as Markdown files.
All files are located in the figures folder.

figure1_demand_irf.pdf, figure1_demand_irf.csv – IRF of online labor demand

figure1_supply_irf.pdf, figure1_supply_irf.csv – IRF of online labor supply

figure2_occupation_heterogeneity.pdf, figure2_occupation_heterogeneity.csv – Heterogeneous responses by occupation

figure3_traditional_comparison.pdf, figure3_traditional_comparison.csv – Comparison with unemployment, job openings, participation

figure4_alternative_shock_measures.pdf, figure4_alternative_shock_measures.csv – BRW vs. HFI results

figure5_pre_post_pandemic.pdf, figure5_pre_post_pandemic.csv – Differences in responses pre- and post-2020

Additional figures generated in robustness checks are saved in subfolders.





## Software

The results were obtained using: Stata 17 MP and R 4.2.3 on macOS Sequoia (Apple silicon).
