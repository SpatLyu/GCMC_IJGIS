#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~     Discussing the sensitivity of GCMC to noice     ~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(spEDM)

popd_nb = spdep::read.gal('./Case of population density study/popd_nb.gal')
popd = readr::read_csv('./Case of population density study/popd.csv')

#------------------------------------------------------------------------------#
#------------------    Run GCMC on the synthetic dataset    -------------------#
#------------------------------------------------------------------------------#

set.seed(2025)
eta = rnorm(nrow(popd),0,1)
a = seq(0,1,by = 0.1)

s_popd = a |> 
  purrr::map_dfc(\(.a) (1+.a*eta)*popd$popd) |> 
  purrr::set_names(paste0("p","_",a))
s_elev = a |> 
  purrr::map_dfc(\(.a) (1+.a*eta)*popd$elev) |> 
  purrr::set_names(paste0("e","_",a))
popd_sf = popd |> 
  dplyr::select(elev,popd,x,y) |> 
  dplyr::bind_cols(s_popd) |> 
  dplyr::bind_cols(s_elev) |> 
  sf::st_as_sf(coords = c("x","y"), crs = 4326)
popd_sf

.run_gcmc_with_noise = \(x,y){
  x = rep(x,length.out = length(a))
  y = rep(y,length.out = length(a))
  res = data.frame()
  for (i in seq_along(a)) {
    g = gcmc(data = popd_sf, cause = x[i], effect = y[i],
             E = c(1,5), k = 210, nb = popd_nb, detrend = TRUE)
    
    tempdf = g$xmap |> 
      dplyr::select(x_xmap_y_mean,x_xmap_y_sig,
                    y_xmap_x_mean,y_xmap_x_sig) |> 
      dplyr::mutate(eta = a[i])
    res = rbind(res,tempdf)
  }
  return(res)
}

res1 = .run_gcmc_with_noise("elev",paste0("p","_",a))
res2 = .run_gcmc_with_noise(paste0("e","_",a),"popd")
res3 = .run_gcmc_with_noise(paste0("e","_",a),paste0("p","_",a))

writexl::write_xlsx(list("popd_noise" = res1,
                         "elev_noise" = res2,
                         "all_noise" = res3),
                    './Sensitivity analysis/Sensitivity analysis.xlsx')

noise_levels = paste0(a * 100, "% noise")
noise_levels[1] = "no noise"

.rearrange_noise_result = \(sheetname){
  res = readxl::read_xlsx('./result/sensitivity.xlsx',sheet = sheetname) |> 
    dplyr::select(eta,
                  `popd -> elev` = x_xmap_y_mean,
                  `elev -> popd` = y_xmap_x_mean) |> 
    dplyr::mutate(eta = noise_levels) |> 
    tidyr::pivot_longer(cols = 2:3, names_to = "direction",values_to = "cs") |> 
    tibble::rowid_to_column("id") |> 
    tidyr::pivot_wider(id_cols = direction,
                       names_from = eta,
                       values_from = cs)
  return(res)
}

res = purrr::map(paste0(c("elev","popd","all"),"_noise"),
                 .rearrange_noise_result) |> 
  purrr::set_names(paste0(c("elev","popd","all"),"_noise"))

writexl::write_xlsx(res,'./Sensitivity analysis/figure6.xlsx')
