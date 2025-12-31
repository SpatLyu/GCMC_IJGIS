# Reproducibility Instructions for GCMC

This repository provides all the necessary materials to **fully reproduce all findings** (figures and assessment metrics) reported in the manuscript on the **GCMC algorithm** submitted to *International Journal of Geographical Information Science (IJGIS)*.

The materials cover: 

- **Schematic Illustrations in Figures 1–3**
- **Synthetic Benchmark Experiment (Figure 4)** 
- **Case Study 1: Residential Crime (Figure 5)** 
- **Case Study 2: Population Density (Figure 6)** 
- **Case Study 3: Net Primary Productivity (Figure 7)** 
- **Noise Sensitivity Analysis (Figure 8)**

All reproduction workflows start from the **shared source data** in this repository and end with the **analysis/modeling outputs** and **visualizations** presented in the manuscript.

## Runtime Environment

The code has been tested and verified in the following environment:

-   **Operating System**: Windows 11
-   **R version**: 4.5.2
-   **spEDM version**: 1.9

To ensure full reproducibility, it is recommended to match the environment above as closely as possible.

## Directory Structure

The folder is organized by case studies and corresponding figures:

```
├── Spatial embedding                       # Related to Figure 1
│   |── spatial embedding.r
│   ├── henan.geojson
|   ├── *.png, *.pdf, etc.
|
├── Schematic diagram                       # Related to Figure 2,3
│   ├── intersectional cardinality.r 
│   |── schematic symbols.r
│   ├── hypothesis.r
|   ├── *.csv, *.png, *.pdf, etc.
|
├── Synthetic benchmark                     # Related to Figure 4
│   ├── Synthetic benchmark.r
|   ├── *.rds, *.pptx, *.pdf, etc.
|
├── Case of residential crime study         # Related to Figure 5
│   ├── Figure5.r
│   ├── Case of residential crime study.r
│   ├── columbus.gpkg
│   ├── *.rds, *.xlsx, *.png, *.pdf, etc.
│
├── Case of population density study        # Related to Figure 6
│   ├── Figure6.r
│   ├── Case of population density study.r
│   ├── popd.csv
│   ├── popd_nb.gal
│   ├── *.rds, *.xlsx, *.png, *.pdf, etc.
│
├── Case of net primary productivity study  # Related to Figure 7
│   ├── Figure7.r
│   ├── Case of net primary productivity study.r
│   ├── npp.tif
│   ├── *.rds, *.xlsx, *.png, *.pdf, etc.
│
├── Sensitivity analysis                    # Related to Figure 8
│   ├── Figure8.r
│   ├── Sensitivity analysis.r
│   ├── *.xlsx, *.png, *.pdf, etc.
│
├── Utils
│   ├── ssh_q.r
│   ├── directlingam_cf.r
│   ├── process_results.r
│   ├── plot_cs_matrix.r
│
├── GCMC_IJGIS.Rproj
```

## Required Packages

Please install the following packages before running the scripts:

``` r
install.packages(c("readxl", "writexl", "readr", "dplyr", "purrr",    
                   "tidyr", "tibble", "ggplot2", "scatterplot3d",      
                   "latex2exp", "sf", "terra", "tmap", "gdverse"))
devtools::install_github("ricardo-bion/ggradar", dependencies = TRUE)
install.packages("spEDM", dep = TRUE)
```

## Reproducibility Workflows

### General Instructions

1.  **Open `GCMC_IJGIS.Rproj`** in RStudio (recommended), or open the project root directory in Positron.

2.  All data paths in scripts are **relative paths** to ensure portability.

3.  Each folder contains:

    -   `Case ... .r` or `Synthetic benchmark.r`: **Complete workflow script** (from raw data → preprocessing → GCMC modeling → metric computation → saving results).
    -   `FigureX.r`: **Plotting script only** (loads `.xlsx` results and produces the figure).

4.  To **fully reproduce** findings, run the workflow script first, then the corresponding `FigureX.r`. To **quickly reproduce plots only**, run `FigureX.r` directly (using precomputed `.xlsx` results).

------------------------------------------------------------------------

### Synthetic Benchmark (Figure 4)

**Workflow**:

1.  Run benchmark simulation (`Synthetic benchmark.r`).
2.  Save results (`.rds`).
3.  Summarize metrics (causal strength and significance.).
4.  Visualize benchmark results with PowerPoint.

**Reproduce with**:

``` r
source("Synthetic benchmark/Synthetic benchmark.r")
```

------------------------------------------------------------------------

### Case Study 1: Residential Crime (Figure 5)

**Workflow**:

1.  Load spatial data (`columbus.gpkg`).
2.  Apply comparative models and our gcmc model.
3.  Save model outputs (stored in `.rds` and `.xlsx`).
4.  Compute assessment metrics (causal strength and significance).
5.  Plot final results using `Figure5.r`.

**Reproduce with**:

``` r
source("Case of residential crime study/Case of residential crime study.r")
source("Case of residential crime study/Figure5.r")
```

------------------------------------------------------------------------

### Case Study 2: Population Density (Figure 6)

**Workflow**:

1.  Load CSV (`popd.csv`) and spatial weights (`popd_nb.gal`).
2.  Preprocess spatial neighbor.
3.  Apply comparative models and our gcmc model.
4.  Save model outputs.
5.  Compute reported metrics.
6.  Plot results using `Figure6.r`.

**Reproduce with**:

``` r
source("Case of population density study/Case of population density study.r")
source("Case of population density study/Figure6.r")
```

------------------------------------------------------------------------

### Case Study 3: Net Primary Productivity (Figure 7)

**Workflow**:

1.  Load raster data (`npp.tif`).
2.  Extract values, preprocess for nan values.
3.  Apply comparative models and our gcmc model.
4.  Save outputs.
5.  Compute performance metrics.
6.  Plot results (Figure 7).

**Reproduce with**:

``` r
source("Case of net primary productivity study/Case of net primary productivity study.r")
source("Case of net primary productivity study/Figure7.r")
```

------------------------------------------------------------------------

### Sensitivity Analysis (Figure 8)

**Workflow**:

1.  Load simulation inputs (from shared `.xlsx`).
2.  Perform noise perturbation experiments.
3.  Run GCMC with perturbed datasets.
4.  Collect performance metrics under varying noise levels.
5.  Plot radar charts / sensitivity diagrams.

**Reproduce with**:

``` r
source("Sensitivity analysis/Sensitivity analysis.r")
source("Sensitivity analysis/Figure8.r")
```

------------------------------------------------------------------------

## Notes

-   **Intermediate `.rds` files** are included to allow faster reproduction. Running the full workflow scripts will regenerate them from raw data.
-   **Metrics** reported in Sections 3–4 of the manuscript are computed automatically in the workflow scripts and saved as `.xlsx` files.
-   **All paths are relative**, so no manual modification is required.
