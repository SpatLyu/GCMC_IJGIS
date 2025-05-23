#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~  Case: County Level Population Density In China  ~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(spEDM)

popd_nb = spdep::read.gal('./Case of population density study/popd_nb.gal')
popd = readr::read_csv('./Case of population density study/popd.csv')
popd_sf = popd |> 
  sf::st_as_sf(coords = c("x","y"), crs = 4326) |> 
  dplyr::select(popd,elev,tem)
popd_sf

#------------------------------------------------------------------------------#
#------    Causality by Geographical Cross Mapping Cardinality (GCMC)    ------#
#------------------------------------------------------------------------------#

# temperature and population density
g1 = gcmc(data = popd_sf, cause = "tem", effect = "popd",
          E = c(2,5), k = 210, nb = popd_nb, detrend = TRUE)
g1

# elevation and population density
g2 = gcmc(data = popd_sf, cause = "elev", effect = "popd",
          E = c(1,5), k = 210, nb = popd_nb, detrend = TRUE)
g2

# elevation and temperature
g3 = gcmc(data = popd_sf, cause = "elev", effect = "tem",
          E = c(1,2), k = 210, nb = popd_nb, detrend = TRUE)
g3 # When there are insignificant results, we set spEDM to suppress output. This is not a bug.
g3$xmap

gcmc_case2 = list(g1,g2,g3)
readr::write_rds(gcmc_case2,'./Case of population density study/gcmc_case2.rds')

#------------------------------------------------------------------------------#
#------    Causality by Geographical Convergent Cross Mapping (GCCM)     ------#
#------------------------------------------------------------------------------#

# temperature and population density
g1 = gccm(data = popd_sf, cause = "tem", effect = "popd",
          libsizes = seq(10, 2800, by = 100),E = c(2,5),k = 6,nb = popd_nb)
g1

# elevation and population density
g2 = gccm(data = popd_sf, cause = "elev", effect = "popd",
          libsizes = seq(10, 2800, by = 100),E = c(1,5),k = 6,nb = popd_nb)
g2

# elevation and temperature
g3 = gccm(data = popd_sf, cause = "elev", effect = "tem",
          libsizes = seq(10, 2800, by = 100),E = c(1,2),k = 6,nb = popd_nb)
g3

gccm_case2 = list(g1,g2,g3)
readr::write_rds(gccm_case2,'./Case of population density study/gccm_case2.rds')

#------------------------------------------------------------------------------#
#------        Correlation by Pearson Correlation Coefficient(PCC)       ------#
#------------------------------------------------------------------------------#

popdf = sf::st_drop_geometry(popd_sf)
pcc = psych::corr.test(popdf)
pcc
readr::write_rds(pcc,'./Case of population density study/pcc_case2.rds')

#------------------------------------------------------------------------------#
#------             Association by Geographical Detector(GD)             ------#
#------------------------------------------------------------------------------#

source('./Utils/ssh_q.r')

q1 = ssh_q(data = popdf, cause = "tem", effect = "popd")
q2 = ssh_q(data = popdf, cause = "elev", effect = "popd")
q3 = ssh_q(data = popdf, cause = "elev", effect = "tem")
qv = do.call(rbind,list(q1,q2,q3))
qv
readr::write_rds(qv,'./Case of population density study/gd_case2.rds')

#------------------------------------------------------------------------------#
#------                   Handling the case results                      ------#
#------------------------------------------------------------------------------#

source('./Utils/process_results.r')

case2 = list(
  gcmc = readr::read_rds("./Case of population density study/gcmc_case2.rds") |> 
    purrr::map(.process_xmap_result) |> 
    purrr::list_rbind(),
  gccm = readr::read_rds("./Case of population density study/gccm_case2.rds") |> 
    purrr::map(.process_xmap_result,gcmc = FALSE) |> 
    purrr::list_rbind(),
  pcc = readr::read_rds("./Case of population density study/pcc_case2.rds") |>
    .process_pcc_result(),
  gd = readr::read_rds("./Case of population density study/gd_case2.rds") |>
    dplyr::select(cause = x, effect = y, ca = qv, sig)
)
case2

writexl::write_xlsx(case2,"./Case of population density study/Case of population density study.xlsx")
