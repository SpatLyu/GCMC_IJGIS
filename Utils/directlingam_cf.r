if (!requireNamespace("reticulate")) install.packages("reticulate")
reticulate::py_require("lingam")

run_directlingam = \(df){
  lingam = reticulate::import("lingam")
  mdl = lingam$DirectLiNGAM()
  mdl$fit(df)
  cfm = mdl$adjacency_matrix_
  colnames(cfm) = rownames(cfm) = names(df)
  cfp = mdl$get_error_independence_p_values(df)
  colnames(cfp) = rownames(cfp) = names(df)
  directlingam = list("cfm" = cfm, "cfp" = cfp)
  return(directlingam)
}
