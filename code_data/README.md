# The Impact of Monetary Policy Shocks on Online Labor Markets – Code and Data

This repository contains the code and data about the paper "The Impact of Monetary Policy Shocks on Online Labor Markets", written by Suyu Liu.

## Paper webpage

The paper will be available at: 

## Raw data

The raw data used by the code to produce the results in the paper are stored as CSV or txt files in the `raw` folder.

+ `oli_demand_daily.txt.zip` – Daily OLI buyer-demand counts by occupation and country, 2016–2023
    + Source: [Online Labor Observatory (2024)](https://figshare.com/articles/dataset/Online_Labour_Index_Measuring_the_Online_Gig_Economy_for_Policy_and_Research/3761562?file=48931042)
+ `oli_supply_daily.txt` – Daily OLI worker-supply counts by occupation and country, 2016–2023
    + Source: [Online Labor Observatory (2024)](https://figshare.com/articles/dataset/Online_Labour_Index_Measuring_the_Online_Gig_Economy_for_Policy_and_Research/3761562?file=48931072)
+ `brw_shocks.csv` – High-frequency monetary policy shocks developed by Bu, Rogers, and Wu (2021) 
    + Source: [Bu, Rogers, and Wu (2021)](https://drive.google.com/file/d/1hYeeyY9okFhQz6yXmWdzQc7oaJJKYmVg/view)
+ `mps_shocks.csv` – high-frequency Monetary policy shocks developed by [Bauer and Swanson (2023)](https://www.journals.uchicago.edu/doi/10.1086/723574)
    + Source: [Federal Reserve Bank of San Francisco](https://www.frbsf.org/research-and-insights/data-and-indicators/monetary-policy-surprises/)
+ `UNRATE.csv` – US unemployment, 2000–2023
   + Source: BLS (2024) - [UNRATE](https://fred.stlouisfed.org/series/UNRATE)  
+ `JTSJOL.csv`  -  US job openings, 2000–2023
   + Source: BLS (2024) - [JTSJOL](https://fred.stlouisfed.org/series/JTSJOL)
+ `CIVPART.csv`- US labor force participation rate, 2000–2023
   + Source: BLS (2024) - [CIVPART](https://fred.stlouisfed.org/series/CIVPART#)


## Code

The results in the paper are obtained using Stata and R. The code is located in the `code` folder.

+ Cleans OLI demand and supply data (daily → monthly) `clean oli data.r`
+ Processes BRW and HFI monetary policy shocks `clean shocks.r`
+ Merges OLI and monetary policy series into a single dataset `merge.r`
+ Produces all regressions `baseline_regressions.do`

### Generates figures used in the paper

+ `figure1.do` - Produce `figure1.pdf`
+ `figure2a.do` - Produce panel A of `figure2a.pdf`
+ `figure2b.do` - Produce panel B of `figure2b.pdf`
+ `figure2c.do` - Produce panel C of `figure2c.pdf`
+ `figure2d.do` - Produce panel D of `figure2d.pdf`
+ `figure3.do` - Produce panel A of `figure3a.pdf`
+ `figure3.do` - Produce panel B of `figure3b.pdf`
+ `figure3.do` - Produce panel C of `figure3c.pdf`
+ `figure3.do` - Produce panel D of `figure3d.pdf`
+ `figure3.do` - Produce panel E of `figure3e.pdf`
 
## Figures

The figures produced by the code are saved as PDF files. All files are located in the figures folder.

## Software

The results were obtained using: Stata 18 MP and R 4.2.3 on macOS Sequoia (Apple silicon).
