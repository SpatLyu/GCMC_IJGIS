.process_xmap_result = \(g,gcmc = TRUE){
  tempdf = g$xmap
  tempdf$x = g$varname[1]
  tempdf$y = g$varname[2]
  tempdf = dplyr::select(tempdf, 1, x, y,
                         x_xmap_y_mean,x_xmap_y_sig,
                         y_xmap_x_mean,y_xmap_x_sig,
                         dplyr::everything())
  
  if(!gcmc){
    tempdf = dplyr::slice_tail(tempdf,n = 1)
  }
  
  g1 = tempdf |> 
    dplyr::select(x,y,y_xmap_x_mean,y_xmap_x_sig)|> 
    purrr::set_names(c("cause","effect","ca","sig"))
  g2 = tempdf |> 
    dplyr::select(y,x,x_xmap_y_mean,x_xmap_y_sig) |> 
    purrr::set_names(c("cause","effect","ca","sig"))
  
  return(rbind(g1,g2))
}

.process_pcc_result = \(g){
  pcc_v = g |> 
    purrr::pluck("r") |> 
    as.data.frame() |> 
    tibble::rownames_to_column(var = "cause") |> 
    tidyr::pivot_longer(cols = -1,
                        names_to = "effect",
                        values_to = "ca") |> 
    dplyr::filter(cause != effect)
  pcc_p = g |> 
    purrr::pluck("p") |> 
    as.data.frame() |> 
    tibble::rownames_to_column(var = "cause") |> 
    tidyr::pivot_longer(cols = -1,
                        names_to = "effect",
                        values_to = "sig") |> 
    dplyr::filter(cause != effect)
  return(dplyr::left_join(pcc_v,pcc_p,
                          by = c("cause","effect")))
}