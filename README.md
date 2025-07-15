# Reproducibility Instructions for GCMC

This repository provides all the necessary materials to reproduce **Figures 4–7** from the manuscript on the **GCMC algorithm** submitted to *International Journal of Geographical Information Science (IJGIS)*.

## Runtime Environment

The code has been tested and verified in the following environment:

- **Operating System**: Ubuntu 22.04  
- **R version**: 4.4.3  
- **spEDM version**: 1.8  

To ensure full reproducibility, it is recommended to match the environment above as closely as possible.

## Directory Structure

The folder is organized by case studies and corresponding figures:

```
├── Case of residential crime study         # Related to Figure 4
│   ├── Figure4.r
│   ├── Case of residential crime study.r
│   ├── columbus.gpkg
│   ├── *.rds, *.xlsx, etc.
│
├── Case of population density study        # Related to Figure 5
│   ├── Figure5.r
│   ├── Case of population density study.r
│   ├── popd.csv
│   ├── popd_nb.gal
│   ├── *.rds, *.xlsx, etc.
│
├── Case of net primary productivity study  # Related to Figure 6
│   ├── Figure6.r
│   ├── Case of net primary productivity study.r
│   ├── npp.tif
│   ├── *.rds, *.xlsx, etc.
│
├── Sensitivity analysis                    # Related to Figure 7
│   ├── Figure7.r
│   ├── Sensitivity analysis.r
│   ├── *.xlsx, etc.
│
├── Synthetic benchmark
│   ├── Synthetic benchmark.r
|   ├── *.rds, etc.
|
├── Utils
│   ├── ssh_q.r
│   ├── process_results.r
│   ├── plot_cs_matrix.r
│
├── GCMC_IJGIS.Rproj
```

## How to Reproduce the Figures

1. **Open `GCMC_IJGIS.Rproj`** in RStudio (optional but recommended).
2. **Install the required packages** (if not already installed):

   ```r
   install.packages(c("readxl", "writexl", "readr", "dplyr", "purrr", "tibble", "ggplot2"))
   devtools::install_github("ricardo-bion/ggradar", dependencies = TRUE)
   install.packages(c("sf", "terra", "tmap", "sdsfun", "gdverse"))
   install.packages("spEDM",
                    repos = c("https://stscl.r-universe.dev",
                              "https://cloud.r-project.org"),
                    dep = TRUE)
   ```

3. **Run each script individually**:
   
   - Navigate to the folder for the corresponding figure.
   - Open and run the script named `FigureX.r` (X = 4, 5, 6, or 7).
   - Each script loads relevant data and outputs the figure.

## Notes

- This repository includes only the *input data*, *model execution scripts / results*, and *plotting scripts* necessary to reproduce the case study figures in the paper. The final figure outputs are not included.
- Intermediate .rds files store precomputed model results, allowing for faster reproduction of case study figures as presented in the manuscript.
- All scripts are self-contained and include inline comments that explain the main purpose of each code block for clarity and ease of understanding.
