#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~        Case: Farmland NPP In China       ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(spEDM)
npp = terra::rast('./Case of net primary productivity study/npp.tif')
# To save the computation time, we will aggregate the data by 3 times and 
# select 1500 non-NA pixels to predict:
npp = terra::aggregate(npp, fact = 3, na.rm = TRUE)
npp = npp[[c("npp","pre","tem")]]
npp

terra::global(npp,"isNA")
terra::ncell(npp)

nnamat = terra::as.matrix(npp[[1]], wide = TRUE)
nnaindice = which(!is.na(nnamat), arr.ind = TRUE)
dim(nnaindice)

set.seed(2025)
indices = sample(nrow(nnaindice), size = 1500, replace = FALSE)
libindice = nnaindice[-indices,]
predindice = nnaindice[indices,]

#------------------------------------------------------------------------------#
#------    Causality by Geographical Cross Mapping Cardinality (GCMC)    ------#
#------------------------------------------------------------------------------#

fnn(npp, "npp", E = 1:15, lib = predindice, pred = predindice,
    eps = stats::sd(terra::values(npp[["npp"]]),na.rm = TRUE) / 10)

# precipitation and npp
g1 = gcmc(npp, "pre", "npp", E = 3, k = 350, lib = predindice, pred = predindice)
g1

# temperature and npp
g2 = gcmc(npp, "tem", "npp", E = 3, k = 350, lib = predindice, pred = predindice)
g2

# precipitation and temperature
g3 = gcmc(npp, "pre", "tem", E = 3, k = 350, lib = predindice, pred = predindice)
g3

gcmc_case3 = list(g1,g2,g3)
readr::write_rds(gcmc_case3,'./Case of net primary productivity study/gcmc_case3.rds')

#------------------------------------------------------------------------------#
#------    Causality by Geographical Convergent Cross Mapping (GCCM)     ------#
#------------------------------------------------------------------------------#

# precipitation and npp
g1 = gccm(npp, "pre", "npp", E = 3, k = 5, lib = predindice, pred = predindice)
g1

# temperature and npp
g2 = gccm(npp, "tem", "npp", E = 3, k = 5, lib = predindice, pred = predindice)
g2

# precipitation and temperature
g3 = gccm(npp, "pre", "tem", E = 3, k = 5, lib = predindice, pred = predindice)
g3

gccm_case3 = list(g1,g2,g3)
readr::write_rds(gccm_case3,'./Case of net primary productivity study/gccm_case3.rds')

#------------------------------------------------------------------------------#
#------        Correlation by Pearson Correlation Coefficient(PCC)       ------#
#------------------------------------------------------------------------------#

npp.df = dplyr::filter(npp[terra::cellFromRowCol(npp,predindice[,1],predindice[,2])],
                       dplyr::if_all(dplyr::everything(),
                                     \(.x) !is.na(.x)))
pcc = psych::corr.test(npp.df)
pcc
readr::write_rds(pcc,'./Case of net primary productivity study/pcc_case3.rds')

#------------------------------------------------------------------------------#
#------             Association by Geographical Detector(GD)             ------#
#------------------------------------------------------------------------------#

source('./Utils/ssh_q.r')

q1 = ssh_q(data = npp.df,cause = "pre",effect = "npp")
q2 = ssh_q(data = npp.df,cause = "tem",effect = "npp")
q3 = ssh_q(data = npp.df,cause = "pre",effect = "tem")
qv = do.call(rbind,list(q1,q2,q3))
qv
readr::write_rds(qv,'./Case of net primary productivity study/gd_case3.rds')

#------------------------------------------------------------------------------#
#------                   Handling the case results                      ------#
#------------------------------------------------------------------------------#

source('./Utils/process_results.r')

case3 = list(
  gcmc = readr::read_rds("./Case of net primary productivity study/gcmc_case3.rds") |> 
    purrr::map(.process_xmap_result) |> 
    purrr::list_rbind(),
  gccm = readr::read_rds("./Case of net primary productivity study/gccm_case3.rds") |> 
    purrr::map(.process_xmap_result,gcmc = FALSE) |> 
    purrr::list_rbind(),
  pcc = readr::read_rds("./Case of net primary productivity study/pcc_case3.rds") |>
    .process_pcc_result(),
  gd = readr::read_rds("./Case of net primary productivity study/gd_case3.rds") |>
    dplyr::select(cause = x, effect = y, ca = qv, sig)
)
case3

writexl::write_xlsx(case3,"./Case of net primary productivity study/Case of net primary productivity study.xlsx")
