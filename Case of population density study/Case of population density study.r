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
  sf::st_as_sf(coords = c("lon","lat"), crs = 4326) |> 
  dplyr::select(popd,elev,tem)
popd_sf

#-----------------------------------------------------------------------------#
#------            Determining minimum embedding dimension              ------#
#-----------------------------------------------------------------------------#

spEDM::fnn(popd_sf, "popd", E = 1:15, eps = stats::sd(popd_sf$popd))

#------------------------------------------------------------------------------#
#------    Causation by Geographical Cross Mapping Cardinality (GCMC)    ------#
#------------------------------------------------------------------------------#

ceiling(sqrt(11 * nrow(popd_sf)))

# temperature and population density
g1 = gcmc(popd_sf, "tem", "popd", E = 11, k = 176, nb = popd_nb)
g1

# elevation and population density
g2 = gcmc(popd_sf, "elev", "popd", E = 11, k = 176, nb = popd_nb)
g2

# elevation and temperature
g3 = gcmc(popd_sf, "elev", "tem", E = 11, k = 176, nb = popd_nb)
g3

gcmc_case2 = list(g1,g2,g3)
readr::write_rds(gcmc_case2,'./Case of population density study/gcmc_case2.rds')

#------------------------------------------------------------------------------#
#------    Causation by Geographical Convergent Cross Mapping (GCCM)     ------#
#------------------------------------------------------------------------------#

# temperature and population density
g1 = gccm(popd_sf, "tem", "popd", E = 11, k = 13, nb = popd_nb)
g1

# elevation and population density
g2 = gccm(popd_sf, "elev", "popd", E = 11, k = 13, nb = popd_nb)
g2

# elevation and temperature
g3 = gccm(popd_sf, "elev", "tem", E = 11, k = 13, nb = popd_nb)
g3

gccm_case2 = list(g1,g2,g3)
readr::write_rds(gccm_case2,'./Case of population density study/gccm_case2.rds')

#------------------------------------------------------------------------------#
#------       Correlation by Pearson Correlation Coefficient (PCC)       ------#
#------------------------------------------------------------------------------#

popdf = sf::st_drop_geometry(popd_sf)
pcc = psych::corr.test(popdf)
pcc
readr::write_rds(pcc,'./Case of population density study/pcc_case2.rds')

#-----------------------------------------------------------------------------#
#------                  Causation by Direct LiNGAM                     ------#
#-----------------------------------------------------------------------------#

source('./Utils/directlingam_cf.r')

directlingam = run_directlingam(popdf)
readr::write_rds(directlingam,'./Case of population density study/directlingam_case2.rds')

#------------------------------------------------------------------------------#
#------            Association by Geographical Detector (GD)             ------#
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
  pcc = readr::read_rds("./Case of population density study/pcc_case2.rds")[c("r","p")] |>
    .convert_result_list2df(),
  directlingam = readr::read_rds("./Case of population density study/directlingam_case2.rds") |>
    .convert_result_list2df(),
  gd = readr::read_rds("./Case of population density study/gd_case2.rds") |>
    dplyr::select(cause = x, effect = y, cs = qv, sig)
)
case2

writexl::write_xlsx(case2,"./Case of population density study/Case of population density study.xlsx")
