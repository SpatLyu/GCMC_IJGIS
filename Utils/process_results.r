if (!requireNamespace("purrr")) install.packages("purrr")
if (!requireNamespace("tibble")) install.packages("tibble")
if (!requireNamespace("tidyr")) install.packages("tidyr")
if (!requireNamespace("dplyr")) install.packages("dplyr")

.process_xmap_result = \(g,gcmc = TRUE){
  tempdf = g$xmap
  tempdf$x = g$varname[1]
  tempdf$y = g$varname[2]
  tempdf = dplyr::select(tempdf, 1, x, y,
                         x_xmap_y_mean, x_xmap_y_sig,
                         y_xmap_x_mean, y_xmap_x_sig,
                         dplyr::everything())
  
  if(!gcmc){
    tempdf = dplyr::slice_tail(tempdf, n = 1)
  }
  
  g1 = tempdf |> 
    dplyr::select(x, y, y_xmap_x_mean, y_xmap_x_sig)|> 
    purrr::set_names(c("cause", "effect", "cs", "sig"))
  g2 = tempdf |> 
    dplyr::select(y, x, x_xmap_y_mean, x_xmap_y_sig) |> 
    purrr::set_names(c("cause", "effect", "cs", "sig"))
  
  return(rbind(g1, g2))
}

.convert_result_list2df = \(l){
  cf_val = l |> 
    purrr::pluck(1) |> 
    as.data.frame() |> 
    tibble::rownames_to_column(var = "effect") |> 
    tidyr::pivot_longer(cols = -1,
                        names_to = "cause",
                        values_to = "cs") |> 
    dplyr::filter(cause != effect)
  cf_p = l |> 
    purrr::pluck(2) |> 
    as.data.frame() |> 
    tibble::rownames_to_column(var = "effect") |> 
    tidyr::pivot_longer(cols = -1,
                        names_to = "cause",
                        values_to = "sig") |> 
    dplyr::filter(cause != effect)
  res = cf_val |> 
    dplyr::left_join(cf_p, by = c("cause","effect")) |> 
    dplyr::select(cause, effect, dplyr::everything())
  return(res)
}
