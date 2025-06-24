#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~      Case: Columbus,OH Housing Value     ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(spEDM)
columbus = sf::read_sf("./Case of residential crime study/columbus.gpkg")
columbus

#------------------------------------------------------------------------------#
#------    Causality by Geographical Cross Mapping Cardinality (GCMC)    ------#
#------------------------------------------------------------------------------#

fnn(columbus, "crime", E = 1:15)

# housing value and crime (residential burglaries and vehicle thefts)
g1 = gcmc(columbus,"hoval","crime", E = 7, k = 25)
g1

# household income and crime (residential burglaries and vehicle thefts)
g2 = gcmc(columbus,"inc","crime", E = 7, k = 25)
g2

# housing value and household income
g3 = gcmc(columbus,"hoval","inc", E = 7, k = 25)
g3

gcmc_case1 = list(g1,g2,g3)
readr::write_rds(gcmc_case1,'./Case of residential crime study/gcmc_case1.rds')

#------------------------------------------------------------------------------#
#------    Causality by Geographical Convergent Cross Mapping (GCCM)     ------#
#------------------------------------------------------------------------------#

# housing value and crime (residential burglaries and vehicle thefts)
g1 = gccm(columbus, "hoval", "crime",  E = 7, k = 9)
g1

# household income and crime (residential burglaries and vehicle thefts)
g2 = gccm(columbus, "inc", "crime", E = 7, k = 9)
g2

# housing value and household income
g3 = gccm(columbus, "hoval", "inc", E = 7, k = 9)
g3

gccm_case1 = list(g1,g2,g3)
readr::write_rds(gccm_case1,'./Case of residential crime study/gccm_case1.rds')

#------------------------------------------------------------------------------#
#------        Correlation by Pearson Correlation Coefficient(PCC)       ------#
#------------------------------------------------------------------------------#

columdf = sf::st_drop_geometry(dplyr::select(columbus,c(hoval,inc,crime)))
pcc = psych::corr.test(columdf)
pcc
readr::write_rds(pcc,'./Case of residential crime study/pcc_case1.rds')

#------------------------------------------------------------------------------#
#------             Association by Geographical Detector(GD)             ------#
#------------------------------------------------------------------------------#

source('./Utils/ssh_q.r')

q1 = ssh_q(data = columdf,cause = "hoval",effect = "crime")
q2 = ssh_q(data = columdf,cause = "inc",effect = "crime")
q3 = ssh_q(data = columdf,cause = "hoval",effect = "inc")
qv = do.call(rbind,list(q1,q2,q3))
qv
readr::write_rds(qv,'./Case of residential crime study/gd_case1.rds')

#------------------------------------------------------------------------------#
#------                   Handling the case results                      ------#
#------------------------------------------------------------------------------#

source('./Utils/process_results.r')

case1 = list(
  gcmc = readr::read_rds("./Case of residential crime study/gcmc_case1.rds") |> 
    purrr::map(.process_xmap_result) |> 
    purrr::list_rbind(),
  gccm = readr::read_rds("./Case of residential crime study/gccm_case1.rds") |> 
    purrr::map(.process_xmap_result,gcmc = FALSE) |> 
    purrr::list_rbind(),
  pcc = readr::read_rds("./Case of residential crime study/pcc_case1.rds") |>
    .process_pcc_result(),
  gd = readr::read_rds("./Case of residential crime study/gd_case1.rds") |>
    dplyr::select(cause = x, effect = y, ca = qv, sig)
)
case1

writexl::write_xlsx(case1,"./Case of residential crime study/Case of residential crime study.xlsx")
