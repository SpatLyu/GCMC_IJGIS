#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~        Case: Farmland NPP In China       ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(spEDM)
npp = terra::rast('./Case of net primary productivity study/npp.tif')
npp

terra::global(npp,"isNA")
terra::ncell(npp)

nnamat = terra::as.matrix(npp[[1]], wide = TRUE)
nnaindice = which(!is.na(nnamat), arr.ind = TRUE)
dim(nnaindice)

#-----------------------------------------------------------------------------#
#------            Determining minimum embedding dimension              ------#
#-----------------------------------------------------------------------------#

spEDM::fnn(npp, "npp", E = 1:25,
           eps = stats::sd(terra::values(npp[["npp"]]),na.rm = TRUE))

#------------------------------------------------------------------------------#
#------    Causation by Geographical Cross Mapping Cardinality (GCMC)    ------#
#------------------------------------------------------------------------------#

ceiling(sqrt(5 * dim(nnaindice)[1]))

# precipitation and npp
g1 = spEDM::gcmc(npp, "pre", "npp", E = 5, k = 144)
g1

# temperature and npp
g2 = spEDM::gcmc(npp, "tem", "npp", E = 5, k = 144)
g2

# precipitation and temperature
g3 = spEDM::gcmc(npp, "pre", "tem", E = 5, k = 144)
g3

gcmc_case3 = list(g1,g2,g3)
readr::write_rds(gcmc_case3,'./Case of net primary productivity study/gcmc_case3.rds')

#------------------------------------------------------------------------------#
#------    Causation by Geographical Convergent Cross Mapping (GCCM)     ------#
#------------------------------------------------------------------------------#

# precipitation and npp
g1 = spEDM::gccm(npp, "pre", "npp", E = 5, k = 7)
g1

# temperature and npp
g2 = spEDM::gccm(npp, "tem", "npp", E = 5, k = 7)
g2

# precipitation and temperature
g3 = spEDM::gccm(npp, "pre", "tem", E = 5, k = 7)
g3

gccm_case3 = list(g1,g2,g3)
readr::write_rds(gccm_case3,'./Case of net primary productivity study/gccm_case3.rds')

#------------------------------------------------------------------------------#
#------       Correlation by Pearson Correlation Coefficient (PCC)       ------#
#------------------------------------------------------------------------------#

npp.df = terra::as.data.frame(npp,na.rm = TRUE)
pcc = psych::corr.test(npp.df)
pcc
readr::write_rds(pcc,'./Case of net primary productivity study/pcc_case3.rds')

#-----------------------------------------------------------------------------#
#------                  Causation by Direct LiNGAM                     ------#
#-----------------------------------------------------------------------------#

source('./Utils/directlingam_cf.r')

directlingam = run_directlingam(npp.df)
readr::write_rds(directlingam,'./Case of net primary productivity study/directlingam_case3.rds')

#------------------------------------------------------------------------------#
#------            Association by Geographical Detector (GD)             ------#
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
  pcc = readr::read_rds("./Case of net primary productivity study/pcc_case3.rds")[c("r","p")] |>
    .convert_result_list2df(),
  directlingam = readr::read_rds("./Case of net primary productivity study/directlingam_case3.rds") |>
    .convert_result_list2df(),
  gd = readr::read_rds("./Case of net primary productivity study/gd_case3.rds") |>
    dplyr::select(cause = x, effect = y, cs = qv, sig)
)
case3

writexl::write_xlsx(case3,"./Case of net primary productivity study/Case of net primary productivity study.xlsx")
